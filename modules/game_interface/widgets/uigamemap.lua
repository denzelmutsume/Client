UIGameMap = extends(UIMap, "UIGameMap")

function UIGameMap.create()
  local gameMap = UIGameMap.internalCreate()
  gameMap:setKeepAspectRatio(true)
  gameMap:setVisibleDimension({width = 15, height = 11})
  gameMap:setDrawLights(true)
  return gameMap
end

function UIGameMap:onDragEnter(mousePos)
  local tile = self:getTile(mousePos)
  if not tile then return false end

  local thing = tile:getTopMoveThing()
  if not thing then return false end

  self.currentDragThing = thing

  g_mouse.pushCursor('target')
  self.allowNextRelease = false
  return true
end

function UIGameMap:onDragLeave(droppedWidget, mousePos)
  self.currentDragThing = nil
  self.hoveredWho = nil
  g_mouse.popCursor('target')
  return true
end

local function isP(id)
	if id >= 12248 and id <= 12719 then return true end
	if id == 13913 then return true end
	if id >= 14571 and id <= 14600 then return true end
	if id >= 14617 and id <= 14618 then return true end
	if id >= 15183 and id <= 15384 then return true end
	if id >= 15437 and id <= 15451 then return true end
	return false
end

function UIGameMap:onDrop(widget, mousePos)
  if not self:canAcceptDrop(widget, mousePos) then return false end

  local tile = self:getTile(mousePos)
  if not tile then return false end

  local thing = widget.currentDragThing
  local toPos = tile:getPosition() --Tem certeza que deseja jogar seu Pokémon ou mochila no chão?

  local frombag
  local thingPos = thing:getPosition()
  if thingPos.x == toPos.x and thingPos.y == toPos.y and thingPos.z == toPos.z then
    return false
  elseif tonumber(thingPos.x) and tonumber(thingPos.x) == 65535 then
	frombag = true
  else
	frombag = false
  end

  if thing:isItem() and thing:getCount() > 1 then
    modules.game_interface.moveStackableItem(thing, toPos)
  elseif frombag and (thing:isContainer() or isP(thing:getId())) then
	showDropWindow(thing, toPos)
  else
    g_game.move(thing, toPos, 1)
  end

  return true
end

function UIGameMap:onMousePress()
  if not self:isDragging() then
    self.allowNextRelease = true
  end
end

function UIGameMap:onMouseRelease(mousePosition, mouseButton)
  if not self.allowNextRelease then
    return true
  end

  local autoWalkPos = self:getPosition(mousePosition)

  -- happens when clicking outside of map boundaries
  if not autoWalkPos then return false end

  local localPlayerPos = g_game.getLocalPlayer():getPosition()
  if autoWalkPos.z ~= localPlayerPos.z then
    local dz = autoWalkPos.z - localPlayerPos.z
    autoWalkPos.x = autoWalkPos.x + dz
    autoWalkPos.y = autoWalkPos.y + dz
    autoWalkPos.z = localPlayerPos.z
  end

  local lookThing
  local useThing
  local creatureThing
  local multiUseThing
  local attackCreature

  local tile = self:getTile(mousePosition)
  if tile then
    lookThing = tile:getTopLookThing()
    useThing = tile:getTopUseThing()
    creatureThing = tile:getTopCreature()
  end

  local autoWalkTile = g_map.getTile(autoWalkPos)
  if autoWalkTile then
    attackCreature = autoWalkTile:getTopCreature()
  end

  local ret = modules.game_interface.processMouseAction(mousePosition, mouseButton, autoWalkPos, lookThing, useThing, creatureThing, attackCreature)
  if ret then
    self.allowNextRelease = false
  end

  return ret
end

function UIGameMap:canAcceptDrop(widget, mousePos)
  if not widget or not widget.currentDragThing then return false end

  local children = rootWidget:recursiveGetChildrenByPos(mousePos)
  for i=1,#children do
    local child = children[i]
    if child == self then
      return true
    elseif not child:isPhantom() then
      return false
    end
  end

  error('Widget ' .. self:getId() .. ' not in drop list.')
  return false
end
