---@alias PoolCreationFunc fun(pool: ObjectPoolMixin): any
---@alias PoolResetterFunc fun(pool: ObjectPoolMixin, object: any)
---@alias FramePoolInitFunc fun(frame: Frame)

---@class ObjectPoolMixin
---@field creationFunc PoolCreationFunc
---@field resetterFunc? PoolResetterFunc
---@field activeObjects table<any, boolean>
---@field inactiveObjects any[]
---@field numActiveObjects number
---@field disallowResetIfNew? boolean
if ObjectPoolMixin then return end

--- @private
local Private = select(2, ...);

local assert = assert
local ipairs = ipairs
local next = next
local pairs = pairs
local tostring = tostring
local type = type
local Mixin = Private.Mixin
local CreateFromMixins = Private.CreateFromMixins
local nop = Private.noop

local StandardScriptHandlerSet = {
	OnLoad = true,
	OnShow = true,
	OnHide = true,
	OnEvent = true,
	OnEnter = true,
	OnLeave = true,
	OnClick = true,
	OnDragStart = true,
	OnReceiveDrag = true,
}

local function ReflectStandardScriptHandlers(frame)
	for scriptHandlerKey in pairs(StandardScriptHandlerSet) do
		local scriptHandler = frame[scriptHandlerKey]
		if scriptHandler ~= nil then
			frame:SetScript(scriptHandlerKey, scriptHandler)
		end
	end

	if frame.OnLoad then
		frame:OnLoad()
	end

	if frame.OnShow and frame:IsVisible() then
		frame:OnShow()
	end
end

local function SpecializeFrameWithMixins(frame, ...)
	Mixin(frame, ...)
	ReflectStandardScriptHandlers(frame)
end

-- Compatibility function if subLayer is skipped and resetterFunc is passed in its place.
local function AdjustRegionPoolParameters(subLayer, regionTemplate, resetterFunc)
	if resetterFunc == nil then
		if type(regionTemplate) == "function" then
			resetterFunc = regionTemplate;
			regionTemplate = subLayer;
			subLayer = nil;
		elseif regionTemplate == nil and type(subLayer) ~= "number" then
			regionTemplate = subLayer;
			subLayer = nil;
		end
	end

	return subLayer, regionTemplate, resetterFunc;
end

ObjectPoolMixin = {};

---@param creationFunc PoolCreationFunc
---@param resetterFunc? PoolResetterFunc
function ObjectPoolMixin:OnLoad(creationFunc, resetterFunc)
	self.creationFunc = creationFunc;
	self.resetterFunc = resetterFunc;
	self.activeObjects = {};
	self.inactiveObjects = {};
	self.numActiveObjects = 0;
end

---@return any object
---@return boolean new
function ObjectPoolMixin:Acquire()
	local numInactiveObjects = #self.inactiveObjects;
	if numInactiveObjects > 0 then
		local obj = self.inactiveObjects[numInactiveObjects];
		self.activeObjects[obj] = true;
		self.numActiveObjects = self.numActiveObjects + 1;
		self.inactiveObjects[numInactiveObjects] = nil;
		return obj, false;
	end

	local newObj = self.creationFunc(self);
	if self.resetterFunc and not self.disallowResetIfNew then
		self.resetterFunc(self, newObj);
	end
	self.activeObjects[newObj] = true;
	self.numActiveObjects = self.numActiveObjects + 1;
	return newObj, true;
end

