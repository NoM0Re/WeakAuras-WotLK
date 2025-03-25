if not WeakAuras.IsLibsOK() then return end
local AddonName = ...
local Private = select(2, ...)

local WeakAuras = WeakAuras
local L = WeakAuras.L

local SubscribableObject =
{
  events = {},
  subscribers = {},
  callbacks = {},

  ClearSubscribers = function(self)
    self.events = {}
    self.subscribers = {}
  end,

  ClearCallbacks = function(self)
    self.callbacks = {}
  end,

  AddSubscriber = function(self, event, subscriber, highPriority)
    if not subscriber[event] then
      print("Can't register for ", event, " ", subscriber, subscriber.type)
      return
    end

    self.events[event] = self.events[event] or {}
    self.subscribers[event] = self.subscribers[event] or {}
    if self.subscribers[event][subscriber] then
      -- Already subscribed, just return
      return
    end
    self.subscribers[event][subscriber] = true
    local pos = highPriority and 1 or (#self.events[event] + 1)
    if TableHasAnyEntries(self.events[event]) then
      tinsert(self.events[event], pos, subscriber)
    else
      tinsert(self.events[event], pos, subscriber)
      if self.callbacks[event] then
        self.callbacks[event]()
      end
    end
  end,

  RemoveSubscriber = function(self, event, subscriber)
    if self.events[event] then
      if not self.subscribers[event][subscriber] then
        -- Not subscribed
        return
      end

      self.subscribers[event][subscriber] = nil
      local index = tIndexOf(self.events[event], subscriber)
      if index then
        tremove(self.events[event], index)
        if not TableHasAnyEntries(self.events[event]) then
          if self.callbacks[event] then
            self.callbacks[event]()
          end
        end
      end
    end
  end,

  SetOnSubscriptionStatusChanged = function(self, event, cb)
    self.callbacks[event] = cb
  end,

  Notify = function(self, event, ...)
    if self.events[event] then
      for _, subscriber in ipairs(self.events[event]) do
        subscriber[event](subscriber, ...)
      end
    end
  end,

  HasSubscribers = function(self, event)
    return self.events[event] and TableHasAnyEntries(self.events[event])
  end
}

function Private.CreateSubscribableObject()
  return CopyTable(SubscribableObject)
end
