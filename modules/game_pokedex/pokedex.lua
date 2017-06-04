pokedexWindow = nil
thestats = nil
thetypes = nil
evoboost = nil
eoq = nil
pokedexIcon = modules.mod_topMenu.getPokedexIcon()


getStoneIDByName = {
["Leaf Stone"] = 10530,
["Water Stone"] = 10531,
["Venom Stone"] = 10532,
["Thunder Stone"] = 10533,
["Rock Stone"] = 10534,
["Punch Stone"] = 10535,
["Fire Stone"] = 10536,
["Cocoon Stone"] = 10537,
["Crystal Stone"] = 10538,
["Darkness Stone"] = 10539,
["Earth Stone"] = 10540,
["Enigma Stone"] = 10541,
["Heart Stone"] = 10542,
["Ice Stone"] = 10543,
["Ancient Stone"] = 13660,
["Metal Stone"] = 13661,
["Feather Stone"] = 13662,
["Shiny Leaf Stone"] = 13722,
["Shiny Water Stone"] = 13723,
["Shiny Venom Stone"] = 13724,
["Shiny Thunder Stone"] = 13725,
["Shiny Rock Stone"] = 13726,
["Shiny Punch Stone"] = 13727,
["Shiny Fire Stone"] = 13728,
["Shiny Cocoon Stone"] = 13729,
["Shiny Crystal Stone"] = 13730,
["Shiny Darkness Stone"] = 13731,
["Shiny Earth Stone"] = 13732,
["Shiny Enigma Stone"] = 13733,
["Shiny Heart Stone"] = 13734,
["Shiny Ice Stone"] = 13735,
["Shiny Feather Stone"] = 13736,
}

typetostone = {
["Grass"] = "Leaf Stone",
["Poison"] = "Venom Stone",
["Ice"] = "Ice Stone",
["Water"] = "Water Stone",
["Ghost"] = "Darkness Stone",
["Dark"] = "Darkness Stone",
["Dragon"] = "Crystal Stone",
["Flying"] = "Feather Stone",
["Fire"] = "Fire Stone",
["Normal"] = "Heart Stone",
["Ground"] = "Earth Stone",
["Electric"] = "Thunder Stone",
["Psychic"] = "Enigma Stone",
["Rock"] = "Rock Stone",
["Bug"] = "Cocoon Stone",
["Fighting"] = "Punch Stone",
["Crystal"] = "Crystal Stone",
}

function init()
  connect(g_game, { onGameEnd = hide })

  ProtocolGame.registerExtendedOpcode(100, function(protocol, opcode, buffer) showPokemonPanel(buffer) end)
  ProtocolGame.registerExtendedOpcode(101, function(protocol, opcode, buffer) doCreatePokedex(protocol, opcode, buffer) end)
end

function terminate()
  disconnect(g_game, { onGameEnd = hide })

  ProtocolGame.unregisterExtendedOpcode(100)
  ProtocolGame.unregisterExtendedOpcode(101)

  hide()
end

function changeEoq()
  if not eoq or not tonumber(eoq) or eoq < 2 or eoq > 10 then
	pokedexWindow:setImageSource('/images/ui/window_pokedex')
  else
	pokedexWindow:setImageSource('/images/ui/window_pokedex'..eoq)
  end

end