---@param obj any
---@return boolean released
function ObjectPoolMixin:Release(obj)
	if self:IsActive(obj) then
		self.inactiveObjects[#self.inactiveObjects + 1] = obj;
		self.activeObjects[obj] = nil;
		self.numActiveObjects = self.numActiveObjects - 1;
		if self.resetterFunc then
			self.resetterFunc(self, obj);
		end

		return true;
	end

	return false;
end

function ObjectPoolMixin:ReleaseAll()
	for obj in pairs(self.activeObjects) do
		self:Release(obj);
	end
end

---@param disallowed boolean
function ObjectPoolMixin:SetResetDisallowedIfNew(disallowed)
	self.disallowResetIfNew = disallowed;
end

function ObjectPoolMixin:EnumerateActive()
	return pairs(self.activeObjects);
end

---@param current? any
---@return any object
function ObjectPoolMixin:GetNextActive(current)
	return (next(self.activeObjects, current));
end

---@param current? any
---@return any object
function ObjectPoolMixin:GetNextInactive(current)
	local currentIndex = nil;
	if current then
		for index, object in ipairs(self.inactiveObjects) do
			if object == current then
				currentIndex = index;
				break;
			end
		end
	end
	local _, object = next(self.inactiveObjects, currentIndex);
	return object;
end

---@param object any
---@return boolean
function ObjectPoolMixin:IsActive(object)
	return (self.activeObjects[object] ~= nil);
end

---@return number
function ObjectPoolMixin:GetNumActive()
	return self.numActiveObjects;
end

function ObjectPoolMixin:EnumerateInactive()
	return ipairs(self.inactiveObjects);
end

---@param creationFunc PoolCreationFunc
---@param resetterFunc? PoolResetterFunc
---@return ObjectPoolMixin
function CreateObjectPool(creationFunc, resetterFunc)
	local objectPool = CreateFromMixins(ObjectPoolMixin);
	objectPool:OnLoad(creationFunc, resetterFunc);
	return objectPool;
end

---@class FramePoolMixin : ObjectPoolMixin
---@field frameType string
---@field parent Frame
---@field frameTemplate? string
FramePoolMixin = CreateFromMixins(ObjectPoolMixin);

local function FramePoolFactory(framePool)
	return CreateFrame(framePool.frameType, nil, framePool.parent, framePool.frameTemplate);
end

local function ForbiddenFramePoolFactory(framePool)
	return CreateForbiddenFrame(framePool.frameType, nil, framePool.parent, framePool.frameTemplate);
end

---@param frameType string
---@param parent Frame
---@param frameTemplate? string
---@param resetterFunc? PoolResetterFunc
---@param forbidden? boolean
---@param frameInitFunc? FramePoolInitFunc
function FramePoolMixin:OnLoad(frameType, parent, frameTemplate, resetterFunc, forbidden, frameInitFunc)
	if forbidden then
		local creationFunc = ForbiddenFramePoolFactory;
		if frameInitFunc ~= nil then
			creationFunc = function(framePool)
				local frame = CreateForbiddenFrame(framePool.frameType, nil, framePool.parent, framePool.frameTemplate);
				frameInitFunc(frame);
				return frame;
			end
		end
		ObjectPoolMixin.OnLoad(self, creationFunc, resetterFunc);
	else
		local creationFunc = FramePoolFactory;
		if frameInitFunc ~= nil then
			creationFunc = function(framePool)
				local frame = CreateFrame(framePool.frameType, nil, framePool.parent, framePool.frameTemplate);
				frameInitFunc(frame);
				return frame;
			end
		end
		ObjectPoolMixin.OnLoad(self, creationFunc, resetterFunc);
	end
	self.frameType = frameType;
	self.parent = parent;
	self.frameTemplate = frameTemplate;
end

function FramePoolMixin:GetTemplate()
	return self.frameTemplate;
end

function FramePool_Hide(framePool, frame)
	frame:Hide();
end

function FramePool_HideAndClearAnchors(framePool, frame)
	frame:Hide();
	frame:ClearAllPoints();
end

---@param frameType string
---@param parent Frame
---@param frameTemplate? string
---@param resetterFunc? PoolResetterFunc
---@param forbidden? boolean
---@param frameInitFunc? FramePoolInitFunc
---@return FramePoolMixin
function CreateFramePool(frameType, parent, frameTemplate, resetterFunc, forbidden, frameInitFunc)
	local framePool = CreateFromMixins(FramePoolMixin);
	framePool:OnLoad(frameType, parent, frameTemplate, resetterFunc or FramePool_HideAndClearAnchors, forbidden, frameInitFunc);
	return framePool;
end

---@class TexturePoolMixin : ObjectPoolMixin
---@field parent Frame
---@field layer? string
---@field subLayer? number
---@field textureTemplate? string
TexturePoolMixin = CreateFromMixins(ObjectPoolMixin);

local function TexturePoolFactory(texturePool)
	return texturePool.parent:CreateTexture(nil, texturePool.layer, texturePool.textureTemplate, texturePool.subLayer);
end

---@param parent Frame
---@param layer? string
---@param subLayer? number
---@param textureTemplate? string
---@param resetterFunc? PoolResetterFunc
function TexturePoolMixin:OnLoad(parent, layer, subLayer, textureTemplate, resetterFunc)
	ObjectPoolMixin.OnLoad(self, TexturePoolFactory, resetterFunc);
	self.parent = parent;
	self.layer = layer;
	self.subLayer = subLayer;
	self.textureTemplate = textureTemplate;
end

TexturePool_Hide = FramePool_Hide;
TexturePool_HideAndClearAnchors = FramePool_HideAndClearAnchors;

---@param parent Frame
---@param layer? string
---@param subLayer? number|string|PoolResetterFunc
---@param textureTemplate? string|PoolResetterFunc
---@param resetterFunc? PoolResetterFunc
---@return TexturePoolMixin
function CreateTexturePool(parent, layer, subLayer, textureTemplate, resetterFunc)
	subLayer, textureTemplate, resetterFunc = AdjustRegionPoolParameters(subLayer, textureTemplate, resetterFunc);
	local texturePool = CreateFromMixins(TexturePoolMixin);
	texturePool:OnLoad(parent, layer, subLayer, textureTemplate, resetterFunc or TexturePool_HideAndClearAnchors);
	return texturePool;
end

---@class FontStringPoolMixin : ObjectPoolMixin
---@field parent Frame
---@field layer? string
---@field subLayer? number
---@field fontStringTemplate? string
FontStringPoolMixin = CreateFromMixins(ObjectPoolMixin);

local function FontStringPoolFactory(fontStringPool)
	return fontStringPool.parent:CreateFontString(nil, fontStringPool.layer, fontStringPool.fontStringTemplate, fontStringPool.subLayer);
end

---@param parent Frame
---@param layer? string
---@param subLayer? number
---@param fontStringTemplate? string
---@param resetterFunc? PoolResetterFunc
function FontStringPoolMixin:OnLoad(parent, layer, subLayer, fontStringTemplate, resetterFunc)
	ObjectPoolMixin.OnLoad(self, FontStringPoolFactory, resetterFunc);
	self.parent = parent;
	self.layer = layer;
	self.subLayer = subLayer;
	self.fontStringTemplate = fontStringTemplate;
end

FontStringPool_Hide = FramePool_Hide;
FontStringPool_HideAndClearAnchors = FramePool_HideAndClearAnchors;

---@param parent Frame
---@param layer? string
---@param subLayer? number|string|PoolResetterFunc
---@param fontStringTemplate? string|PoolResetterFunc
---@param resetterFunc? PoolResetterFunc
---@return FontStringPoolMixin
function CreateFontStringPool(parent, layer, subLayer, fontStringTemplate, resetterFunc)
	subLayer, fontStringTemplate, resetterFunc = AdjustRegionPoolParameters(subLayer, fontStringTemplate, resetterFunc);
	local fontStringPool = CreateFromMixins(FontStringPoolMixin);
	fontStringPool:OnLoad(parent, layer, subLayer, fontStringTemplate, resetterFunc or FontStringPool_HideAndClearAnchors);
	return fontStringPool;
end

---@class FramePoolCollectionMixin
---@field pools table<string, ObjectPoolMixin>
FramePoolCollectionMixin = {};

---@return FramePoolCollectionMixin
function CreateFramePoolCollection()
	local poolCollection = CreateFromMixins(FramePoolCollectionMixin);
	poolCollection:OnLoad();
	return poolCollection;
end

-- If different frames are used for specialized cases even though they have the same template,
-- supply a specialization key to differentiate. If specialization is a function, it will be
-- called the first time a frame is acquired. If specialization is a table, it will be mixed
-- in with FrameUtil.SpecializeFrameWithMixins.
local function FramePoolCollection_GetPoolKey(template, specialization)
	return tostring(template)..tostring(specialization);
end

local function FramePoolCollection_GetSpecializedFrameInit(specialization)
	local specializationType = type(specialization);
	if specializationType == "function" then
		return specialization;
	elseif specializationType == "table" then
		local function SpecializationFrameInit(frame)
			SpecializeFrameWithMixins(frame, specialization);
		end
		return SpecializationFrameInit;
	end
	return nil;
end

function FramePoolCollectionMixin:OnLoad()
	self.pools = {};
end

---@return number
function FramePoolCollectionMixin:GetNumActive()
	local numTotalActive = 0;
	for _, pool in pairs(self.pools) do
		numTotalActive = numTotalActive + pool:GetNumActive();
	end
	return numTotalActive;
end

-- Returns the pool, and whether or not the pool needed to be created.
---@param frameType string
---@param parent Frame
---@param template? string
---@param resetterFunc? PoolResetterFunc
---@param forbidden? boolean
---@param specialization? function|table
---@return FramePoolMixin pool
---@return boolean new
function FramePoolCollectionMixin:GetOrCreatePool(frameType, parent, template, resetterFunc, forbidden, specialization)
	local pool = self:GetPool(template, specialization);
	if not pool then
		return self:CreatePool(frameType, parent, template, resetterFunc, forbidden, specialization), true;
	end
	return pool, false;
end

---@param frameType string
---@param parent Frame
---@param template? string
---@param resetterFunc? PoolResetterFunc
---@param forbidden? boolean
---@param specialization? function|table
---@return FramePoolMixin
function FramePoolCollectionMixin:CreatePool(frameType, parent, template, resetterFunc, forbidden, specialization)
	assert(self:GetPool(template, specialization) == nil);
	local frameInitFunc = FramePoolCollection_GetSpecializedFrameInit(specialization);
	local pool = CreateFramePool(frameType, parent, template, resetterFunc, forbidden, frameInitFunc);
	self.pools[FramePoolCollection_GetPoolKey(template, specialization)] = pool;
	return pool;
end

function FramePoolCollectionMixin:CreatePoolIfNeeded(frameType, parent, template, resetterFunc, forbidden, specialization)
	if not self:GetPool(template, specialization) then
		self:CreatePool(frameType, parent, template, resetterFunc, forbidden, specialization);
	end
end

---@param template? string
---@param specialization? function|table
---@return FramePoolMixin?
function FramePoolCollectionMixin:GetPool(template, specialization)
	return self.pools[FramePoolCollection_GetPoolKey(template, specialization)];
end

---@param template? string
---@param specialization? function|table
---@return Frame
---@return boolean new
function FramePoolCollectionMixin:Acquire(template, specialization)
	local pool = self:GetPool(template, specialization);
	assert(pool);
	return pool:Acquire();
end

function FramePoolCollectionMixin:Release(object)
	for _, pool in pairs(self.pools) do
		if pool:Release(object) then
			-- Found it! Just return
			return;
		end
	end

	-- Huh, we didn't find that object
	assert(false);
end

function FramePoolCollectionMixin:ReleaseAllByTemplate(template, specialization)
	local pool = self:GetPool(template, specialization);
	if pool then
		pool:ReleaseAll();
	end
end

function FramePoolCollectionMixin:ReleaseAll()
	for key, pool in pairs(self.pools) do
		pool:ReleaseAll();
	end
end

function FramePoolCollectionMixin:EnumerateActiveByTemplate(template, specialization)
	local pool = self:GetPool(template, specialization);
	if pool then
		return pool:EnumerateActive();
	end

	return nop;
end

function FramePoolCollectionMixin:EnumerateActive()
	local currentPoolKey, currentPool = next(self.pools, nil);
	local currentObject = nil;
	return function()
		if currentPool then
			currentObject = currentPool:GetNextActive(currentObject);
			while not currentObject do
				currentPoolKey, currentPool = next(self.pools, currentPoolKey);
				if currentPool then
					currentObject = currentPool:GetNextActive();
				else
					break;
				end
			end
		end

		return currentObject;
	end, nil;
end

function FramePoolCollectionMixin:EnumerateInactiveByTemplate(template, specialization)
	local pool = self:GetPool(template, specialization);
	if pool then
		return pool:EnumerateInactive();
	end

	return nop;
end

function FramePoolCollectionMixin:EnumerateInactive()
	local currentPoolKey, currentPool = next(self.pools, nil);
	local currentObject = nil;
	return function()
		if currentPool then
			currentObject = currentPool:GetNextInactive(currentObject);
			while not currentObject do
				currentPoolKey, currentPool = next(self.pools, currentPoolKey);
				if currentPool then
					currentObject = currentPool:GetNextInactive();
				else
					break;
				end
			end
		end

		return currentObject;
	end, nil;
end

---@class FixedSizeFramePoolCollectionMixin : FramePoolCollectionMixin
---@field sizes table<string, number>
FixedSizeFramePoolCollectionMixin = CreateFromMixins(FramePoolCollectionMixin);

---@return FixedSizeFramePoolCollectionMixin
function CreateFixedSizeFramePoolCollection()
	local poolCollection = CreateFromMixins(FixedSizeFramePoolCollectionMixin);
	poolCollection:OnLoad();
	return poolCollection;
end

function FixedSizeFramePoolCollectionMixin:OnLoad()
	FramePoolCollectionMixin.OnLoad(self);
	self.sizes = {};
end

---@param frameType string
---@param parent Frame
---@param template? string
---@param resetterFunc? PoolResetterFunc
---@param forbidden? boolean
---@param specialization? function|table|number
---@param maxPoolSize? number|boolean
---@param preallocate? boolean
---@return FramePoolMixin
function FixedSizeFramePoolCollectionMixin:CreatePool(frameType, parent, template, resetterFunc, forbidden, specialization, maxPoolSize, preallocate)
	if type(specialization) == "number" and type(maxPoolSize) ~= "number" then
		preallocate = maxPoolSize;
		maxPoolSize = specialization;
		specialization = nil;
	end

	local pool = FramePoolCollectionMixin.CreatePool(self, frameType, parent, template, resetterFunc, forbidden, specialization);

	if preallocate then
		for i = 1, maxPoolSize do
			pool:Acquire();
		end
		pool:ReleaseAll();
	end

	self.sizes[FramePoolCollection_GetPoolKey(template, specialization)] = maxPoolSize;

	return pool;
end

function FixedSizeFramePoolCollectionMixin:Acquire(template, specialization)
	local pool = self:GetPool(template, specialization);
	assert(pool);

	if pool:GetNumActive() < self.sizes[FramePoolCollection_GetPoolKey(template, specialization)] then
		return pool:Acquire();
	end
	return nil;
end

---@class FontStringPoolCollectionMixin : FramePoolCollectionMixin
FontStringPoolCollectionMixin = CreateFromMixins(FramePoolCollectionMixin);

---@return FontStringPoolCollectionMixin
function CreateFontStringPoolCollection()
	local poolCollection = CreateFromMixins(FontStringPoolCollectionMixin);
	poolCollection:OnLoad();
	return poolCollection;
end

---@param parent Frame
---@param layer? string
---@param subLayer? number
---@param fontStringTemplate? string
---@param resetterFunc? PoolResetterFunc
---@return FontStringPoolMixin
function FontStringPoolCollectionMixin:GetOrCreatePool(parent, layer, subLayer, fontStringTemplate, resetterFunc)
	local pool = self:GetPool(fontStringTemplate);
	if not pool then
		pool = self:CreatePool(parent, layer, subLayer, fontStringTemplate, resetterFunc);
	end
	return pool;
end

---@param parent Frame
---@param layer? string
---@param subLayer? number
---@param fontStringTemplate? string
---@param resetterFunc? PoolResetterFunc
---@return FontStringPoolMixin
function FontStringPoolCollectionMixin:CreatePool(parent, layer, subLayer, fontStringTemplate, resetterFunc)
	assert(self:GetPool(fontStringTemplate) == nil);
	local pool = CreateFontStringPool(parent, layer, subLayer, fontStringTemplate, resetterFunc);
	self.pools[FramePoolCollection_GetPoolKey(fontStringTemplate)] = pool;
	return pool;
end

function FontStringPoolCollectionMixin:CreatePoolIfNeeded(parent, layer, subLayer, fontStringTemplate, resetterFunc)
	if not self:GetPool(fontStringTemplate) then
		self:CreatePool(parent, layer, subLayer, fontStringTemplate, resetterFunc);
	end
end

---@param fontStringTemplate? string
---@param parent? Frame
---@param layer? string
---@param subLayer? number
---@param resetterFunc? PoolResetterFunc
---@return FontString
---@return boolean new
function FontStringPoolCollectionMixin:Acquire(fontStringTemplate, parent, layer, subLayer, resetterFunc)
	local pool = self:GetOrCreatePool(parent, layer, subLayer, fontStringTemplate, resetterFunc);
	local newString = pool:Acquire();
	if parent then
		newString:SetParent(parent);
	end
	if layer then
		newString:SetDrawLayer(layer, subLayer);
	end
	return newString;
end
