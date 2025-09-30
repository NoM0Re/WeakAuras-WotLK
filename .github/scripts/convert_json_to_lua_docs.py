#!/usr/bin/env python3
"""
Convert a flat API description expressed as JSON into a collection of Lua
documentation files.  The input JSON is expected to resemble the structure
present in the provided ``generated_api.json`` file: a top‑level object
containing ``Functions`` and ``Events`` members.  ``Functions`` is a
dictionary keyed by high‑level categories; each value is a list of
function definitions.  ``Events`` is a flat list of event definitions.

The goal of this script is to emit, for each category, a standalone Lua
file describing all functions belonging to that category along with any
events that can be reasonably attributed to the category.  Any events
which cannot be assigned to a known category will be placed into a
separate ``UncategorizedEventsDocumentation.lua`` file.

Each generated file follows the schema used by Blizzard's API
documentation: a local table named after the category contains the
``Name``, ``Type``, ``Namespace``, ``Functions``, ``Events`` and
``Tables`` fields.  Arguments and return values for functions, along
with payload parameters for events, are faithfully reproduced from the
input.  Optional arguments (marked with an ``optional`` flag in the
JSON) become ``Nilable = true`` in the Lua output.

The mapping of events to categories is best‑effort.  An event will be
assigned to the first category whose sanitized name appears in the
sanitized event name.  Should no automatic match be found, a small
manual mapping based on common prefixes is consulted.  Remaining events
are considered uncategorized.

Example usage::

   python3 convert_json_to_lua_docs.py \
       --input /home/oai/share/generated_api.json \
       --output-dir /home/oai/share/generated_lua_docs

After running the script you can create a zip archive of the resulting
directory with ``zip -r converted_api_docs.zip generated_lua_docs``.

"""

import argparse
import json
import os
import re
import sys
from collections import defaultdict
from typing import Any, Dict, Iterable, List, Optional, Tuple


def sanitize_identifier(name: str) -> str:
    """Return a sanitized identifier suitable for Lua variable names.

    All non‑alphanumeric characters are removed and the first character
    is guaranteed not to be a digit by prepending an underscore if
    necessary.
    """
    # Remove non‑alphanumeric characters
    cleaned = re.sub(r"[^A-Za-z0-9]", "", name)
    # Prepend underscore if starts with digit or is empty
    if not cleaned or cleaned[0].isdigit():
        cleaned = f"_{cleaned}"
    return cleaned


def to_pascal_case(name: str) -> str:
    """Convert an arbitrary string into PascalCase.

    Splits the string on any non‑alphanumeric delimiter, lowercases each
    part, capitalizes the first character and then concatenates them
    together.
    """
    parts = re.split(r"[^A-Za-z0-9]+", name)
    parts = [p for p in parts if p]
    return "".join(part.lower().capitalize() for part in parts) or "Unnamed"


def lua_type_from_json(json_type: str) -> str:
    """Map a JSON type string into an appropriate Lua type for documentation.

    Known primitive types are converted to Blizzard conventions where
    possible.  Unknown types are returned unmodified.
    """
    t = json_type.lower()
    if t == "boolean":
        return "bool"
    if t == "string":
        # Use 'string' rather than 'cstring' as not all strings are cstrings
        return "string"
    if t == "number":
        return "number"
    # Tables, functions or other complex types are kept as provided
    return json_type


