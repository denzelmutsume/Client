function init()
  connect(g_game, { onGameEnd = onGameEnd })
  ProtocolGame.registerExtendedOpcode(72, function(protocol, opcode, buffer)
  local strings = string.explode(buffer, '|')  
  if strings[36] ~= "true" then
  show(strings[1], strings[2], strings[3], strings[4], strings[5], strings[6], strings[7], strings[8], strings[9], strings[10], strings[11], strings[12], strings[13], strings[14], strings[15], strings[16], strings[17], strings[18], strings[19], strings[20], strings[21], strings[22], strings[23], strings[24], strings[25], strings[26], strings[27], strings[28], strings[29], strings[30], strings[31], strings[32], strings[33], strings[34], strings[35])
  end
  updateTeamButtons(strings[37], strings[38])
  end)
  
  ProtocolGame.registerExtendedOpcode(75, function(protocol, opcode, buffer) local strings = string.explode(buffer, '/')  seeInvites(strings[1], strings[2]) end)
  ProtocolGame.registerExtendedOpcode(76, function(protocol, opcode, buffer) local strings = string.explode(buffer, '|')  showWindow(strings[1], strings[2], strings[3], strings[4]) end)
  ProtocolGame.registerExtendedOpcode(78, function(protocol, opcode, buffer) local strings = string.explode(buffer, ':')  showDGShop(strings[1]) end)
  
  
  dpanelWindow = g_ui.displayUI('dpanel')
  dungeonWindow = g_ui.displayUI('dwindow')
  dgTimeLeft = g_ui.displayUI('timeleft')
  dgShop = g_ui.displayUI('shop')
  buyWindow = g_ui.displayUI('dobuy')
  dgTimeLeft:setParent(modules.game_interface.getMapPanel())
  connect(g_game, { onGameStart = function() dgTimeLeft:addAnchor(AnchorRight, 'parent', AnchorRight) dgTimeLeft:addAnchor(AnchorTop, 'parent', AnchorTop) dgTimeLeft:setMarginRight(3) dgTimeLeft:setMarginTop(3) end})

  hide()
  dgTimeLeft:setVisible(false)
ProtocolGame.registerExtendedOpcode(77, function(protocol, opcode, buffer) setTimeLeft(buffer) end)
end

dungeonslevel = {
["01"] = 10,
["02"] = 14,
["03"] = 18,
["04"] = 22,
["05"] = 26,
["06"] = 30,
["07"] = 34,
["08"] = 38,
["09"] = 42,
["10"] = 46,
["11"] = 50,
["12"] = 54,
["13"] = 58,
["14"] = 62,
["15"] = 66,
["16"] = 70,
["17"] = 74,
["18"] = 78,
["19"] = 82,
["20"] = 86,
["21"] = 90,
["22"] = 94,
["23"] = 98,
["24"] = 102,
["25"] = 106,
["26"] = 110,
["27"] = 114,
["28"] = 118,
["29"] = 122,
["30"] = 126,
["31"] = 130,
["32"] = 134,
["33"] = 138,
}

function terminate()
  disconnect(g_game, { onGameEnd = onGameEnd })
  ProtocolGame.unregisterExtendedOpcode(72)
  ProtocolGame.unregisterExtendedOpcode(75)
  ProtocolGame.unregisterExtendedOpcode(76)
  ProtocolGame.unregisterExtendedOpcode(77)
  ProtocolGame.unregisterExtendedOpcode(78)

  dpanelWindow:destroy()
  dungeonWindow:destroy()
  dgTimeLeft:destroy()
end

function onGameEnd()
	--[[if dpanelWindow:isVisible() then
		dpanelWindow:hide()
		dungeonWindow:hide()
	end]]
	if dgTimeLeft:isVisible() then
		dgTimeLeft:hide()
	end
	hide()
	dgTimeLeft:setVisible(false)
	removeEvent(dgtlbeautyclock)
end

