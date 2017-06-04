-- Local variables
local duelIcon = nil
local bagIcon = nil
local fishingIcon = nil
local pokedexIcon = nil
local caughtsIcon = nil
local ropeIcon = nil

local path = '/images/topbuttons/'
local currentSlot = 0
-- End local variables

-- Public functions
function init()
   pokedexIcon = modules.client_topmenu.addRightGameToggleButton('pokedexIcon', 'Pokedex(Ctrl+D)', path..'pokedex', togglePokedexIcon)
   pokedexIcon:setVisible(false)  
   g_keyboard.bindKeyDown('Ctrl+D', togglePokedexIcon)  
   
   fishingIcon = modules.client_topmenu.addRightGameToggleButton('fishingIcon', 'Fishing(Ctrl+Z)', path..'fishing', toggleFishingIcon)
   fishingIcon:setVisible(false)
   g_keyboard.bindKeyDown('Ctrl+Z', toggleFishingIcon)  
   
   bagIcon = modules.client_topmenu.addRightGameToggleButton('bag2_icon', 'Ballpack', path..'ballpack', toggleBagIcon)
   bagIcon:setVisible(false)
  local gameMapPanel = modules.game_interface.getMapPanel()
  g_mouse.bindPress(gameMapPanel, toggleDuelIcon, 3)

   connect(g_game, { onGameStart = online,
                     onGameEnd = offline })
end

function terminate()
   bagIcon:destroy()
   fishingIcon:destroy()
   pokedexIcon:destroy()
   duelIcon:destroy()
  g_keyboard.unbindKeyDown('Ctrl+D')
  g_keyboard.unbindKeyDown('Ctrl+Z')
end

--[[function disableHotkey()
  g_keyboard.unbindKeyDown('Ctrl+D')
  g_keyboard.unbindKeyDown('Ctrl+Z')
end]]

function offline()
   bagIcon:setOn(false)
   bagIcon:setVisible(false)
   fishingIcon:setVisible(false)
   pokedexIcon:setVisible(false)
 -- g_keyboard.unbindKeyDown('Ctrl+D')
  --g_keyboard.unbindKeyDown('Ctrl+Z')
	--disableHotkey()
end       


function online()
   bagIcon:setVisible(true)     
   if not bagIcon:isOn() then
      bagIcon:setOpacity(0.5)
   end
   fishingIcon:setVisible(true)
   pokedexIcon:setVisible(true)
   --ropeIcon:setVisible(true)
 --  caughtsIcon:setVisible(true)
end

-- Complex functions
function startChooseItem(releaseCallback)
  if g_ui.isMouseGrabbed() then return end
  if not releaseCallback then
    error("No mouse release callback parameter set.")
  end
  local mouseGrabberWidget = g_ui.createWidget('UIWidget')
  mouseGrabberWidget:setVisible(false)
  mouseGrabberWidget:setFocusable(false)

  connect(mouseGrabberWidget, { onMouseRelease = releaseCallback })
  
  mouseGrabberWidget:grabMouse()
  g_mouse.pushCursor('target')
end

function onClickWithMouse(self, mousePosition, mouseButton)
  local item = nil
  if mouseButton == MouseLeftButton then

    local clickedWidget = modules.game_interface.getRootPanel():recursiveGetChildByPos(mousePosition, false)
    if clickedWidget then  
      if clickedWidget:getClassName() == 'UIGameMap' then
        local tile = clickedWidget:getTile(mousePosition)
        if tile then
          if currentSlot == 3 then
             item = tile:getGround()
          else
              local thing = tile:getTopMoveThing()
              if thing and thing:isItem() then
                 item = thing
              else
                 item = tile:getTopCreature()
              end
          end
        elseif clickedWidget:getClassName() == 'UIItem' and not clickedWidget:isVirtual() then
           item = clickedWidget:getItem()
        end
    end
	end
  end
    if item then
          local player = g_game.getLocalPlayer()               --2  --6 pokedex
          g_game.useInventoryItemWith(player:getInventoryItem(currentSlot):getId(), item)
    end
  g_mouse.popCursor('target')
  self:ungrabMouse()
  self:destroy()
end

function toggleDuelIcon()
  currentSlot = 4
  local item = nil
  local mousePos = g_window.getMousePosition()
  local clickedWidget = modules.game_interface.getRootPanel():recursiveGetChildByPos(mousePos, false)
  local tile = clickedWidget:getTile(mousePos)
  if not tile then return end
  item = tile:getGround()
  if item then
  local player = g_game.getLocalPlayer()
  g_game.useInventoryItemWith(player:getInventoryItem(4):getId(), item)
  end
end
-- Toggles functions
function toggleRopeIcon()
   currentSlot = 1
   startChooseItem(onClickWithMouse)
end

function toggleBagIcon()            
   g_game.open(g_game.getLocalPlayer():getInventoryItem(1))
end

function toggleFishingIcon()
   currentSlot = 2
   startChooseItem(onClickWithMouse)
end

function togglePokedexIcon()
	if modules.game_pokedex.visibleDex() then
		modules.game_pokedex.hide()
	else
		currentSlot = 6
		startChooseItem(onClickWithMouse)
	end
end


function toggleCaughtsIcon()
   local player = g_game.getLocalPlayer() 
   g_game.useInventoryItem(player:getInventoryItem(9):getId())
   setFocusable(false)
end

function getBagIcon()
  return bagIcon
end

function getPokedexIcon()
  return pokedexIcon
end
-- End public functions