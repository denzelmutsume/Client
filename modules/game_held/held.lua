local defaultOptions = {
}

local optionsWindow
local optionsButton
local optionsTabBar
local options = {}
local zBless = nil

function init()
  for k,v in pairs(defaultOptions) do
    g_settings.setDefault(k, v)
    options[k] = v
  end
  connect(g_game, {
    onGameEnd = offline,
  })

  shopWindow = g_ui.displayUI('held')
  buyWindow = g_ui.displayUI('dobuy')
  ProtocolGame.registerExtendedOpcode(79, function(protocol, opcode, buffer) local strings = string.explode(buffer, '-') if #strings >= 7 then show(strings[1], strings[2], strings[3], strings[4], strings[5], strings[6], strings[7]) end end)
  hide()
end


function terminate()
  disconnect(g_game, {
    onGameEnd = offline,
  })
  ProtocolGame.unregisterExtendedOpcode(79)
  shopWindow:destroy()
end

function offline()
  hide()
end

function show(devoted, dungeon, underworld, fun, mighty, honored, conqueror)
	if not shopWindow:isVisible() then
		addEvent(function() g_effects.fadeIn(shopWindow, 250) end)
	end
 -- g_game.talk('/reloadShop')
--local zPoints = tonumber(buffer)
  shopWindow:show()
  shopWindow:raise()
  shopWindow:focus()
  
  shopWindow:getChildById('devotedcount'):setText(devoted)
  shopWindow:getChildById('dungeoncount'):setText(dungeon)
  shopWindow:getChildById('underworldcount'):setText(underworld)
  shopWindow:getChildById('funcount'):setText(fun)
  shopWindow:getChildById('mightycount'):setText(mighty)
  shopWindow:getChildById('honoredcount'):setText(honored)
  shopWindow:getChildById('conquerorcount'):setText(conqueror)
  return true
end

function doHeldItem(tokens)
	local tokensToDesc = {
		["20devoted"] = "20 Devoted Tokens",
		["30dungeon"] = "30 Dungeon Tokens",
		["60dungeon"] = "60 Dungeon Tokens",
		["120dungeon"] = "120 Dungeon Tokens",
		["240dungeon"] = "240 Dungeon Tokens",
		["30underworld"] = "30 Underworld Tokens",
		["75underworld"] = "75 Underworld Tokens",
		["150underworld"] = "150 Underworld Tokens",
		["30fun"] = "30 Fun Tokens",
		["60fun"] = "60 Fun Tokens",
		["120fun"] = "120 Fun Tokens",
		["70mighty"] = "70 Mighty Tokens",
		["150mighty"] = "150 Mighty Tokens",
		["300mighty"] = "300 Mighty Tokens",
		["30honored"] = "30 Honored Tokens",
		["75honored"] = "75 Honored Tokens",
		["150honored"] = "150 Honored Tokens",
		["150conqueror"] = "150 Conqueror Tokens",
	}
	if not tokensToDesc[tokens] or not shopWindow:isVisible() then print(tokens) return true
	elseif not buyWindow:isVisible() then
		addEvent(function() g_effects.fadeIn(buyWindow, 250) end)
	end
	buyWindow:show()
	buyWindow:raise()
	buyWindow:focus()
	buyWindow:setText("Do exchange Tokens in Helds")
	local msg = "Are you sure exchange "..tokensToDesc[tokens].." ?"
	buyWindow:getChildById('buyItemText'):setText(msg)
	buyWindow:getChildById('buyButton').onClick = function() g_game.talk("/tradeHeldItemMachine "..tokens) hideBuyWindow() end
	return true
end

function hide()
	addEvent(function() g_effects.fadeOut(shopWindow, 250) end)
	scheduleEvent(function() shopWindow:hide() end, 250)
	hideBuyWindow()
end

function hideBuyWindow()
	addEvent(function() g_effects.fadeOut(buyWindow, 250) end)
	scheduleEvent(function() buyWindow:hide() end, 250)
end