function show(thedpanel, level, dg1, dg2, dg3, dg4, dg5, dg6, dg7, dg8, dg9, dg10, dg11, dg12, dg13, dg14, dg15, dg16, dg17, dg18, dg19, dg20, dg21, dg22, dg23, dg24, dg25, dg26, dg27, dg28, dg29, dg30, dg31, dg32, dg33)
  if thedpanel == "false" then
  hide()
  return true
  end
  if not dpanelWindow:isVisible() then
    addEvent(function() g_effects.fadeIn(dpanelWindow, 250) end)
  end
  dpanelWindow:show()
  dpanelWindow:raise()
  dpanelWindow:focus()
  level = tonumber(level)
  dg1 = tonumber(dg1)
  dg2 = tonumber(dg2)
  dg3 = tonumber(dg3)
  dg4 = tonumber(dg4)
  dg5 = tonumber(dg5)
  dg6 = tonumber(dg6)
  dg11 = tonumber(dg11)
  dg12 = tonumber(dg12)
  dg14 = tonumber(dg14)
  dg18 = tonumber(dg18)
  dg23 = tonumber(dg23)
  dg30 = tonumber(dg30)
  dg31 = tonumber(dg31)
  dg32 = tonumber(dg32)
  dg33 = tonumber(dg33)
  dg1icon = dpanelWindow:getChildById('dg1icon')
  dg2icon = dpanelWindow:getChildById('dg2icon')
  dg3icon = dpanelWindow:getChildById('dg3icon')
  dg4icon = dpanelWindow:getChildById('dg4icon')
  dg5icon = dpanelWindow:getChildById('dg5icon')
  dg6icon = dpanelWindow:getChildById('dg6icon')
  dg11icon = dpanelWindow:getChildById('dg11icon')
  dg12icon = dpanelWindow:getChildById('dg12icon')
  dg14icon = dpanelWindow:getChildById('dg14icon')
  dg18icon = dpanelWindow:getChildById('dg18icon')
  dg23icon = dpanelWindow:getChildById('dg23icon')
  dg30icon = dpanelWindow:getChildById('dg30icon')
  dg31icon = dpanelWindow:getChildById('dg31icon')
  dg32icon = dpanelWindow:getChildById('dg32icon')
  dg33icon = dpanelWindow:getChildById('dg33icon')
  
  if level >= 10 then
  dg1icon:setTooltip("Rookie Forest Dungeon")
  dg1icon.onClick = function() g_game.talk("/opendgwindow 01,"..level..","..dg1) end
  dg1icon:setImageSource('/images/dungeons/buttons/01on.png')
  else
  dg1icon:setImageSource('/images/dungeons/buttons/01off.png')
  dg1icon:setTooltip("Rookie Forest Dungeon\n\nRequisitos:"..(level < 10 and "\nVocê precisa de Level 10" or ""))
  dg1icon.onClick = nil
  end
  
  if dg2 > 0 and level >= 14 then
  dg2icon:setTooltip("Rat Pest Dungeon")
  dg2icon.onClick = function() g_game.talk("/opendgwindow 02,"..level..","..dg2) end
  dg2icon:setImageSource('/images/dungeons/buttons/02on.png')
  else
  dg2icon:setImageSource('/images/dungeons/buttons/02off.png')
  dg2icon:setTooltip("Rat Pest Dungeon\n\nRequisitos:"..(level < 14 and "\nVocê precisa de Level 14" or "")..""..(dg2 <= 0 and "\nVocê precisa completar a Rookie Forest Dungeon" or ""))
  dg2icon.onClick = nil
  end
  
  if dg3 > 0 and level >= 18 then
  dg3icon:setTooltip("Turtles Hideout Dungeon")
  dg3icon.onClick = function() g_game.talk("/opendgwindow 03,"..level..","..dg3) end
  dg3icon:setImageSource('/images/dungeons/buttons/03on.png')
  else
  dg3icon:setImageSource('/images/dungeons/buttons/03off.png')
  dg3icon:setTooltip("Turtles Hideout Dungeon\n\nRequisitos:"..(level < 18 and "\nVocê precisa de Level 18" or "")..""..(dg3 <= 0 and "\nVocê precisa completar a Rat Pest Dungeon" or ""))
  dg3icon.onClick = nil
  end
  
  if dg4 > 0 and level >= 22 then
  dg4icon:setTooltip("Stylish Fur Dungeon")
  dg4icon.onClick = function() g_game.talk("/opendgwindow 04,"..level..","..dg4) end
  dg4icon:setImageSource('/images/dungeons/buttons/04on.png')
  else
  dg4icon:setImageSource('/images/dungeons/buttons/04off.png')
  dg4icon:setTooltip("Stylish Fur Dungeon\n\nRequisitos:"..(level < 22 and "\nVocê precisa de Level 22" or "")..""..(dg4 <= 0 and "\nVocê precisa completar a Turtles Hideout Dungeon" or ""))
  dg4icon.onClick = nil
  end
  
  if dg5 > 0 and level >= 26 then
  dg5icon:setTooltip("Pimp Stick Dungeon")
  dg5icon.onClick = function() g_game.talk("/opendgwindow 05,"..level..","..dg5) end
  dg5icon:setImageSource('/images/dungeons/buttons/05on.png')
  else
  dg5icon:setImageSource('/images/dungeons/buttons/05off.png')
  dg5icon:setTooltip("Pimp Stick Dungeon\n\nRequisitos:"..(level < 26 and "\nVocê precisa de Level 26" or "")..""..(dg5 <= 0 and "\nVocê precisa completar a Stylish Fur Dungeon" or ""))
  dg5icon.onClick = nil
  end
  
  if dg6 > 0 and level >= 30 then
  dg6icon:setTooltip("Rock Prison Dungeon")
  dg6icon.onClick = function() g_game.talk("/opendgwindow 06,"..level..","..dg6) end
  dg6icon:setImageSource('/images/dungeons/buttons/06on.png')
  else
  dg6icon:setImageSource('/images/dungeons/buttons/06off.png')
  dg6icon:setTooltip("Rock Prison Dungeon\n\nRequisitos:"..(level < 30 and "\nVocê precisa de Level 30" or "")..""..(dg6 <= 0 and "\nVocê precisa completar a Pimp Stick Dungeon" or ""))
  dg6icon.onClick = nil
  end
  
  if dg11 > 0 and level >= 50 then
  dg11icon:setTooltip("Old Claw Dungeon")
  dg11icon.onClick = function() g_game.talk("/opendgwindow 11,"..level..","..dg11) end
  dg11icon:setImageSource('/images/dungeons/buttons/11on.png')
  else
  dg11icon:setImageSource('/images/dungeons/buttons/11off.png')
  dg11icon:setTooltip("Old Claw Dungeon\n\nRequisitos:"..(level < 50 and "\nVocê precisa de Level 50" or "")..""..(dg11 <= 0 and "\nVocê precisa completar a Rock Prison Dungeon" or ""))
  dg11icon.onClick = nil
  end
  
  if dg12 > 0 and level >= 54 then
  dg12icon:setTooltip("Racing Pilots Dungeon")
  dg12icon.onClick = function() g_game.talk("/opendgwindow 12,"..level..","..dg12) end
  dg12icon:setImageSource('/images/dungeons/buttons/12on.png')
  else
  dg12icon:setImageSource('/images/dungeons/buttons/12off.png')
  dg12icon:setTooltip("Racing Pilots Dungeon\n\nRequisitos:"..(level < 54 and "\nVocê precisa de Level 54" or "")..""..(dg12 <= 0 and "\nVocê precisa completar a Old Claw Dungeon" or ""))
  dg12icon.onClick = nil
  end
  
  if dg14 > 0 and level >= 62 then
  dg14icon:setTooltip("Rock Solid Dungeon")
  dg14icon.onClick = function() g_game.talk("/opendgwindow 14,"..level..","..dg14) end
  dg14icon:setImageSource('/images/dungeons/buttons/14on.png')
  else
  dg14icon:setImageSource('/images/dungeons/buttons/14off.png')
  dg14icon:setTooltip("Rock Solid Dungeon\n\nRequisitos:"..(level < 62 and "\nVocê precisa de Level 62" or "")..""..(dg14 <= 0 and "\nVocê precisa completar a Racing Pilots Dungeon" or ""))
  dg14icon.onClick = nil
  end
  
  if dg18 > 0 and level >= 78 then
  dg18icon:setTooltip("Purplebeard Dungeon")
  dg18icon.onClick = function() g_game.talk("/opendgwindow 18,"..level..","..dg18) end
  dg18icon:setImageSource('/images/dungeons/buttons/18on.png')
  else
  dg18icon:setImageSource('/images/dungeons/buttons/18off.png')
  dg18icon:setTooltip("Purplebeard Dungeon\n\nRequisitos:"..(level < 78 and "\nVocê precisa de Level 78" or "")..""..(dg18 <= 0 and "\nVocê precisa completar a Rock Solid Dungeon" or ""))
  dg18icon.onClick = nil
  end
  
  if dg23 > 0 and level >= 98 then
  dg23icon:setTooltip("Assassin Scyther Dungeon")
  dg23icon.onClick = function() g_game.talk("/opendgwindow 23,"..level..","..dg23) end
  dg23icon:setImageSource('/images/dungeons/buttons/23on.png')
  else
  dg23icon:setImageSource('/images/dungeons/buttons/23off.png')
  dg23icon:setTooltip("Assassin Scyther Dungeon\n\nRequisitos:"..(level < 98 and "\nVocê precisa de Level 98" or "")..""..(dg23 <= 0 and "\nVocê precisa completar a Purplebeard Dungeon" or ""))
  dg23icon.onClick = nil
  end
  
  if dg30 > 0 and level >= 126 then
  dg30icon:setTooltip("Skull Charizard Dungeon")
  dg30icon.onClick = function() g_game.talk("/opendgwindow 30,"..level..","..dg30) end
  dg30icon:setImageSource('/images/dungeons/buttons/30on.png')
  else
  dg30icon:setImageSource('/images/dungeons/buttons/30off.png')
  dg30icon:setTooltip("Skull Charizard Dungeon\n\nRequisitos:"..(level < 126 and "\nVocê precisa de Level 126" or "")..""..(dg30 <= 0 and "\nVocê precisa completar a Assassin Scyther Dungeon" or ""))
  dg30icon.onClick = nil
  end
  
  if dg31 > 0 and level >= 130 then
  dg31icon:setTooltip("Ninja Turtles Dungeon")
  dg31icon.onClick = function() g_game.talk("/opendgwindow 31,"..level..","..dg31) end
  dg31icon:setImageSource('/images/dungeons/buttons/31on.png')
  else
  dg31icon:setImageSource('/images/dungeons/buttons/31off.png')
  dg31icon:setTooltip("Ninja Turtles Dungeon\n\nRequisitos:"..(level < 130 and "\nVocê precisa de Level 130" or "")..""..(dg31 <= 0 and "\nVocê precisa completar a Skull Charizard Dungeon" or ""))
  dg31icon.onClick = nil
  end
  
  if dg32 > 0 and level >= 134 then
  dg32icon:setTooltip("Royal Dungeon")
  dg32icon.onClick = function() g_game.talk("/opendgwindow 32,"..level..","..dg32) end
  dg32icon:setImageSource('/images/dungeons/buttons/32on.png')
  else
  dg32icon:setImageSource('/images/dungeons/buttons/32off.png')
  dg32icon:setTooltip("Royal Dungeon\n\nRequisitos:"..(level < 134 and "\nVocê precisa de Level 134" or "")..""..(dg32 <= 0 and "\nVocê precisa completar a Ninja Turtles Dungeon" or ""))
  dg32icon.onClick = nil
  end
  
  if dg33 > 0 and level >= 138 then
  dg33icon:setTooltip("Crystal Dungeon")
  dg33icon.onClick = function() g_game.talk("/opendgwindow 33,"..level..","..dg33) end
  dg33icon:setImageSource('/images/dungeons/buttons/33on.png')
  else
  dg33icon:setImageSource('/images/dungeons/buttons/33off.png')
  dg33icon:setTooltip("Crystal Dungeon\n\nRequisitos:"..(level < 138 and "\nVocê precisa de Level 138" or "")..""..(dg33 <= 0 and "\nVocê precisa completar a Royal Dungeon" or ""))
  dg33icon.onClick = nil
  end
  
  