def assign_events_to_categories(
    events: List[Dict[str, Any]],
    categories: Iterable[str],
    manual_prefix_map: Optional[Dict[str, str]] = None,
) -> Tuple[Dict[str, List[Dict[str, Any]]], List[Dict[str, Any]]]:
    """Attempt to assign each event to one of the supplied categories.

    Returns a mapping of category names to lists of events as well as a
    list of events which could not be mapped.  Events are matched by
    searching for a sanitized version of the category name inside the
    sanitized event name.  If no match is found, the event name's
    prefix (text before the first underscore) is consulted against
    ``manual_prefix_map`` for a manual mapping.
    """
    cat_sanit: Dict[str, str] = {
        cat: re.sub(r"[^A-Z0-9]", "", cat.upper()) for cat in categories
    }

    mapping: Dict[str, List[Dict[str, Any]]] = defaultdict(list)
    unmapped: List[Dict[str, Any]] = []

    for event in events:
        name = event.get("name", "")
        sanitized_event = re.sub(r"[^A-Z0-9]", "", name.upper())
        matched_category: Optional[str] = None

        # First pass: match by substring or prefix
        possible: List[str] = []
        for cat, sc in cat_sanit.items():
            if not sc:
                continue
            # Check if the sanitized category is contained anywhere in
            # the sanitized event name (e.g. PLAYER in PLAYER_REGEN_ENABLED)
            # or vice versa (e.g. LFG in LOOKING_FOR_GROUP)
            if sc in sanitized_event or sanitized_event in sc:
                possible.append(cat)
        if possible:
            # Choose the category with the longest sanitized name to favour
            # the most specific match.
            matched_category = max(possible, key=lambda c: len(cat_sanit[c]))
        else:
            # Fallback: match by prefix against a manual map
            prefix = name.split("_")[0].upper()
            if manual_prefix_map:
                target = manual_prefix_map.get(prefix)
                if target:
                    matched_category = target

        if matched_category is not None:
            mapping[matched_category].append(event)
        else:
            unmapped.append(event)
    return mapping, unmapped


def generate_lua_for_category(
    category: str,
    funcs: List[Dict[str, Any]],
    events: List[Dict[str, Any]],
) -> str:
    """Render a single category's functions and events into Lua documentation."""
    var_name = to_pascal_case(category)
    # Construct header
    lines: List[str] = []
    lines.append(f"local {var_name} =")
    lines.append("{")
    lines.append(f"\tName = \"{category}\",")
    lines.append("\tType = \"System\",")
    lines.append("\tNamespace = \"\",\n")

    # Functions
    lines.append("\tFunctions =")
    lines.append("\t{")
    if funcs:
        for func in funcs:
            fname = func.get("name", "")
            args = func.get("arguments", [])
            returns = func.get("returns", [])
            lines.append("\t\t{")
            lines.append(f"\t\t\tName = \"{fname}\",")
            lines.append("\t\t\tType = \"Function\",\n")
            # Arguments block
            if args:
                lines.append("\t\t\tArguments =")
                lines.append("\t\t\t{")
                for arg in args:
                    arg_name = arg.get("name", "")
                    # Strip extraneous leading/trailing quotes from argument names
                    if isinstance(arg_name, str):
                        arg_name = arg_name.strip('"')
                    arg_type = lua_type_from_json(arg.get("type", ""))
                    nilable = "true" if arg.get("optional") else "false"
                    lines.append(
                        f"\t\t\t\t{{ Name = \"{arg_name}\", Type = \"{arg_type}\", Nilable = {nilable} }},"
                    )
                lines.append("\t\t\t},\n")
            # Returns block
            if returns:
                lines.append("\t\t\tReturns =")
                lines.append("\t\t\t{")
                for ret in returns:
                    ret_name = ret.get("name", "")
                    if isinstance(ret_name, str):
                        ret_name = ret_name.strip('"')
                    ret_type = lua_type_from_json(ret.get("type", ""))
                    lines.append(
                        f"\t\t\t\t{{ Name = \"{ret_name}\", Type = \"{ret_type}\", Nilable = false }},"
                    )
                lines.append("\t\t\t},")
            # Close function block
            lines.append("\t\t},")
    lines.append("\t},\n")

    # Events
    lines.append("\tEvents =")
    lines.append("\t{")
    if events:
        for event in events:
            ename = event.get("name", "")
            payload = event.get("payload", [])
            pascal_name = to_pascal_case(ename)
            lines.append("\t\t{")
            lines.append(f"\t\t\tName = \"{pascal_name}\",")
            lines.append("\t\t\tType = \"Event\",")
            lines.append(f"\t\t\tLiteralName = \"{ename}\",")
            # payload
            if payload:
                lines.append("\t\t\tPayload =")
                lines.append("\t\t\t{")
                for p in payload:
                    p_name = p.get("name", "")
                    if isinstance(p_name, str):
                        p_name = p_name.strip('"')
                    p_type = lua_type_from_json(p.get("type", ""))
                    nilable = "false"
                    # Some payload definitions might mark optional on the field
                    if p.get("optional"):
                        nilable = "true"
                    lines.append(
                        f"\t\t\t\t{{ Name = \"{p_name}\", Type = \"{p_type}\", Nilable = {nilable} }},"
                    )
                lines.append("\t\t\t},")
            # Close event block
            lines.append("\t\t},")
    lines.append("\t},\n")

    # Tables (none for this conversion)
    lines.append("\tTables =")
    lines.append("\t{")
    lines.append("\t},")
    lines.append("};\n")
    lines.append(f"APIDocumentation:AddDocumentationTable({var_name});\n")
    return "\n".join(lines)


