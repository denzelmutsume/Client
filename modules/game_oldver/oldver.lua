function init()
  connect(g_game, { onGameEnd = onGameEnd })
  ProtocolGame.registerExtendedOpcode(64, function(protocol, opcode, buffer)
  local strings = string.explode(buffer, '-')  

  show(strings[1], strings[2], strings[3])
  --local strings = string.explode(buffer, '-')--, strings[9], strings[10], strings[11], strings[12], strings[13], strings[14], strings[15], strings[16], strings[17], strings[18], strings[19]) 
  end)

  verWindow = g_ui.displayUI('oldver')
  verWindow:hide()
end

function terminate()
  disconnect(g_game, { onGameEnd = onGameEnd })
  ProtocolGame.unregisterExtendedOpcode(64)

  verWindow:destroy()
end

function onGameEnd()
  if verWindow:isVisible() then
    verWindow:hide()
  end
end

function show(ver, msg)
if tonumber(ver) <= 261 then
hide()
return true
end
if not msg or msg == "" then msg = "Seu client está desatualizado!\nFavor atualizar seu client pelo launcher ou baixar o client atualizado completo no site oficial: pokezworld.com" end
  if not verWindow:isVisible() then
    addEvent(function() g_effects.fadeIn(verWindow, 250) end)
  end
  verWindow:show()
  verWindow:raise()
  verWindow:focus()
  verWindow:setText("OUTDATED CLIENT")
  verWindow:getChildById('text'):setText(msg)
end

function hide()
  addEvent(function() g_effects.fadeOut(verWindow, 250) end)
  scheduleEvent(function() verWindow:hide() end, 250)
end