end


--[[function actBB()
  buyButton = dpanelWindow:getChildById('buyButton') or getChildById('buyButton')
  buyButton:setVisible(true)
end]]

function showWindow(dungeonN, level, stars, timewait)
	if not dpanelWindow:isVisible() then 
		return true
	elseif not dungeonWindow:isVisible() then
		addEvent(function() g_effects.fadeIn(dungeonWindow, 250) end)
	end
  dungeonWindow:show()
  dungeonWindow:raise()
  dungeonWindow:focus()
  dungeonInfo = dungeonWindow:getChildById('dungeonInfo')
  dungeonInfo:setImageSource('/images/dungeons/infos/'..dungeonN..'.png')
  dungeonLevel = dungeonWindow:getChildById('dungeonLevel')
  level = tonumber(level)
  stars = tonumber(stars)
  if tonumber(dungeonN) <= 10 then
  if (dungeonslevel[dungeonN]+3) >= level then
  dungeonLevel:setImageSource('/images/dungeons/levels/'..dungeonN..'red.png')
  elseif (dungeonslevel[dungeonN]+10) >= level then
  dungeonLevel:setImageSource('/images/dungeons/levels/'..dungeonN..'orange.png')
  elseif (dungeonslevel[dungeonN]+20) >= level then
  dungeonLevel:setImageSource('/images/dungeons/levels/'..dungeonN..'yellow.png')
  elseif (dungeonslevel[dungeonN]+60) > level then
  dungeonLevel:setImageSource('/images/dungeons/levels/'..dungeonN..'green.png')
  else
  dungeonLevel:setImageSource('/images/dungeons/levels/'..dungeonN..'gray.png')
  end
  elseif tonumber(dungeonN) >= 11 and tonumber(dungeonN) <= 25 then
  if (dungeonslevel[dungeonN]+3) >= level then
  dungeonLevel:setImageSource('/images/dungeons/levels/'..dungeonN..'red.png')
  elseif (dungeonslevel[dungeonN]+10) >= level then
  dungeonLevel:setImageSource('/images/dungeons/levels/'..dungeonN..'orange.png')
  elseif (dungeonslevel[dungeonN]+30) >= level then
  dungeonLevel:setImageSource('/images/dungeons/levels/'..dungeonN..'yellow.png')
  elseif (dungeonslevel[dungeonN]+80) > level then
  dungeonLevel:setImageSource('/images/dungeons/levels/'..dungeonN..'green.png')
  else
  dungeonLevel:setImageSource('/images/dungeons/levels/'..dungeonN..'gray.png')
  end
  elseif tonumber(dungeonN) >= 26 then
  if (dungeonslevel[dungeonN]+5) >= level then
  dungeonLevel:setImageSource('/images/dungeons/levels/'..dungeonN..'red.png')
  elseif (dungeonslevel[dungeonN]+15) >= level then
  dungeonLevel:setImageSource('/images/dungeons/levels/'..dungeonN..'orange.png')
  elseif (dungeonslevel[dungeonN]+40) >= level then
  dungeonLevel:setImageSource('/images/dungeons/levels/'..dungeonN..'yellow.png')
  elseif (dungeonslevel[dungeonN]+100) > level then
  dungeonLevel:setImageSource('/images/dungeons/levels/'..dungeonN..'green.png')
  else
  dungeonLevel:setImageSource('/images/dungeons/levels/'..dungeonN..'gray.png')
  end
  end
  
  dungeonStars = dungeonWindow:getChildById('stars')
  increaseStarsButton = dungeonWindow:getChildById('increaseStar')
  decreaseStarsButton = dungeonWindow:getChildById('decreaseStar')
  if stars == 2 then
  dungeonStars:setImageSource('/images/dungeons/starbutton/1a.png')
  increaseStarsButton:setImageSource('/images/dungeons/starbutton/+on.png')
  elseif stars >= 3 and stars <= 5 then
  dungeonStars:setImageSource('/images/dungeons/starbutton/1.png')
  increaseStarsButton:setImageSource('/images/dungeons/starbutton/+on.png')
  else
  dungeonStars:setImageSource('/images/dungeons/starbutton/1b.png')
  increaseStarsButton:setImageSource('/images/dungeons/starbutton/+off.png')
  end
  
  starselected = 1
  dungeonNumber = dungeonN
  totalstars = stars
  
  dungeonWindow:getChildById('item1'):setItemId(0)
  dungeonWindow:getChildById('item2'):setItemId(0)
  dungeonWindow:getChildById('item3'):setItemId(0)
  dungeonWindow:getChildById('item4'):setItemId(0)
  dungeonWindow:getChildById('item5'):setItemId(0)
  dungeonWindow:getChildById('item6'):setItemId(0)
  dungeonWindow:getChildById('item7'):setItemId(0)
  dungeonWindow:getChildById('item8'):setItemId(0)
  dungeonWindow:getChildById('item1'):setTooltip("")
  dungeonWindow:getChildById('item2'):setTooltip("")
  dungeonWindow:getChildById('item3'):setTooltip("")
  dungeonWindow:getChildById('item4'):setTooltip("")
  dungeonWindow:getChildById('item5'):setTooltip("")
  dungeonWindow:getChildById('item6'):setTooltip("")
  dungeonWindow:getChildById('item7'):setTooltip("")
  dungeonWindow:getChildById('item8'):setTooltip("")
  
  if dungeonN == "01" then
  dungeonWindow:getChildById('item1'):setItemId(15026)
  dungeonWindow:getChildById('item2'):setItemId(15009)
  dungeonWindow:getChildById('item3'):setItemId(15010)
  dungeonWindow:getChildById('item4'):setItemId(15011)
  dungeonWindow:getChildById('item5'):setItemId(12961)
  dungeonWindow:getChildById('item6'):setItemId(12963)
  dungeonWindow:getChildById('item1'):setTooltip("Bronze Ticket")
  dungeonWindow:getChildById('item2'):setTooltip("Magician Hat\nAddon para Pidgey")
  dungeonWindow:getChildById('item3'):setTooltip("Skeleton Mask\nAddon para Pidgey")
  dungeonWindow:getChildById('item4'):setTooltip("Zombie Mask\nAddon para Pidgey")
  dungeonWindow:getChildById('item5'):setTooltip("Wingeon Backpack")
  dungeonWindow:getChildById('item6'):setTooltip("Gardestrike Backpack")
  
  elseif dungeonN == "02" then
  dungeonWindow:getChildById('item1'):setItemId(15026)
  dungeonWindow:getChildById('item2'):setItemId(13780)
  dungeonWindow:getChildById('item3'):setItemId(12963)
  dungeonWindow:getChildById('item1'):setTooltip("Bronze Ticket")
  dungeonWindow:getChildById('item2'):setTooltip("Master Rat Costume\nAddon para Raticate")
  dungeonWindow:getChildById('item3'):setTooltip("Gardestrike Backpack")
  
  elseif dungeonN == "03" then
  dungeonWindow:getChildById('item1'):setItemId(15026)
  dungeonWindow:getChildById('item2'):setItemId(13776)
  dungeonWindow:getChildById('item3'):setItemId(15747)
  dungeonWindow:getChildById('item4'):setItemId(12968)
  dungeonWindow:getChildById('item1'):setTooltip("Bronze Ticket")
  dungeonWindow:getChildById('item2'):setTooltip("Squad Jacket\nAddon para Squirtle")
  dungeonWindow:getChildById('item3'):setTooltip("Squad Leader Jacket\nAddon para Squirtle")
  dungeonWindow:getChildById('item4'):setTooltip("Seavell Backpack")
  
  elseif dungeonN == "04" then
  dungeonWindow:getChildById('item1'):setItemId(15026)
  dungeonWindow:getChildById('item2'):setItemId(13721)
  dungeonWindow:getChildById('item3'):setItemId(13718)
  dungeonWindow:getChildById('item4'):setItemId(12967)
  dungeonWindow:getChildById('item1'):setTooltip("Bronze Ticket")
  dungeonWindow:getChildById('item2'):setTooltip("Dog Collar\nAddon para Growlithe")
  dungeonWindow:getChildById('item3'):setTooltip("Stylish Fur\nAddon para Growlithe")
  dungeonWindow:getChildById('item4'):setTooltip("Volcanic Backpack")
  
  elseif dungeonN == "05" then
  dungeonWindow:getChildById('item1'):setItemId(15026)
  dungeonWindow:getChildById('item2'):setItemId(13777)
  dungeonWindow:getChildById('item3'):setItemId(13795)
  dungeonWindow:getChildById('item4'):setItemId(12961)
  dungeonWindow:getChildById('item5'):setItemId(12963)
  dungeonWindow:getChildById('item1'):setTooltip("Bronze Ticket")
  dungeonWindow:getChildById('item2'):setTooltip("Flying Glasses\nAddon para Pidgeotto")
  dungeonWindow:getChildById('item3'):setTooltip("Pimp Costume\nAddon para Farfetch'd")
  dungeonWindow:getChildById('item4'):setTooltip("Wingeon Backpack")
  dungeonWindow:getChildById('item5'):setTooltip("Gardestrike Backpack")
  
  elseif dungeonN == "06" then
  dungeonWindow:getChildById('item1'):setItemId(15026)
  dungeonWindow:getChildById('item2'):setItemId(15749)
  dungeonWindow:getChildById('item3'):setItemId(15748)
  dungeonWindow:getChildById('item4'):setItemId(12965)
  dungeonWindow:getChildById('item1'):setTooltip("Bronze Ticket")
  dungeonWindow:getChildById('item2'):setTooltip("Doomed Costume\nAddon para Graveler")
  dungeonWindow:getChildById('item3'):setTooltip("Prisoner Costume\nAddon para Graveler")
  dungeonWindow:getChildById('item4'):setTooltip("Orebound Backpack")
  
  elseif dungeonN == "11" then
  dungeonWindow:getChildById('item1'):setItemId(15027)
  dungeonWindow:getChildById('item2'):setItemId(15717)
  dungeonWindow:getChildById('item3'):setItemId(13783)
  dungeonWindow:getChildById('item4'):setItemId(13784)
  dungeonWindow:getChildById('item5'):setItemId(13785)
  dungeonWindow:getChildById('item6'):setItemId(12965)
  dungeonWindow:getChildById('item1'):setTooltip("Silver Ticket")
  dungeonWindow:getChildById('item2'):setTooltip("Orebound Essence")
  dungeonWindow:getChildById('item3'):setTooltip("Metal Claws\nAddon para Sandslash")
  dungeonWindow:getChildById('item4'):setTooltip("Old Man Glasses\nAddon para Sandslash")
  dungeonWindow:getChildById('item5'):setTooltip("Z-Shirt\nAddon para Sandslash")
  dungeonWindow:getChildById('item6'):setTooltip("Orebound Backpack")
  
  elseif dungeonN == "12" then
  dungeonWindow:getChildById('item1'):setItemId(15716)
  dungeonWindow:getChildById('item2'):setItemId(13271)
  dungeonWindow:getChildById('item3'):setItemId(15038)
  dungeonWindow:getChildById('item4'):setItemId(15039)
  dungeonWindow:getChildById('item5'):setItemId(15040)
  dungeonWindow:getChildById('item6'):setItemId(15037)
  dungeonWindow:getChildById('item7'):setItemId(12961)
  dungeonWindow:getChildById('item8'):setItemId(12963)
  dungeonWindow:getChildById('item1'):setTooltip("Wingeon Essence")
  dungeonWindow:getChildById('item2'):setTooltip("Pidgeot Bag")
  dungeonWindow:getChildById('item3'):setTooltip("Purple Scarf\nAddon para Pidgeot")
  dungeonWindow:getChildById('item4'):setTooltip("Green Scarf\nAddon para Pidgeot")
  dungeonWindow:getChildById('item5'):setTooltip("Blue Scarf\nAddon para Pidgeot")
  dungeonWindow:getChildById('item6'):setTooltip("Flying Glasses\nAddon para Pidgeot")
  dungeonWindow:getChildById('item7'):setTooltip("Wingeon Backpack")
  dungeonWindow:getChildById('item8'):setTooltip("Gardestrike Backpack")
  
  elseif dungeonN == "14" then
  dungeonWindow:getChildById('item1'):setItemId(15027)
  dungeonWindow:getChildById('item2'):setItemId(15717)
  dungeonWindow:getChildById('item3'):setItemId(15042)
  dungeonWindow:getChildById('item4'):setItemId(15041)
  dungeonWindow:getChildById('item5'):setItemId(12965)
  dungeonWindow:getChildById('item1'):setTooltip("Silver Ticket")
  dungeonWindow:getChildById('item2'):setTooltip("Orebound Essence")
  dungeonWindow:getChildById('item3'):setTooltip("Spiked Armlet\nAddon para Rhydon")
  dungeonWindow:getChildById('item4'):setTooltip("Berserker Flails\nAddon para Rhydon")
  dungeonWindow:getChildById('item5'):setTooltip("Orebound Backpack")
  
  elseif dungeonN == "18" then
  dungeonWindow:getChildById('item1'):setItemId(15027)
  dungeonWindow:getChildById('item2'):setItemId(15719)
  dungeonWindow:getChildById('item3'):setItemId(13796)
  dungeonWindow:getChildById('item4'):setItemId(13797)
  dungeonWindow:getChildById('item5'):setItemId(12969)
  dungeonWindow:getChildById('item1'):setTooltip("Silver Ticket")
  dungeonWindow:getChildById('item2'):setTooltip("Malefic Essence")
  dungeonWindow:getChildById('item3'):setTooltip("Pirate Bandana\nAddon para Gengar")
  dungeonWindow:getChildById('item4'):setTooltip("Purplebeard Costume\nAddon para Gengar")
  dungeonWindow:getChildById('item5'):setTooltip("Malefic Backpack")
  
  elseif dungeonN == "23" then
  dungeonWindow:getChildById('item1'):setItemId(15027)
  dungeonWindow:getChildById('item2'):setItemId(15716)
  dungeonWindow:getChildById('item3'):setItemId(15713)
  dungeonWindow:getChildById('item4'):setItemId(14792)
  dungeonWindow:getChildById('item5'):setItemId(14790)
  dungeonWindow:getChildById('item6'):setItemId(14791)
  dungeonWindow:getChildById('item7'):setItemId(12961)
  dungeonWindow:getChildById('item8'):setItemId(12964)
  dungeonWindow:getChildById('item1'):setTooltip("Silver Ticket")
  dungeonWindow:getChildById('item2'):setTooltip("Wingeon Essence")
  dungeonWindow:getChildById('item3'):setTooltip("Naturia Essence")
  dungeonWindow:getChildById('item4'):setTooltip("Scar Makeup\nAddon para Scyther")
  dungeonWindow:getChildById('item5'):setTooltip("Assassin's Cape\nAddon para Scyther")
  dungeonWindow:getChildById('item6'):setTooltip("Assassin's Cape\nAddon para Scyther")
  dungeonWindow:getChildById('item7'):setTooltip("Wingeon Backpack")
  dungeonWindow:getChildById('item8'):setTooltip("Naturia Backpack")
  
  elseif dungeonN == "30" then
  dungeonWindow:getChildById('item1'):setItemId(15028)
  dungeonWindow:getChildById('item2'):setItemId(13266)
  dungeonWindow:getChildById('item3'):setItemId(13708)
  dungeonWindow:getChildById('item4'):setItemId(13717)
  dungeonWindow:getChildById('item5'):setItemId(12961)
  dungeonWindow:getChildById('item6'):setItemId(12967)
  dungeonWindow:getChildById('item7'):setItemId(13279)
  dungeonWindow:getChildById('item8'):setItemId(12203)
  dungeonWindow:getChildById('item1'):setTooltip("Gold Ticket")
  dungeonWindow:getChildById('item2'):setTooltip("Charizard Bag")
  dungeonWindow:getChildById('item3'):setTooltip("Scar Makeup\nAddon para Charizard")
  dungeonWindow:getChildById('item4'):setTooltip("Charla Flower\nAddon para Charizard")
  dungeonWindow:getChildById('item5'):setTooltip("Wingeon Backpack")
  dungeonWindow:getChildById('item6'):setTooltip("Volcanic Backpack")
  dungeonWindow:getChildById('item7'):setTooltip("Shiny Charizard Bag")
  dungeonWindow:getChildById('item8'):setTooltip("Skull Set\nAddon para Shiny Charizard")
  
  elseif dungeonN == "31" then
  dungeonWindow:getChildById('item1'):setItemId(14819)
  dungeonWindow:getChildById('item2'):setItemId(14820)
  dungeonWindow:getChildById('item3'):setItemId(14821)
  dungeonWindow:getChildById('item4'):setItemId(14822)
  dungeonWindow:getChildById('item5'):setItemId(14823)
  dungeonWindow:getChildById('item6'):setItemId(12968)
  dungeonWindow:getChildById('item7'):setItemId(14868)
  dungeonWindow:getChildById('item8'):setItemId(14825)
  dungeonWindow:getChildById('item1'):setTooltip("Scar Makeup\nAddon para Blastoise")
  dungeonWindow:getChildById('item2'):setTooltip("Ninja Costume\nAddon para Blastoise")
  dungeonWindow:getChildById('item3'):setTooltip("Ninja Costume\nAddon para Blastoise")
  dungeonWindow:getChildById('item4'):setTooltip("Ninja Costume\nAddon para Blastoise")
  dungeonWindow:getChildById('item5'):setTooltip("Ninja Costume\nAddon para Blastoise")
  dungeonWindow:getChildById('item6'):setTooltip("Seavell Backpack")
  dungeonWindow:getChildById('item7'):setTooltip("Shiny Blastoise Bag")
  dungeonWindow:getChildById('item8'):setTooltip("Ninja Costume\nAddon para Shiny Blastoise")
  
  elseif dungeonN == "32" then
  dungeonWindow:getChildById('item1'):setItemId(15032)
  dungeonWindow:getChildById('item2'):setItemId(15019)
  dungeonWindow:getChildById('item3'):setItemId(15020)
  dungeonWindow:getChildById('item4'):setItemId(15021)
  dungeonWindow:getChildById('item5'):setItemId(12969)
  dungeonWindow:getChildById('item6'):setItemId(12965)
  dungeonWindow:getChildById('item7'):setItemId(15031)
  dungeonWindow:getChildById('item8'):setItemId(15012)
  dungeonWindow:getChildById('item1'):setTooltip("Nidoqueen Bag")
  dungeonWindow:getChildById('item2'):setTooltip("Royal Swords\nAddon para Nidoking")
  dungeonWindow:getChildById('item3'):setTooltip("Royal Weapons\nAddon para Nidoking")
  dungeonWindow:getChildById('item4'):setTooltip("Magician Weapons\nAddon para Nidoqueen")
  dungeonWindow:getChildById('item5'):setTooltip("Malefic Backpack")
  dungeonWindow:getChildById('item6'):setTooltip("Orebound Backpack")
  dungeonWindow:getChildById('item7'):setTooltip("Shiny Nidoking Bag")
  dungeonWindow:getChildById('item8'):setTooltip("King Crown\nAddon para Shiny Nidoking")
  
  elseif dungeonN == "33" then
  dungeonWindow:getChildById('item1'):setItemId(15717)
  dungeonWindow:getChildById('item2'):setItemId(15028)
  dungeonWindow:getChildById('item3'):setItemId(14815)
  dungeonWindow:getChildById('item4'):setItemId(14817)
  dungeonWindow:getChildById('item5'):setItemId(12965)
  dungeonWindow:getChildById('item6'):setItemId(14870)
  dungeonWindow:getChildById('item7'):setItemId(13738)
  dungeonWindow:getChildById('item1'):setTooltip("Orebound Essence")
  dungeonWindow:getChildById('item2'):setTooltip("Gold Ticket")
  dungeonWindow:getChildById('item3'):setTooltip("Crystal Makeup\nAddon para Rhyhorn")
  dungeonWindow:getChildById('item4'):setTooltip("Crystal Makeup\nAddon para Graveler")
  dungeonWindow:getChildById('item5'):setTooltip("Orebound Backpack")
  dungeonWindow:getChildById('item6'):setTooltip("Crystal Onix Bag")
  dungeonWindow:getChildById('item7'):setTooltip("Crystal Shiny Orb")
  end
  
  local dgTimeWait = dungeonWindow:getChildById('dungeonTimeWait')
  if timewait and timewait ~= "already" and tonumber(timewait) and tonumber(timewait) > 0 then
  dgTimeWait:setVisible(true)
  removeEvent(dgtwbeautyclock)
  doBeautyClockmytimewait(tonumber(timewait))
  else
  dgTimeWait:setVisible(false)
  removeEvent(dgtwbeautyclock)
  end
