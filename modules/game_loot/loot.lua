local itemID = nil
local itemID2 = nil
local itemID3 = nil
local itemID4 = nil
local itemID5 = nil
local itemID6 = nil
local itemID7 = nil
local itemID8 = nil
local itemID9 = nil
local itemID10 = nil
local itemID11 = nil
local count1 = nil
local count2 = nil
local count3 = nil
local count4 = nil
local count5 = nil
local count6 = nil
local count7 = nil
local count8 = nil
local count9 = nil
local count10 = nil
local count11 = nil
local count12 = nil
local count13 = nil
local count14 = nil
local count15 = nil
local viraPhantom = nil
local desaparecendo = nil
local viraPhantom2 = nil
local desaparecendo2 = nil
local viraPhantom3 = nil
local desaparecendo3 = nil

function init()
  connect(g_game, { onGameEnd = onGameEnd })
  

  lootWindow = g_ui.displayUI('loot')
  aWindow = g_ui.displayUI('loot')
  bWindow = g_ui.displayUI('loot2')
  cWindow = g_ui.displayUI('loot3')
  lootWindow:hide()
  aWindow:hide()
  bWindow:hide()
  cWindow:hide()
 -- lootWindow:addAnchor(AnchorLeft, 'gameLeftPanel', AnchorRight)
 -- lootWindow:addAnchor(AnchorLeft, "gameMapPanel", AnchorRight)
  --lootWindow:addAnchor(AnchorTop, 'topMenu', AnchorBottom)
  --lootWindow:addAnchor(AnchorBottom, 'topMenu', AnchorBottom + 70)
  lootWindow:setImageSource('/images/ui/loot3.png')
  aWindow:setImageSource('/images/ui/loot3.png')
  bWindow:setImageSource('/images/ui/loot3.png')
  cWindow:setImageSource('/images/ui/loot3.png')
  lootWindow:setParent(modules.game_interface.getMapPanel())
  lootWindow:setHeight(36)
  aWindow:setParent(modules.game_interface.getMapPanel())
  aWindow:setHeight(36)
  bWindow:setParent(modules.game_interface.getMapPanel())
  bWindow:setHeight(36)
  cWindow:setParent(modules.game_interface.getMapPanel())
  cWindow:setHeight(36)
  
 -- lootWindow:setParent(modules.client_topmenu.getTopMenu())
  --lootWindow:addAnchor(HorizontalCenter, modules.game_interface.getMapPanel(), HorizontalCenter)
  --lootWindow:addAnchor(AnchorRight, 'gameRightPanel', AnchorLeft)
  --lootWindow:fill('parent')
  ProtocolGame.registerExtendedOpcode(69, function(protocol, opcode, buffer)
  local strings = string.explode(buffer, '-')  

  show(strings[1], strings[2], strings[3], strings[4], strings[5], strings[6], strings[7], strings[8], strings[9], strings[10], strings[11], strings[12], strings[13], strings[14], strings[15], strings[16], strings[17], strings[18], strings[19], strings[20], strings[21], strings[22], strings[23], strings[24], strings[25], strings[26], strings[27], strings[28], strings[29], strings[30]) 
  end)
end

function terminate()
  disconnect(g_game, { onGameEnd = onGameEnd })
  ProtocolGame.unregisterExtendedOpcode(69)

  lootWindow:destroy()
  aWindow:destroy()
  bWindow:destroy()
  cWindow:destroy()
end

function onGameEnd()
  if lootWindow:isVisible() then
    lootWindow:hide()
    aWindow:hide()
    bWindow:hide()
    cWindow:hide()
  end
end

function show(itemID, count1, itemID2, count2, itemID3, count3, itemID4, count4, itemID5, count5, itemID6, count6, itemID7, count7, itemID8, count8, itemID9, count9, itemID10, count10, itemID11, count11, itemID12, count12, itemID13, count13, itemID14, count14, itemID15, count15)
lootWindow = aWindow
if not lootWindow:isPhantom() then
  lootWindow = bWindow