function show()
  pokedexWindow = g_ui.displayUI('pokedex')
  changeEoq()
  pokemonImage = pokedexWindow:getChildById('pokemonImage')
  pokemonType1 = pokedexWindow:getChildById('pokemonType1')
  pokemonType2 = pokedexWindow:getChildById('pokemonType2')
  pokemonSearch = pokedexWindow:getChildById('searchText')
  pokedexTabBar = pokedexWindow:getChildById('pokedexTabBar')
  pokedexListPanel = pokedexWindow:getChildById('pokedexList')
  specialButton = pokedexWindow:getChildById('specialButton')

  pokemonSearch:focus()
  pokedexTabBar:setContentWidget(pokedexWindow:getChildById('pokedexTabContent'))

  infoPanel = g_ui.loadUI('info') 
  pokemonInfo = infoPanel:getChildById('pokemonInfo')
  pokedexTabBar:addTab('Info', infoPanel)

  movesPanel = g_ui.loadUI('moves')
  pokemonMoves = movesPanel:getChildById('pokemonMoves')
  pokedexTabBar:addTab('Moves', movesPanel)
  move1 = pokemonMoves:getChildById('move1')
  move2 = pokemonMoves:getChildById('move2')
  move3 = pokemonMoves:getChildById('move3')
  move4 = pokemonMoves:getChildById('move4')
  move5 = pokemonMoves:getChildById('move5')
  move6 = pokemonMoves:getChildById('move6')
  move7 = pokemonMoves:getChildById('move7')
  move8 = pokemonMoves:getChildById('move8')
  move9 = pokemonMoves:getChildById('move9')
  move10 = pokemonMoves:getChildById('move10')
  move11 = pokemonMoves:getChildById('move11')
  move12 = pokemonMoves:getChildById('move12')
  move13 = pokemonMoves:getChildById('move13')
  move14 = pokemonMoves:getChildById('move14')
  move15 = pokemonMoves:getChildById('move15')
  move16 = pokemonMoves:getChildById('move16')

  statsPanel = g_ui.loadUI('stats')
  pokemonStatsAttack = statsPanel:getChildById('pokemonStatsAttackPercent')
  pokemonStatsDefense = statsPanel:getChildById('pokemonStatsDefensePercent')
  pokemonStatsSpAttack = statsPanel:getChildById('pokemonStatsSpAttackPercent')
  pokemonStatsVitality = statsPanel:getChildById('pokemonStatsVitalityPercent')
  pokedexTabBar:addTab('Stats', statsPanel)

  effectivenessPanel = g_ui.loadUI('effectiveness')
  pokemonEffectiveness = effectivenessPanel:getChildById('pokemonEffectiveness')
  pokedexTabBar:addTab('Effectiveness', effectivenessPanel)

	pokedexTabBar.onTabChange = function(self, focusedChild)
	if not pokedexListPanel then return true end
      local focusedpoke = pokedexListPanel:getFocusedChild()
		if focusedChild == nil or focusedpoke == nil then return end
		if focusedpoke.pokeName == "??????" then
			g_game.talk("!zdex none")
		else
			local name = focusedpoke.pokeName
			local id = focusedpoke.pokeId
			local spec = ""
			if string.find(name, "Shiny") then spec = "Shiny " end
			if id == 29 then
				name = "Nidoran Female"
			elseif id == 32 then
				name = "Nidoran Male"
			elseif id == 122 then
				name = spec.."Mr. Mime"
			end
			g_game.talk("!zdex ".. focusedChild:getText() ..",".. name ..",false")
		end
		return false
	end
  pokedexIcon:setOn(true)
end



function hide()
	if pokedexWindow then
		g_keyboard.unbindKeyPress('Down')
		g_keyboard.unbindKeyPress('Up')
		pokedexWindow:destroy()
		pokedexWindow = nil
		pokedexIcon:setOn(false)
	end
	g_game.talk("!zdex Close")
end

function visibleDex()
	if pokedexWindow and pokedexWindow:isVisible() then
		return true
	end
	return false
end


function changedex()
if eoq < 10 then
	eoq = eoq+1
else
	eoq = 1
end
changeEoq()
g_game.talk('!dexchange')
end

function searchPokemon()
  local searchFilter = pokemonSearch:getText():lower()

  for i = 1, pokedexListPanel:getChildCount() do
    local pokemon = pokedexListPanel:getChildByIndex(i)

    local searchCondition = (searchFilter == '') or (searchFilter ~= '' and string.find(pokemon:getText():lower(), searchFilter) ~= nil)
    pokemon:setVisible(searchCondition)
  end
end