end

function doBeautyClockmytimewait(timewait)
	if not dpanelWindow or not dungeonWindow or not dpanelWindow:isVisible() or not dungeonWindow:isVisible() then return true end
	local dgTimeWait = dungeonWindow:getChildById('dungeonTimeWait')
	if not dgTimeWait then return true elseif timewait <= 0 then dgTimeWait:setVisible(false) removeEvent(dgtwbeautyclock) return true end
	local tempo = getbeautymytempo(timewait)
	dgTimeWait:getChildById('hour1'):setImageSource('/images/dungeons/timeWait/'.. tempo.h1 ..'.png')
	dgTimeWait:getChildById('hour2'):setImageSource('/images/dungeons/timeWait/'.. tempo.h2 ..'.png')
	dgTimeWait:getChildById('minu1'):setImageSource('/images/dungeons/timeWait/'.. tempo.m1 ..'.png')
	dgTimeWait:getChildById('minu2'):setImageSource('/images/dungeons/timeWait/'.. tempo.m2 ..'.png')
	dgTimeWait:getChildById('sec1'):setImageSource('/images/dungeons/timeWait/'.. tempo.s1 ..'.png')
	dgTimeWait:getChildById('sec2'):setImageSource('/images/dungeons/timeWait/'.. tempo.s2 ..'.png')
	dgtwbeautyclock = scheduleEvent(function() doBeautyClockmytimewait(timewait-1) end,1000)