def main(argv: Optional[List[str]] = None) -> None:
    parser = argparse.ArgumentParser(description="Generate Lua API docs from JSON")
    parser.add_argument(
        "--input",
        required=True,
        help="Path to the generated_api.json file",
    )
    parser.add_argument(
        "--output-dir",
        required=True,
        help="Directory in which to write the generated documentation files",
    )
    args = parser.parse_args(argv)

    # Load JSON
    with open(args.input, "r", encoding="utf-8") as f:
        data = json.load(f)

    # Ensure output directory exists
    os.makedirs(args.output_dir, exist_ok=True)
    doc_dir = os.path.join(args.output_dir, "Documentation")
    os.makedirs(doc_dir, exist_ok=True)

    function_categories: Dict[str, List[Dict[str, Any]]] = data.get("Functions", {})
    events: List[Dict[str, Any]] = data.get("Events", [])

    # Manual mapping from event prefixes to categories.  These
    # assignments help locate events that would otherwise remain
    # uncategorized.  The keys should be uppercase prefixes found
    # before the first underscore in the event name; the values are
    # category names as they appear in ``Functions``.
    manual_prefix_map = {
        "ADDON": "Addon-related",
        "BAG": "Container",
        "AREA": "Zone_information",
        "AUTOEQUIP": "Equipment_Manager",
        "AUTOFOLLOW": "Movement",
        "BANKFRAME": "Bank",
        "BARBER": "Barbershop",
        "BILLING": "Limited_play_time",
        "BIND": "Uncategorized",
        "BN": "Battle.net",
        "CHARACTER": "Player_information",
        "GOSSIP": "NPC_Gossip_Dialog",
        "EQUIPMENT": "Equipment_Manager",
        "MIRROR": "UIVisual",
        "MOVIE": "In-game_movie_playback",
        "READY": "Party",
        "ZONE": "Zone_information",
        "LFG": "Looking_for_group",
        "PLAYER": "Player_information",
        "CONFIRM": "Uncategorized",
        "CINEMATIC": "In-game_movie_playback",
        "CORPSE": "Uncategorized",
        "DISABLE": "Uncategorized",
        "ENABLE": "Uncategorized",
        "RUNE": "Uncategorized",
        "SCREENSHOT": "Uncategorized",
        "SOCKET": "Socketing",
        "TABARD": "UIVisual",
        "UI": "UIVisual",
        "UPDATE": "Uncategorized",
    }

    # Assign events to categories
    event_mapping, uncategorized_events = assign_events_to_categories(
        events, function_categories.keys(), manual_prefix_map=manual_prefix_map
    )

    # Generate a documentation file for each function category
    for cat, func_list in function_categories.items():
        cat_events = event_mapping.get(cat, [])
        lua_content = generate_lua_for_category(cat, func_list, cat_events)
        file_name = f"{to_pascal_case(cat)}Documentation.lua"
        file_path = os.path.join(doc_dir, file_name)
        with open(file_path, "w", encoding="utf-8") as out_f:
            out_f.write(lua_content)

    # If there are uncategorized events, write them to their own file
    if uncategorized_events:
        uncategorized_name = "UncategorizedEvents"
        lua_content = generate_lua_for_category(
            uncategorized_name, [], uncategorized_events
        )
        file_name = f"{to_pascal_case(uncategorized_name)}Documentation.lua"
        file_path = os.path.join(doc_dir, file_name)
        with open(file_path, "w", encoding="utf-8") as out_f:
            out_f.write(lua_content)

    print(
        f"Generated documentation for {len(function_categories)} categories with {len(events)} events."  # noqa: E501
    )


if __name__ == "__main__":
    main()