function doCreatePokedex(protocol, opcode, buffer)
  if pokedexWindow then return end
  local elites = {"Hitmonlee", "Hitmonchan", "Hitmontop"}
  eoq = tonumber(string.explode(buffer, '!')[2])
  local firstId = string.explode(buffer, '!')[3] or false
  show()
  g_keyboard.bindKeyPress('Down', function() pokedexListPanel:focusNextChild(KeyboardFocusReason) end, pokedexWindow)
  g_keyboard.bindKeyPress('Up', function() pokedexListPanel:focusPreviousChild(KeyboardFocusReason) end, pokedexWindow)
  for pokeId = 1, 251 do
    pokemon = g_ui.createWidget('PokedexListLabel', pokedexListPanel)
    pokemon.pokeId = pokeId
	local thisPoke = string.explode(buffer, ';')[pokeId]
    pokemon.pokeName = string.explode(string.explode(thisPoke, ' - ')[3], '|')[1]
    pokemon.pokeCatch = string.explode(thisPoke, '|')[2]
    pokemon.special = table.find(elites, pokemon.pokeName) and "Elite ".. pokemon.pokeName .."" or pokemon.pokeName == "Onix" and "Crystal Onix" or "Shiny ".. pokemon.pokeName ..""
    pokemon.specialStatus = string.explode(thisPoke, '|')[3]
    pokemon:setText(string.explode(thisPoke, '|')[1])
    if pokemon.pokeCatch == "t" and pokemon.pokeName ~= '??????' then
		pokemon:getChildById('caught'):setImageSource("/images/topbuttons/miniwindowicon/caughtOn")
		pokemon:getChildById('caught'):setTooltip("You already captured this Pokémon")
	elseif pokemon.pokeName ~= '??????' then
		pokemon:getChildById('caught'):setImageSource("/images/topbuttons/miniwindowicon/caughtOff")
		pokemon:getChildById('caught'):setTooltip("You not captured this Pokémon")
    end
    if pokemon.specialStatus == "n" then
		pokemon:getChildById('special'):setImageSource("/images/topbuttons/miniwindowicon/specialOff")
		pokemon:getChildById('special'):setTooltip("This Pokémon don't have Shinys or Megas")
	elseif pokemon.specialStatus == "f" then
		pokemon:getChildById('special'):setImageSource("/images/topbuttons/miniwindowicon/specialNone")
		pokemon:getChildById('special'):setTooltip("This Pokémon has a Shiny(".. pokemon.special .."), but, you don't have this Shiny pokedex")
	elseif pokemon.specialStatus == "p" then
		pokemon:getChildById('special'):setImageSource("/images/topbuttons/miniwindowicon/specialPro")
		pokemon:getChildById('special'):setTooltip(".")
	else
		pokemon:getChildById('special'):setImageSource("/images/topbuttons/miniwindowicon/specialOn")
		pokemon:getChildById('special'):setTooltip("This Pokémon has a Shiny(".. pokemon.special ..")")
    end
	if pokemon.pokeName == '??????' then
		pokemon:getChildById('caught'):setVisible(false)
		pokemon:getChildById('special'):setVisible(false)
	else
		pokemon:getChildById('caught'):setVisible(true)
		pokemon:getChildById('special'):setVisible(true)
	end
  end
	local firstSpecial = false
	if firstId and tonumber(firstId) then
		pokedexListPanel:getChildByIndex(tonumber(firstId)):focus()
		scheduleEvent(function()
		local focused = pokedexListPanel:getFocusedChild()
		if focused then
			pokedexListPanel:ensureChildVisible(focused)
			local special = focused.specialStatus
			if special == "n" or special == "f" then
				specialButton:setVisible(false)
			else
				specialButton:setVisible(true)
			end
		else
			specialButton:setVisible(false)
		end
		end, 100)
		firstSpecial = false
	elseif firstId then
		local specialTypes = {"Shiny", "Elite", "Mega", "Crystal"}
		if string.explode(firstId, '-')[1] and table.find(specialTypes, string.explode(firstId, '-')[1]) then
			local specialType = string.explode(firstId, '-')[1]
			local newFirstId = tonumber(string.explode(firstId, '-')[2])
			pokedexListPanel:getChildByIndex(newFirstId):focus()
			scheduleEvent(function()
				local focused = pokedexListPanel:getFocusedChild()
				if focused then
					pokedexListPanel:ensureChildVisible(focused)
					local special = focused.specialStatus
					if special == "n" or special == "f" then
						specialButton:setVisible(false)
					else
						specialButton:setVisible(true)
					end
					focused.pokeName = specialType.." ".. focused.pokeName
				else
					specialButton:setVisible(false)
				end
			end, 100)
			firstSpecial = true
		else
			firstSpecial = false
		end
	end
		
	pokedexListPanel.onChildFocusChange = function(self, focusedChild)
      local focusedtab = pokedexTabBar:getCurrentTab()
		if focusedChild == nil then return end
		if focusedChild.pokeName == "??????" then
			g_game.talk("!zdex none")
			specialButton:setVisible(false)
		else
			local name = focusedChild.pokeName
			local special = focusedChild.specialStatus
			if special == "n" or special == "f" then
				specialButton:setVisible(false)
			else
				specialButton:setVisible(true)
			end
			local id = focusedChild.pokeId
			local spec = ""
			if string.find(name, "Shiny") then 
				local newName = tostring(name):match("Shiny (.*)")
				name = newName
				focusedChild.pokeName = newName
			end
			if id == 29 then
				name = "Nidoran Female"
			elseif id == 32 then
				name = "Nidoran Male"
			elseif id == 122 then
				name = "Mr. Mime"
			end
			g_game.talk("!zdex ".. focusedtab:getText() ..",".. name ..",true")
		end
	end
end