end

function setTimeLeft(timeleft)
	removeEvent(dgtlbeautyclock)
	if not timeleft or not tonumber(timeleft) or timeleft == "end" then
	--removeEvent(dgtlbeautyclock)
		dgTimeLeft:setVisible(false)
		--hideTimeLeft()
	else
		dgTimeLeft:show()
		dgTimeLeft:raise()
		--dgTimeLeft:setVisible(true)
		doBeautyClockmytimeleft(tonumber(timeleft))
	end
	return true
end


function doBeautyClockmytimeleft(timeleft)
	if not dgTimeLeft then return true elseif timeleft <= 0 then dgTimeLeft:setVisible(false) return true end
	local tempo = getbeautymytempo(timeleft)
	dgTimeLeft:getChildById('min1'):setImageSource('/images/dungeons/timeLeft/'.. tempo.m1 ..'.png')
	dgTimeLeft:getChildById('min2'):setImageSource('/images/dungeons/timeLeft/'.. tempo.m2 ..'.png')
	dgTimeLeft:getChildById('se1'):setImageSource('/images/dungeons/timeLeft/'.. tempo.s1 ..'.png')
	dgTimeLeft:getChildById('se2'):setImageSource('/images/dungeons/timeLeft/'.. tempo.s2 ..'.png')
	dgtlbeautyclock = scheduleEvent(function() doBeautyClockmytimeleft(timeleft-1) end,1000)
	return true
