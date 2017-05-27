function init()
  g_keyboard.bindKeyDown('Ctrl+I', toggle)
  inventoryButton = modules.client_topmenu.addRightGameToggleButton('inventoryButton', tr('Inventory') .. ' (Ctrl+I)', '/images/ui/topMenu_icons/bag_icon', toggle)
  inventoryButton:setVisible(false)
  connect(g_game, {
    onGameStart = online,
    onGameEnd = offline,
  })
  
  if g_game.isOnline() then
    online()
  end
end

function terminate()
  inventoryButton:destroy()
  g_keyboard.unbindKeyDown('Ctrl+I')
  disconnect(g_game, {
    onGameStart = online,
    onGameEnd = offline,
  })
end

function online()
  inventoryButton:setVisible(true)
end

function offline()
  inventoryButton:setVisible(false)
end

function toggle()
  g_game.open(g_game.getLocalPlayer():getInventoryItem(3))
end

function getInventoryButton()
  return inventoryButton
end