function doTransformSpecial()
      local focusedtab = pokedexTabBar:getCurrentTab()
      local focusedpoke = pokedexListPanel:getFocusedChild()
		if focusedpoke.pokeName == "??????" then
			g_game.talk("!zdex none")
		else
			local spec = "Shiny "
			local elites = {"Hitmonlee", "Hitmonchan", "Hitmontop", "Elite Hitmonlee", "Elite Hitmonchan", "Elite Hitmontop"}
			local specialTypes = {"Shiny ", "Elite ", "Mega ", "Crystal "}
			local isSpecialType = false
			local name = focusedpoke.pokeName
			for a = 1, #specialTypes do
				if string.find(name, specialTypes[a]) then
					isSpecialType = specialTypes[a]
					break
				end
			end
			if not isSpecialType then
				if table.find(elites, focusedpoke.pokeName) then spec = "Elite " end
				if focusedpoke.pokeName == "Onix" then spec = "Crystal " end
				focusedpoke.pokeName = spec.."".. focusedpoke.pokeName
				name = focusedpoke.pokeName
				local id = focusedpoke.pokeId
				if id == 29 then
					name = "Shiny Nidoran Female"
				elseif id == 32 then
					name = "Shiny Nidoran Male"
				elseif id == 122 then
					name = "Shiny Mr. Mime"
				end
			else
				local newName = tostring(name):match(""..isSpecialType.."(.*)")
				name = newName
				focusedpoke.pokeName = newName
				local id = focusedpoke.pokeId
				if id == 29 then
					name = "Nidoran Female"
				elseif id == 32 then
					name = "Nidoran Male"
				elseif id == 122 then
					name = "Mr. Mime"
				end
			end
			g_game.talk("!zdex ".. focusedtab:getText() ..",".. name ..",true")
		end
	return true
end