end

function getbeautymytempo(number)
local s2 = number
local s1 = 0
local m2 = 0
local m1 = 0
local h2 = 0
local h1 = 0
	for a = 1, math.floor(number/10) do
	if s2 <= 9 then
	return {h1 = h1, h2 = h2, m1 = m1, m2 = m2, s1 = s1, s2 = s2}
	else
	s2 = s2 - 10
	s1 = s1 + 1
	if s1 >= 6 then
		s1 = 0
		m2 = m2 + 1
		if m2 >= 10 then
			m2 = 0
			m1 = m1 + 1
			if m1 >= 6 then
				m1 = 0
				h2 = h2 + 1
				if h2 >= 10 then
					h2 = 0
					h1 = h1 + 1
				end
			end
		end
	end
	end
	end
	return {h1 = h1, h2 = h2, m1 = m1, m2 = m2, s1 = s1, s2 = s2}
end


function hideTimeLeft()
	addEvent(function() g_effects.fadeOut(dgTimeLeft, 250) end)
	scheduleEvent(function() dgTimeLeft:hide() end, 250)
end


function hideShop()
	addEvent(function() g_effects.fadeOut(dgShop, 250) end)
	scheduleEvent(function() dgShop:hide() end, 250)
	addEvent(function() g_effects.fadeOut(buyWindow, 250) end)
	scheduleEvent(function() buyWindow:hide() end, 250)
