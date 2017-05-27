function init()
  connect(g_game, { onGameEnd = onGameEnd })
  ProtocolGame.registerExtendedOpcode(65, function(protocol, opcode, buffer)
  local strings = string.explode(buffer, '-')  

  show(strings[1], strings[2])
  --local strings = string.explode(buffer, '-')--, strings[9], strings[10], strings[11], strings[12], strings[13], strings[14], strings[15], strings[16], strings[17], strings[18], strings[19]) 
  end)

  mapWindow = g_ui.displayUI('map')
  mapWindow:hide()
end

function terminate()
  disconnect(g_game, { onGameEnd = onGameEnd })
  ProtocolGame.unregisterExtendedOpcode(65)

  mapWindow:destroy()
end

function onGameEnd()
  if mapWindow:isVisible() then
    mapWindow:hide()
  end
end

function show(themap)
if themap == "false" then
hide()
return true
end
  if not mapWindow:isVisible() then
    addEvent(function() g_effects.fadeIn(mapWindow, 250) end)
  end
  mapWindow:show()
  mapWindow:raise()
  mapWindow:focus()
end

function hide()
  addEvent(function() g_effects.fadeOut(mapWindow, 250) end)
  scheduleEvent(function() mapWindow:hide() end, 250)
end