function showPokemonPanel(buffer)
  local id = pokedexListPanel:getFocusedChild() and pokedexListPanel:getFocusedChild().pokeId or 1
	if buffer == "none" then
		infoPanel:setVisible(false)
		statsPanel:setVisible(false)
		movesPanel:setVisible(false)
		effectivenessPanel:setVisible(false)
		pokemonType1:setImageColor('alpha')
		pokemonType1:removeTooltip()
		pokemonType2:setImageColor('alpha')
		pokemonType2:removeTooltip()
		pokedexListPanel:getChildByIndex(id):focus()
		pokemonImage:setImageSource("/images/game/pokedex/none")
		return true
	end
	tab = string.explode(buffer, '_')[1]
	first = toboolean(string.explode(buffer, '_')[2])
	upPanel = tostring(string.explode(buffer, '_')[3])
	downPanel = tostring(string.explode(buffer, '_')[4])
	id = tonumber(string.explode(upPanel, "|")[1])
	name = string.explode(upPanel, "|")[2]
	types = tostring(string.explode(upPanel, "|")[3])
	type1 = string.explode(types, "/")[1]
	type2 = string.explode(types, "/")[2]
	catch = toboolean(string.explode(upPanel, '|')[4])
	if tab == "Info" then
		fotoID = string.explode(downPanel, '|')[1]
		level = string.explode(downPanel, '|')[2]
		boostIncrease = string.explode(downPanel, '|')[3]
		evoStones = string.explode(downPanel, '|')[4]
		evolutionsStr = string.explode(downPanel, '|')[5]
		desc = string.explode(downPanel, '|')[6]
		abilitysStr = string.explode(downPanel, '|')[7]
    pokemonInfo:getChildById("foto"):setItemId(fotoID)
    pokemonInfo:getChildById("name"):setText(name)
    pokemonInfo:getChildById("level"):setText("Level: "..level)
	setAbilitys(abilitysStr)
	local boostID1 = 0
	local boostID2 = 0
		if name == "Fearow" then
			boostID1 = getStoneIDByName["Feather Stone"]
		elseif name == "Vileplume" then
			boostID1 = getStoneIDByName["Leaf Stone"]
		elseif name == "Dragonite" or name == "Shiny Dragonite" then
			boostID1 = getStoneIDByName["Crystal Stone"]
		else
			boostID1 = getStoneIDByName[typetostone[doCorrectString(type1)]]
			if type2 ~= "no type" and  typetostone[doCorrectString(type2)] then
				boostID2 = getStoneIDByName[typetostone[doCorrectString(type2)]]
			end
		end
    pokemonInfo:getChildById("booststone1"):setItemId(boostID1)
    pokemonInfo:getChildById("booststone1"):setTooltip(typetostone[doCorrectString(type1)])
	if boostID2 > 0 then
		pokemonInfo:getChildById("booststone2"):setItemId(boostID2)
		pokemonInfo:getChildById("booststone2"):setTooltip(typetostone[doCorrectString(type2)])
		pokemonInfo:getChildById("booststone2"):setVisible(true)
		pokemonInfo:getChildById("booststonevalue"):addAnchor(AnchorLeft, 'booststone2', AnchorRight)
	else
		pokemonInfo:getChildById("booststone2"):setVisible(false)
		pokemonInfo:getChildById("booststonevalue"):addAnchor(AnchorLeft, 'booststone1', AnchorRight)
	end
	pokemonInfo:getChildById("booststonevalue"):setImageSource('/images/game/pokedex/info/boosts/' .. boostIncrease)
	evolution = pokemonInfo:getChildById("evolutions")
	if evolutionsStr ~= "NOTHING" then
		evolution:setVisible(true)
		local evos = string.explode(evolutionsStr, ';')
		local evo1 = string.explode(evos[1], ',')
		local evo2 = string.explode(evos[2], ',')
		evolution:getChildById("evo1"):getChildById("foto"):setItemId(tonumber(evo1[3]))
		evolution:getChildById("evo1"):getChildById("foto"):setTooltip(evo1[1])
		evolution:getChildById("evo1"):getChildById("level"):setText("Level: "..evo1[2])
		if #evos == 2 then
			evolution:getChildById("evo1"):setMarginLeft(50)
			evolution:getChildById("evo2"):setMarginLeft(50)
		else
			evolution:getChildById("evo1"):setMarginLeft(0)
			evolution:getChildById("evo2"):setMarginLeft(0)
		end
		adaptEvo2(evos[2])
		if #evos >= 3 then
			adaptEvo3(evos[3])
		else
			adaptEvo3("clear")
		end
		local evoHeightTable = {79, 131, 183, 235, 287}
		local evoHeight = #evos ~= 2 and (evoHeightTable[#string.explode(evos[2], "-")] >= evoHeightTable[#string.explode(evos[3], "-")] and evoHeightTable[#string.explode(evos[2], "-")] or evoHeightTable[#string.explode(evos[3], "-")]) or evoHeightTable[#string.explode(evos[2], "-")]
		evolution:getChildById("evo2"):setHeight(evoHeightTable[#string.explode(evos[2], "-")]-34)
		evolution:getChildById("stones1"):setHeight(evoHeightTable[#string.explode(evos[2], "-")]-34)
		if #evos == 3 then
			evolution:getChildById("evo3"):setHeight(evoHeightTable[#string.explode(evos[3], "-")]-34)
			evolution:getChildById("stones2"):setHeight(evoHeightTable[#string.explode(evos[3], "-")]-34)
			evolution:getChildById("evo3"):setVisible(true)
			evolution:getChildById("stones2"):setVisible(true)
		else
			evolution:getChildById("evo3"):setVisible(false)
			evolution:getChildById("stones2"):setVisible(false)
		end
		evolution:setHeight(evoHeight)
		if #evos == 3 and #string.explode(evos[3], "-") >= 2 then
			evolution:getChildById("evo1"):setMarginTop(26)
			evolution:getChildById("evo2"):setMarginTop(26)
		elseif #evos == 2 then
			evolution:getChildById("evo2"):setMarginTop(5)
			evolution:getChildById("evo1"):setMarginTop(5+(26*(#string.explode(evos[2], "-") -1)))
		else
			evolution:getChildById("evo2"):setMarginTop(5)
			evolution:getChildById("evo1"):setMarginTop(5)
		end
		pokemonInfo:getChildById("description"):addAnchor(AnchorTop, 'evolutions', AnchorBottom)
	else
		evolution:setVisible(false)
		if #string.explode(abilitysStr, ',') >= 5 then
			pokemonInfo:getChildById("description"):addAnchor(AnchorTop, 'abilitys', AnchorBottom)
		else
			pokemonInfo:getChildById("description"):addAnchor(AnchorTop, 'boost', AnchorBottom)
		end
	end


	if desc ~= "" then
		local descWindow = pokemonInfo:getChildById("description")
		descWindow:getChildById("text"):setText(desc)descWindow:getChildById("text"):setHeight((descWindow:getChildById("text"):getTextSize().height + descWindow:getChildById("text"):getPaddingLeft() + descWindow:getChildById("text"):getPaddingRight()))
	end
	
	elseif tab == "Moves" then
		local receivedMove = string.explode(string.explode(downPanel, '@')[1], ';')
		setPokedexMoves(receivedMove)

	elseif tab == "Stats" then
		local attack = string.explode(downPanel, '|')[1]
		local defense = string.explode(downPanel, '|')[2]
		local spattack = string.explode(downPanel, '|')[3]
		local vitality = string.explode(downPanel, '|')[4]
		pokemonStatsAttack:setValue(attack, 0, 160)
		pokemonStatsAttack:setBackgroundColor(valueToColor(attack))
		pokemonStatsDefense:setValue(defense, 0, 160)
		pokemonStatsDefense:setBackgroundColor(valueToColor(defense))
		pokemonStatsSpAttack:setValue(spattack, 0, 160)
		pokemonStatsSpAttack:setBackgroundColor(valueToColor(spattack))
		pokemonStatsVitality:setValue(vitality, 0, 160)
		pokemonStatsVitality:setBackgroundColor(valueToColor(vitality))

	elseif tab == "Effectiveness" then
		local usable = {}
		effectiveness1 = pokemonEffectiveness:getChildById("effectiveness1")
		effectiveness2 = pokemonEffectiveness:getChildById("effectiveness2")
		effectiveness3 = pokemonEffectiveness:getChildById("effectiveness3")
		effectiveness4 = pokemonEffectiveness:getChildById("effectiveness4")
		effectiveness5 = pokemonEffectiveness:getChildById("effectiveness5")
		effectiveness6 = pokemonEffectiveness:getChildById("effectiveness6")
		effs = string.explode(downPanel, ';')

		effectivenessTable = {effectiveness1,effectiveness2,effectiveness3,effectiveness4,effectiveness5,effectiveness6}
		effsTable = {"vweak", "weak", "normal", "resist", "vresist", "imun"}
		for a = 1, #effsTable do
			if effs[a] ~= "" then
				usable[#usable+1] = a
			end
		end
		for b = 1, #usable do
			effectivenessTable[b]:setVisible(true)
			effectivenessTable[b]:getChildById("name"):setImageSource('/images/game/pokedex/eff/'.. effsTable[usable[b]])
		end
		if #usable < #effsTable then
			for c = #usable+1,#effsTable do
				effectivenessTable[c]:setVisible(false)
			end
		end
		
		for d = 1, #usable do
			setEffectivenessTypes(effectivenessTable[d], effs[usable[d]])
		end
	end

function valueToColor(value)
	value = tonumber(value)
	if not value then return 'green' end
	if value >= 160 then
		return 'red'
	elseif value >= 120 and value <= 159 then
		return '#f36500'
	elseif value >= 80 and value <= 119 then
		return 'yellow'
	else
		return 'green'
	end
end

	if first then
			infoPanel:setVisible(true)
			statsPanel:setVisible(true)
			movesPanel:setVisible(true)
			effectivenessPanel:setVisible(true)
			pokemonType1:setImageColor('white')
			pokemonType1:setImageSource('/images/game/pokedex/elements/' .. type1)
			pokemonType1:setTooltip(doCorrectString(type1))
			if type2 and type2 ~= "no type" then
				pokemonType2:setImageColor('white')
				pokemonType2:setImageSource('/images/game/pokedex/elements/' .. type2)
				pokemonType2:setTooltip(doCorrectString(type2))
			else
				pokemonType2:setImageColor('alpha')
				pokemonType2:removeTooltip()
			end
			pokemonImage:setImageSource('/images/game/pokedex/' .. name)
	end
	return true
end

function adaptEvo2(evo2String)
	stones1otui = evolution:getChildById("stones1")
	evo2otui = evolution:getChildById("evo2")
	local multiEvos = string.explode(evo2String, "-")
		
	local fotosTable = {evo2otui:getChildById("foto"), evo2otui:getChildById("foto2"), evo2otui:getChildById("foto3"), evo2otui:getChildById("foto4"), evo2otui:getChildById("foto5")}
	local levelsTable = {evo2otui:getChildById("level"), evo2otui:getChildById("level2"), evo2otui:getChildById("level3"), evo2otui:getChildById("level4"), evo2otui:getChildById("level5")}
	local stonesTable = {stones1otui:getChildById("stone1"), stones1otui:getChildById("stone3"), stones1otui:getChildById("stone4"), stones1otui:getChildById("stone5"), stones1otui:getChildById("stone6")}
	local stonesValueTable = {stones1otui:getChildById("value1"), stones1otui:getChildById("value3"), stones1otui:getChildById("value4"), stones1otui:getChildById("value5"), stones1otui:getChildById("value6")}
	
	for a = 1, #multiEvos do
		local tabela = string.explode(multiEvos[a], ",")
		local stones = string.explode(tabela[4], "@")
		fotosTable[a]:setItemId(tonumber(tabela[3]))
		fotosTable[a]:setTooltip(tabela[1])
		levelsTable[a]:setText("Level: "..tabela[2])
		stonesValueTable[a]:setText(stones[1])
		stonesTable[a]:setItemId(getStoneIDByName[stones[2]])
		stonesTable[a]:setTooltip(stones[2])
		if a == 1 then 
			if stones[3] then
				stones1otui:getChildById("stone2"):setItemId(getStoneIDByName[stones[3]])
				stones1otui:getChildById("stone2"):setTooltip(stones[3])
				stones1otui:getChildById("value2"):setText(stones[1])
				stones1otui:getChildById("stone1"):setMarginLeft(0)
				stones1otui:getChildById("stone2"):setVisible(true)
				stones1otui:getChildById("value2"):setVisible(true)
			else
				stones1otui:getChildById("stone1"):setMarginLeft(15)
				stones1otui:getChildById("stone2"):setVisible(false)
				stones1otui:getChildById("value2"):setVisible(false)
				
			end
		end
	end
end

function adaptEvo3(evo3String)
	stones2otui = evolution:getChildById("stones2")
	evo3otui = evolution:getChildById("evo3")
		
	local fotosTable = {evo3otui:getChildById("foto"), evo3otui:getChildById("foto2")}
	local levelsTable = {evo3otui:getChildById("level"), evo3otui:getChildById("level2")}
	local stonesTable = {stones2otui:getChildById("stone1"), stones2otui:getChildById("stone3")}
	local stonesValueTable = {stones2otui:getChildById("value1"), stones2otui:getChildById("value3")}

	if evo3String == "clear" then
		stones2otui:setVisible(false)
		evo3otui:setVisible(false)
		return true
	end

	local multiEvos = string.explode(evo3String, "-")
	
	for a = 1, #multiEvos do
		local tabela = string.explode(multiEvos[a], ",")
		local stones = string.explode(tabela[4], "@")
		fotosTable[a]:setItemId(tonumber(tabela[3]))
		fotosTable[a]:setTooltip(tabela[1])
		levelsTable[a]:setText("Level: "..tabela[2])
		stonesValueTable[a]:setText(stones[1])
		stonesTable[a]:setItemId(getStoneIDByName[stones[2]])
		stonesTable[a]:setTooltip(stones[2])
		if a == 1 then 
			if stones[3] then
				stones2otui:getChildById("stone2"):setItemId(getStoneIDByName[stones[3]])
				stones2otui:getChildById("stone2"):setTooltip(stones[3])
				stones2otui:getChildById("value2"):setText(stones[1])
				stones2otui:getChildById("stone1"):setMarginLeft(0)
				stones2otui:getChildById("stone2"):setVisible(true)
				stones2otui:getChildById("value2"):setVisible(true)
			else
				stones2otui:getChildById("stone1"):setMarginLeft(15)
				stones2otui:getChildById("stone2"):setVisible(false)
				stones2otui:getChildById("value2"):setVisible(false)
				
			end
		end
	end
end

function setAbilitys(abilitysStr)
	abilitys = string.explode(abilitysStr, ',')
    absWindow = pokemonInfo:getChildById("abilitys")
    ab1 = absWindow:getChildById("ab1")
    ab2 = absWindow:getChildById("ab2")
    ab3 = absWindow:getChildById("ab3")
    ab4 = absWindow:getChildById("ab4")
    ab5 = absWindow:getChildById("ab5")
    ab6 = absWindow:getChildById("ab6")
	abis = {ab1, ab2, ab3, ab4, ab5, ab6}
	if abilitysStr ~= "none" then
		for a = 1, #abilitys do
			abis[a]:setImageSource('/images/game/pokedex/abilitys/' .. string.upper(abilitys[a]))
			abis[a]:setTooltip(string.upper(abilitys[a]))
			abis[a]:setVisible(true)
		end
	end

	if #abilitys < 6 and abilitysStr ~= "none" then
		for b = #abilitys+1,#abis do
			abis[b]:setVisible(false)
		end
	elseif #abilitys < 6 then
		for c = 1,#abis do
			abis[c]:setVisible(false)
		end
	end
	if #abilitys < 5 then
		pokemonInfo:getChildById("evolutions"):addAnchor(AnchorTop, 'boost', AnchorBottom)
	else
		pokemonInfo:getChildById("evolutions"):addAnchor(AnchorTop, 'abilitys', AnchorBottom)
	end
	return true
end

function setEffectivenessTypes(effectiveness, typesStr)
	local tableA = {"1-0", "2-0", "2-1", "3-1", "3-2", "4-2", "4-3", "5-3", "5-4", "6-4", "6-5", "7-5", "7-6", "8-6", "8-7", "9-7", "9-8", "9-9"}
	types = string.explode(typesStr, ',')
	line1count = tonumber(string.explode(tableA[#types], '-')[1])
	line2count = tonumber(string.explode(tableA[#types], '-')[2])
	local line1str = ""
	local line2str = ""
	for a = 1, line1count do
		line1str = line1str..(line1str == "" and types[a] or ","..types[a])
	end
	
	if line2count > 0 then
		for b = line1count+1,line1count+line2count do
			line2str = line2str..(line2str == "" and types[b] or ","..types[b])
		end
	end
	if line2count >= 1 then
		effectiveness:setHeight(84)
	else
		effectiveness:setHeight(61)
	end
	setLineTypes(effectiveness:getChildById("typesFirst"), line1str)
	setLineTypes(effectiveness:getChildById("typesSecond"), line2str)
	

	return true
end

function setLineTypes(line, typesStr)
	if typesStr == "" then line:setVisible(false) else line:setVisible(true) end
	types = string.explode(typesStr, ',')
	lineType1 = line:getChildById("tipo1")
	lineType2 = line:getChildById("tipo2")
	lineType3 = line:getChildById("tipo3")
	lineType4 = line:getChildById("tipo4")
	lineType5 = line:getChildById("tipo5")
	lineType6 = line:getChildById("tipo6")
	lineType7 = line:getChildById("tipo7")
	lineType8 = line:getChildById("tipo8")
	lineType9 = line:getChildById("tipo9")
	lineTypes = {lineType1, lineType2, lineType3, lineType4, lineType5, lineType6, lineType7, lineType8, lineType9}
	for a = 1, #types do
		lineTypes[a]:setVisible(true)
		lineTypes[a]:setImageSource('/images/game/pokedex/elements/' .. types[a])
		lineTypes[a]:setTooltip(string.upper(types[a]))
	end
	for b = #types+1, #lineTypes do
		lineTypes[b]:setVisible(false)
	end
	line:setWidth(20+((#types-1)*23))
	return true
end

function setPokedexMoves(received)
	for p = 1, 16 do
		pokemonMoves:getChildById('move'..p):setVisible(true)
	end
	tabelaMoves = {move1, move2, move3, move4, move5, move6, move7, move8, move9, move10, move11, move12, move13, move14, move15, move16}
	
	for a = 1, #received do
		local receivedMove = string.explode(received[a], '|')
		tabelaMoves[a]:getChildById('foto'):setImageSource('/images/game/pokedex/moves_icon/' .. receivedMove[1] .."_on")
		tabelaMoves[a]:getChildById('foto'):setTooltip(receivedMove[4])
		tabelaMoves[a]:getChildById('name'):setText(receivedMove[1])
		if tonumber(receivedMove[2]) > 0 then
			tabelaMoves[a]:getChildById('level'):setText("Level: "..receivedMove[2])
			tabelaMoves[a]:getChildById('level'):setVisible(true)
		else
			tabelaMoves[a]:getChildById('level'):setVisible(false)
		end
		if tonumber(receivedMove[3]) > 0 then
			tabelaMoves[a]:getChildById('CD'):setText(receivedMove[3])
			tabelaMoves[a]:getChildById('CD'):setVisible(true)
		else
			tabelaMoves[a]:getChildById('CD'):setVisible(false)
		end
		tabelaMoves[a]:getChildById('tipo'):setImageSource('/images/game/pokedex/elements/' .. receivedMove[5])
		tabelaMoves[a]:getChildById('tipo'):setTooltip(string.upper(receivedMove[5]))
		setPropertysMove(tabelaMoves[a], receivedMove[6])
	end

	for b = #received+1, 16 do
		tabelaMoves[b]:setVisible(false)
	end
	return true
end

function setPropertysMove(moveid, movepropertys)
	for p = 1, 6 do
		moveid:getChildById('property'..p):setVisible(true)
	end
	property1 = moveid:getChildById('property1')
	property2 = moveid:getChildById('property2')
	property3 = moveid:getChildById('property3')
	property4 = moveid:getChildById('property4')
	property5 = moveid:getChildById('property5')
	property6 = moveid:getChildById('property6')
	tabelaPropertys = {property1, property2, property3, property4, property5, property6}
	moveProperty = string.explode(movepropertys, '/')
	for a = 1, #moveProperty do
		tabelaPropertys[a]:setImageSource('/images/game/pokedex/propertys/'..moveProperty[a])
		tabelaPropertys[a]:setTooltip(moveProperty[a])
	end
	for b = #moveProperty+1, 6 do
		if tabelaPropertys[b] then
			tabelaPropertys[b]:setVisible(false)
		end
	end
	return true
end