end

function hideBuyWindow()
	addEvent(function() g_effects.fadeOut(buyWindow, 250) end)
	scheduleEvent(function() buyWindow:hide() end, 250)
end

function hide()
	addEvent(function() g_effects.fadeOut(dpanelWindow, 250) end)
	scheduleEvent(function() dpanelWindow:hide() end, 250)
	addEvent(function() g_effects.fadeOut(dungeonWindow, 250) end)
	scheduleEvent(function() dungeonWindow:hide() end, 250)
	hideShop()
end


function increaseStar()
  if starselected >= 3 then return true end
  if starselected >= totalstars then return true end
  decreaseStarsButton:setImageSource('/images/dungeons/starbutton/-on.png')
  if starselected == 1 then
  if totalstars == 2 then
  dungeonStars:setImageSource('/images/dungeons/starbutton/2a.png')
  elseif totalstars >= 3 and totalstars <= 5 then
  dungeonStars:setImageSource('/images/dungeons/starbutton/2.png')
  end
  elseif starselected == 2 then
  dungeonStars:setImageSource('/images/dungeons/starbutton/3.png')
  end
  starselected = starselected+1
  if starselected >= totalstars or starselected >= 3 then
  increaseStarsButton:setImageSource('/images/dungeons/starbutton/+off.png')
 -- else
 -- increaseStarsButton:setImageSource('/images/dungeons/starbutton/+on.png')
  end
end

function decreaseStar()
  if starselected <= 1 then return true end
  increaseStarsButton:setImageSource('/images/dungeons/starbutton/+on.png')
  if starselected == 2 then
  if totalstars == 2 then
  dungeonStars:setImageSource('/images/dungeons/starbutton/1a.png')
  elseif totalstars >= 3 and totalstars <= 5 then
  dungeonStars:setImageSource('/images/dungeons/starbutton/1.png')
  end
  elseif starselected == 3 then
  dungeonStars:setImageSource('/images/dungeons/starbutton/2.png')
  end
  starselected = starselected-1
  if starselected <= 1 then
  decreaseStarsButton:setImageSource('/images/dungeons/starbutton/-off.png')
 -- else
 -- increaseStarsButton:setImageSource('/images/dungeons/starbutton/+on.png')
  end
end

function startDungeon()
g_game.talk("!startdg"..dungeonNumber.."star"..starselected.."")
hide()
end

