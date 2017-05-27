function init()
  connect(g_game, { onGameEnd = onGameEnd })
  ProtocolGame.registerExtendedOpcode(70, function(protocol, opcode, buffer)
  local strings = string.explode(buffer, '-')  

  show(strings[1], strings[2])
  --local strings = string.explode(buffer, '-')--, strings[9], strings[10], strings[11], strings[12], strings[13], strings[14], strings[15], strings[16], strings[17], strings[18], strings[19]) 
  end)

  panelWindow = g_ui.displayUI('panel')
  panelWindow:hide()
end

function terminate()
  disconnect(g_game, { onGameEnd = onGameEnd })
  ProtocolGame.unregisterExtendedOpcode(70)

  panelWindow:destroy()
end

function onGameEnd()
  if panelWindow:isVisible() then
    panelWindow:hide()
  end
end

function show(thepanel)
  if not panelWindow:isVisible() then
    addEvent(function() g_effects.fadeIn(panelWindow, 250) end)
  end
  if thepanel == "false" then
  hide()
  return true
  end
  panelWindow:show()
  panelWindow:raise()
  panelWindow:focus()
  panelItems = panelWindow:getChildById('itemspanel')
  panelItems2 = panelItems:getChildById('itemspanel2')
  id1 = panelItems2:getChildById('1')
  id2 = panelItems2:getChildById('2')
  id3 = panelItems2:getChildById('3')
  id4 = panelItems2:getChildById('4')
  id5 = panelItems2:getChildById('5')
  id6 = panelItems2:getChildById('6')
  id7 = panelItems2:getChildById('7')
  id8 = panelItems2:getChildById('8')
  id9 = panelItems2:getChildById('9')
  id10 = panelItems2:getChildById('10')
  id11 = panelItems2:getChildById('11')
  id12 = panelItems2:getChildById('12')
  id13 = panelItems2:getChildById('13')
  id14 = panelItems2:getChildById('14')
  id15 = panelItems2:getChildById('15')
  id16 = panelItems2:getChildById('16')
  id17 = panelItems2:getChildById('17')
  id18 = panelItems2:getChildById('18')
  id1:getChildById('1reward'):setItemId(14949)
  id1:getChildById('1cost'):setItemId(14952)
  id2:getChildById('2reward'):setItemId(14948)
  id2:getChildById('2cost'):setItemId(14949)
  id3:getChildById('3reward'):setItemId(14954)
  id3:getChildById('3cost'):setItemId(14952)
  id4:getChildById('4reward'):setItemId(14956)
  id4:getChildById('4cost'):setItemId(14952)
  id5:getChildById('5reward'):setItemId(14960)
  id5:getChildById('5cost'):setItemId(14952)
  id6:getChildById('6reward'):setItemId(14969)
  id6:getChildById('6cost'):setItemId(14952)
  id7:getChildById('7reward'):setItemId(14971)
  id7:getChildById('7cost'):setItemId(14952)
  id8:getChildById('8reward'):setItemId(14987)
  id8:getChildById('8cost'):setItemId(14952)
  id9:getChildById('9reward'):setItemId(14994)
  id9:getChildById('9cost'):setItemId(14952)
  id10:getChildById('10reward'):setItemId(14993)
  id10:getChildById('10cost'):setItemId(14952)
  id11:getChildById('11reward'):setItemId(14995)
  id11:getChildById('11cost'):setItemId(14952)
  id12:getChildById('12reward'):setItemId(14996)
  id12:getChildById('12cost'):setItemId(14952)
  id13:getChildById('13reward'):setItemId(14997)
  id13:getChildById('13cost'):setItemId(14952)
  id14:getChildById('14reward'):setItemId(14998)
  id14:getChildById('14cost'):setItemId(14952)
  id15:getChildById('15reward'):setItemId(14991)
  id15:getChildById('15cost'):setItemId(14952)
  id16:getChildById('16reward'):setItemId(14992)
  id16:getChildById('16cost'):setItemId(14952)
  id17:getChildById('17reward'):setItemId(14947)
  id17:getChildById('17cost'):setItemId(14952)
  id18:getChildById('18reward'):setItemId(14946)
  id18:getChildById('18cost'):setItemId(14952)
  focused = panelItems2:getFocusedChild()
  
  buyButton = panelWindow:getChildById('buyButton')
end

function iFocus1()
  id1:focus()
end

function iFocus2()
  id2:focus()
end

function iFocus3()
  id3:focus()
end

function iFocus4()
  id4:focus()
end

function iFocus5()
  id5:focus()
end

function iFocus6()
  id6:focus()
end

function iFocus7()
  id7:focus()
end

function iFocus8()
  id8:focus()
end

function iFocus9()
  id9:focus()
end

function iFocus9()
  id9:focus()
end

function iFocus9()
  id9:focus()
end

function iFocus9()
  id9:focus()
end

function iFocus10()
  id10:focus()
end

function iFocus11()
  id11:focus()
end

function iFocus12()
  id12:focus()
end

function iFocus13()
  id13:focus()
end

function iFocus14()
  id14:focus()
end

function iFocus15()
  id15:focus()
end

function iFocus16()
  id16:focus()
end

function iFocus17()
  id17:focus()
end

function iFocus18()
  id18:focus()
end

--[[function actBB()
  buyButton = panelWindow:getChildById('buyButton') or getChildById('buyButton')
  buyButton:setVisible(true)
end]]

function buyItem()
  focused = panelItems2:getFocusedChild()
 if focused == id1 then
 g_game.talk("@halloweenit1")
 elseif focused == id2 then
 g_game.talk("@halloweenit2")
 elseif focused == id3 then
 g_game.talk("@halloweenit3")
 elseif focused == id4 then
 g_game.talk("@halloweenit4")
 elseif focused == id5 then
 g_game.talk("@halloweenit5")
 elseif focused == id6 then
 g_game.talk("@halloweenit6")
 elseif focused == id7 then
 g_game.talk("@halloweenit7")
 elseif focused == id8 then
 g_game.talk("@halloweenit8")
 elseif focused == id9 then
 g_game.talk("@halloweenit9")
 elseif focused == id10 then
 g_game.talk("@halloweenit10")
 elseif focused == id11 then
 g_game.talk("@halloweenit11")
 elseif focused == id12 then
 g_game.talk("@halloweenit12")
 elseif focused == id13 then
 g_game.talk("@halloweenit13")
 elseif focused == id14 then
 g_game.talk("@halloweenit14")
 elseif focused == id15 then
 g_game.talk("@halloweenit15")
 elseif focused == id16 then
 g_game.talk("@halloweenit16")
 elseif focused == id17 then
 g_game.talk("@halloweenit17")
 elseif focused == id18 then
 g_game.talk("@halloweenit18")
 else
 g_game.talk("Fala pro o GODzru que você bugou o negocio!")
 end
end

function hide()
  addEvent(function() g_effects.fadeOut(panelWindow, 250) end)
  scheduleEvent(function() panelWindow:hide() end, 250)
end