if not lootWindow:isPhantom() then
lootWindow = cWindow
if not lootWindow:isPhantom() then
lootWindow = aWindow
viraPhantom = nil
desaparecendo = nil
end
end
end
  lootWindow:setWidth(modules.game_interface.getMapPanel():getWidth())
    addEvent(function() g_effects.fadeIn(lootWindow, 250) end)
 -- scheduleEvent(function() lootWindow:setPhantom(false) end, 250)
  lootWindow:setPhantom(false)
  lootWindow:show()
  lootWindow:raise()
  lootWindow:focus()
  lootWindow:getChildById('loot1'):setItemId(tonumber(itemID))
  if count1 ~= nil and tonumber(count1) > 1 then
  lootWindow:getChildById('count1'):setText(tonumber(count1))
  else
  lootWindow:getChildById('count1'):setText('')
  end
  --lootWindow:getChildById('count1'):setParent('loot1')
  lootWindow:getChildById('loot2'):setItemId(tonumber(itemID2))
  if count2 ~= nil and tonumber(count2) > 1 then
  lootWindow:getChildById('count2'):setText(tonumber(count2))
  else
  lootWindow:getChildById('count2'):setText('')
  end
 -- lootWindow:getChildById('count2'):setParent('loot2')
  lootWindow:getChildById('loot3'):setItemId(tonumber(itemID3))
  if count3 ~= nil and tonumber(count3) > 1 then
  lootWindow:getChildById('count3'):setText(tonumber(count3))
  else
  lootWindow:getChildById('count3'):setText('')
  end
 -- lootWindow:getChildById('count3'):setParent('loot3')
  lootWindow:getChildById('loot4'):setItemId(tonumber(itemID4))
  if count4 ~= nil and tonumber(count4) > 1 then
  lootWindow:getChildById('count4'):setText(tonumber(count4))
  else
  lootWindow:getChildById('count4'):setText('')
  end
  lootWindow:getChildById('loot5'):setItemId(tonumber(itemID5))
  if count5 ~= nil and tonumber(count5) > 1 then 
  lootWindow:getChildById('count5'):setText(tonumber(count5))
  else
  lootWindow:getChildById('count5'):setText('')
  end
  lootWindow:getChildById('loot6'):setItemId(tonumber(itemID6))
  if count6 ~= nil and tonumber(count6) > 1 then 
  lootWindow:getChildById('count6'):setText(tonumber(count6))
  else
  lootWindow:getChildById('count6'):setText('')
  end
  lootWindow:getChildById('loot7'):setItemId(tonumber(itemID7))
  if count7 ~= nil and tonumber(count7) > 1 then 
  lootWindow:getChildById('count7'):setText(tonumber(count7))
  else
  lootWindow:getChildById('count7'):setText('')
  end
  lootWindow:getChildById('loot8'):setItemId(tonumber(itemID8))
  if count8 ~= nil and tonumber(count8) > 1 then 
  lootWindow:getChildById('count8'):setText(tonumber(count8))
  else
  lootWindow:getChildById('count8'):setText('')
  end
  lootWindow:getChildById('loot9'):setItemId(tonumber(itemID9))
  if count9 ~= nil and tonumber(count9) > 1 then 
  lootWindow:getChildById('count9'):setText(tonumber(count9))
  else
  lootWindow:getChildById('count9'):setText('')
  end
  lootWindow:getChildById('loot10'):setItemId(tonumber(itemID10))
  if count10 ~= nil and tonumber(count10) > 1 then 
  lootWindow:getChildById('count10'):setText(tonumber(count10))
  else
  lootWindow:getChildById('count10'):setText('')
  end
  lootWindow:getChildById('loot11'):setItemId(tonumber(itemID11))
  if count11 ~= nil and tonumber(count11) > 1 then 
  lootWindow:getChildById('count11'):setText(tonumber(count11))
  else
  lootWindow:getChildById('count11'):setText('')
  end
  lootWindow:getChildById('loot12'):setItemId(tonumber(itemID12))
  if count12 ~= nil and tonumber(count12) > 1 then
  lootWindow:getChildById('count12'):setText(tonumber(count12))
  else
  lootWindow:getChildById('count12'):setText('')
  end
  lootWindow:getChildById('loot13'):setItemId(tonumber(itemID13))
  if count13 ~= nil and tonumber(count13) > 1 then
  lootWindow:getChildById('count13'):setText(tonumber(count13))
  else
  lootWindow:getChildById('count13'):setText('')
  end
  lootWindow:getChildById('loot14'):setItemId(tonumber(itemID14))
  if count14 ~= nil and tonumber(count14) > 1 then
  lootWindow:getChildById('count14'):setText(tonumber(count14))
  else
  lootWindow:getChildById('count14'):setText('')
  end
  lootWindow:getChildById('loot15'):setItemId(tonumber(itemID15))
  if count15 ~= nil and tonumber(count15) > 1 then
  lootWindow:getChildById('count15'):setText(tonumber(count15))
  else
  lootWindow:getChildById('count15'):setText('')
  end
  --lootWindow:getChildById('loot1'):setParent(center)
  if itemID15 ~= nil then
  lootWindow:getChildById('loot1'):setMarginRight(16*15)
  lootWindow:getChildById('count1'):setMarginRight(16*15)
  elseif itemID14 ~= nil then
  lootWindow:getChildById('loot1'):setMarginRight(16*14)
  lootWindow:getChildById('count1'):setMarginRight(16*14)
  elseif itemID13 ~= nil then
  lootWindow:getChildById('loot1'):setMarginRight(16*13)
  lootWindow:getChildById('count1'):setMarginRight(16*13)
  elseif itemID12 ~= nil then
  lootWindow:getChildById('loot1'):setMarginRight(16*12)
  lootWindow:getChildById('count1'):setMarginRight(16*12)
  elseif itemID11 ~= nil then
  lootWindow:getChildById('loot1'):setMarginRight(16*11)
  lootWindow:getChildById('count1'):setMarginRight(16*11)
  elseif itemID10 ~= nil then
  lootWindow:getChildById('loot1'):setMarginRight(16*10)
  lootWindow:getChildById('count1'):setMarginRight(16*10)
  elseif itemID9 ~= nil then
  lootWindow:getChildById('loot1'):setMarginRight(16*9)
  lootWindow:getChildById('count1'):setMarginRight(16*9)
  elseif itemID8 ~= nil then
  lootWindow:getChildById('loot1'):setMarginRight(16*8)
  lootWindow:getChildById('count1'):setMarginRight(16*8)
  elseif itemID7 ~= nil then
  lootWindow:getChildById('loot1'):setMarginRight(16*7)
  lootWindow:getChildById('count1'):setMarginRight(16*7)
  elseif itemID6 ~= nil then
  lootWindow:getChildById('loot1'):setMarginRight(16*6)
  lootWindow:getChildById('count1'):setMarginRight(16*6)
  elseif itemID5 ~= nil then
  lootWindow:getChildById('loot1'):setMarginRight(16*5)
  lootWindow:getChildById('count1'):setMarginRight(16*5)
  elseif itemID4 ~= nil then
  lootWindow:getChildById('loot1'):setMarginRight(16*4)
  lootWindow:getChildById('count1'):setMarginRight(16*4)
  elseif itemID3 ~= nil then
  lootWindow:getChildById('loot1'):setMarginRight(16*3)
  lootWindow:getChildById('count1'):setMarginRight(16*3)
  elseif itemID2 ~= nil then
  lootWindow:getChildById('loot1'):setMarginRight(16*2)
  lootWindow:getChildById('count1'):setMarginRight(16*2)
  else
  lootWindow:getChildById('loot1'):setMarginRight(16)
  lootWindow:getChildById('count1'):setMarginRight(16)
  end
  --catchWindow:getChildById('maguBall'):setItemId(15324) 
  --catchWindow:getChildById('soraBall'):setItemId(15325)  
  --catchWindow:getChildById('yumeBall'):setItemId(15326)  
  --catchWindow:getChildById('duskBall'):setItemId(15327)  
  --catchWindow:getChildById('taleBall'):setItemId(15330)  
  --catchWindow:getChildById('moonBall'):setItemId(15331)  
  --catchWindow:getChildById('netBall'):setItemId(15332)  
 -- catchWindow:getChildById('premierBall'):setItemId(15334)  
 -- catchWindow:getChildById('tinkerBall'):setItemId(15335)  
 -- catchWindow:getChildById('fastBall'):setItemId(15328)  
 -- catchWindow:getChildById('heavyBall'):setItemId(15329)  
  
 -- catchWindow:getChildById('text'):setText(tr('Congratulations!\nYou caught a %s!\nXP: %s', doCorrectString(pokemon), exp))
 -- catchWindow:getChildById('pokeballsLabel'):setText(n)
  --catchWindow:getChildById('greatballsLabel'):setText(g)
 -- catchWindow:getChildById('superballsLabel'):setText(s)
 -- catchWindow:getChildById('utraballsLabel'):setText(u)
 -- catchWindow:getChildById('saffariballsLabel'):setText(s2)
  --addEvent(function() g_effects.fadeOut(lootWindow,7000) end)
  if lootWindow == aWindow then
  if viraPhantom ~= nil then
  removeEvent(viraPhantom)
  end
  if desaparecendo ~= nil then
  removeEvent(desaparecendo)
  end
  desaparecendo = scheduleEvent(function() 
  g_effects.fadeOut(aWindow, 2900) 
  desaparecendo = nil
  end, 3000)
  viraPhantom = scheduleEvent(function() 
  aWindow:setPhantom(true) 
  viraPhantom = nil
  end, 6000)
  scheduleEvent(function() 
  if aWindow:isPhantom() then 
  aWindow:hide() 
  end
  end, 6000)
  elseif lootWindow == bWindow then
  if viraPhantom2 ~= nil then
  removeEvent(viraPhantom2)
  end
  if desaparecendo2 ~= nil then
  removeEvent(desaparecendo2)
  end
  desaparecendo2 = scheduleEvent(function() 
  g_effects.fadeOut(bWindow, 2900) 
  desaparecendo2 = nil
  end, 3000)
  viraPhantom2 = scheduleEvent(function() 
  bWindow:setPhantom(true) 
  viraPhantom2 = nil
  end, 6000)
  scheduleEvent(function() 
  if bWindow:isPhantom() then 
  bWindow:hide() 
  end
  end, 6000)
  elseif lootWindow == cWindow then
  if viraPhantom3 ~= nil then
  removeEvent(viraPhantom3)
  end
  if desaparecendo3 ~= nil then
  removeEvent(desaparecendo3)
  end
  desaparecendo3 = scheduleEvent(function() 
  g_effects.fadeOut(cWindow, 2900) 
  desaparecendo3 = nil
  end, 3000)
  viraPhantom3 = scheduleEvent(function() 
  cWindow:setPhantom(true) 
  viraPhantom3 = nil
  end, 6000)
  scheduleEvent(function() 
  if cWindow:isPhantom() then 
  cWindow:hide() 
  end
  end, 6000)
  end
  
 -- catchWindow:getChildById('maguBallsLabel'):setText(magu)
 -- catchWindow:getChildById('soraBallsLabel'):setText(sora)
 -- catchWindow:getChildById('yumeBallsLabel'):setText(yume)
 -- catchWindow:getChildById('duskBallsLabel'):setText(dusk)
 -- catchWindow:getChildById('taleBallsLabel'):setText(tale)
 -- catchWindow:getChildById('moonBallsLabel'):setText(moon)
 -- catchWindow:getChildById('netBallsLabel'):setText(net)
 -- catchWindow:getChildById('premierBallsLabel'):setText(premier)
 -- catchWindow:getChildById('tinkerBallsLabel'):setText(tinker)
 -- catchWindow:getChildById('fastBallsLabel'):setText(fast)
 -- catchWindow:getChildById('heavyBallsLabel'):setText(heavy)
-- lootWindow:show()
end

function hide()
  addEvent(function() g_effects.fadeOut(lootWindow, 250) end)
  scheduleEvent(function() lootWindow:hide() end, 250)
end