function hideWindow()
  addEvent(function() g_effects.fadeOut(dungeonWindow, 250) end)
  scheduleEvent(function() dungeonWindow:hide() end, 250)
end

function updateTeamButtons(team,leader)
	teamButton1 = dpanelWindow:getChildById('teamButton1')
	teamButton2 = dpanelWindow:getChildById('teamButton2')
	teamButton3 = dpanelWindow:getChildById('teamButton3')
	teamButton4 = dpanelWindow:getChildById('teamButton4')
	if tonumber(team) and (team == -1 or tonumber(team) == -1) then
		teamButton1:setImageSource('/images/dungeons/createteambutton.png')
		teamButton2:setImageSource('/images/dungeons/seeinvites.png')
		teamButton1.onClick = function() g_ui.displayUI('createteam'):setVisible(true) end
		teamButton2.onClick = function() g_game.talk("/seedgteaminvites") end
		teamButton3:setVisible(false)
		teamButton4:setVisible(false)
	elseif leader and leader == "true" then
		teamButton1:setImageSource('/images/dungeons/teaminfo.png')
		teamButton1.onClick = function() g_game.talk("/showdgteaminfo") end
		teamButton3:setVisible(true)
		teamButton4:setVisible(true)
		teamButton2:setImageSource('/images/dungeons/invitebutton.png')
		teamButton3:setImageSource('/images/dungeons/kickplayer.png')
		teamButton4:setImageSource('/images/dungeons/leaveteambutton.png')
		teamButton2.onClick = function() g_ui.displayUI('inviteplayer'):setVisible(true) end
		teamButton3.onClick = function() g_ui.displayUI('kickplayer'):setVisible(true) end
		teamButton4.onClick = function() g_game.talk("/quitdgteam") end
	else
		teamButton1:setImageSource('/images/dungeons/teaminfo.png')
		teamButton1.onClick = function() g_game.talk("/showdgteaminfo") end
		teamButton4:setVisible(false)
		teamButton3:setVisible(false)
		teamButton2:setImageSource('/images/dungeons/leaveteambutton.png')
		teamButton2.onClick = function() g_game.talk("/quitdgteam") end
	end
end

function seeInvites(invites, some)
if some and some == "some" and (not invitesWindow or not invitesWindow:isVisible()) then return true end

if not invitesWindow and (not some or some ~= "some") then
  invitesWindow = g_ui.displayUI('seeinvites')
end
	if not invitesWindow:isVisible() and (not some or some ~= "some") then
		invitesWindow:show()
		invitesWindow:raise()
	end
	if invites == "close" then
		invitesWindow:hide()
		return true
	end
	alonelabel = invitesWindow:getChildById('alone')
	invite1label = invitesWindow:getChildById('invite1')
	invite2label = invitesWindow:getChildById('invite2')
	invite3label = invitesWindow:getChildById('invite3')
	if tonumber(invites) == -1 then 
		alonelabel:setVisible(true)
		invite1label:setVisible(false)
		invite2label:setVisible(false)
		invite3label:setVisible(false)
	else
		local invite = string.explode(invites, '|')
		if #invite < 1 then print("Esse dungeon team ta bugado <(o.O)>") return true end
		alonelabel:setVisible(false)
		invite1label:setVisible(true)
		invite1label:setText(invite[1])
		if #invite >= 2 then
			invite2label:setVisible(true)
			invite2label:setText(invite[2])
		if #invite >= 3 then
			invite3label:setVisible(true)
			invite3label:setText(invite[3])
		else
			invite3label:setVisible(false)
		end
		else
			invite2label:setVisible(false)
			invite3label:setVisible(false)
		end
	end
	return true
end

function showDGShop(dgcoins)
	if not dpanelWindow:isVisible() then 
		return true
	elseif not dgShop:isVisible() then
		addEvent(function() g_effects.fadeIn(dgShop, 250) end)
	end
	dgShop:show()
	dgShop:raise()
	dgShop:focus()
	dgCoinsQuant = dgShop:getChildById('count1')
    dgCoinsQuant:setText(dgcoins)
	return true
end

function doBuyDGShopItem(item)
	local itemToName = {
		["mysticstar"] = "a Mystic Star",
		["10bronzetickets"] = "10 Bronze Tickets",
		["10silvertickets"] = "10 Silver Tickets",
		["10goldtickets"] = "10 Gold Tickets",
		["30dungeontokens"] = "30 Dungeon Tokens",
		["65dungeontokens"] = "65 Dungeon Tokens",
		["100dungeontokens"] = "100 Dungeon Tokens",
		["volcanictapestry"] = "a Volcanic Tapestry",
		["seavelltapestry"] = "a Seavell Tapestry",
		["naturiatapestry"] = "a Naturia Tapestry",
		["raibolttapestry"] = "a Raibolt Tapestry",
		["gardestriketapestry"] = "a Gardestrike Tapestry",
		["wingeontapestry"] = "a Wingeon Tapestry",
		["oreboundtapestry"] = "an Orebound Tapestry",
		["psycrafttapestry"] = "a Psycraft Tapestry",
		["malefictapestry"] = "a Malefic Tapestry",
		["urnbox"] = "an Urn Box",
		["volcanicurn"] = "a Volcanic Urn",
		["seavellurn"] = "a Seavell Urn",
		["naturiaurn"] = "a Naturia Urn",
		["raibolturn"] = "a Raibolt Urn",
		["gardestrikeurn"] = "a Gardestrike Urn",
		["wingeonurn"] = "a Wingeon Urn",
		["oreboundurn"] = "an Orebound Urn",
		["psycrafturn"] = "a Psycraft Urn",
		["maleficurn"] = "a Malefic Urn",
	}
	if not itemToName[item] or not dgShop:isVisible() then print(item) return true
	elseif not buyWindow:isVisible() then
		addEvent(function() g_effects.fadeIn(buyWindow, 250) end)
	end
	buyWindow:show()
	buyWindow:raise()
	buyWindow:focus()
	buyWindow:setText("Buy Item")
	local msg = "Are you sure buy "..itemToName[item].." ?"
	buyWindow:getChildById('buyItemText'):setText(msg)
	buyWindow:getChildById('buyButton').onClick = function() g_game.talk("/buyDGShop "..item) hideBuyWindow() end
	return true
end