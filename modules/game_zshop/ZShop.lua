local defaultOptions = {
}
ShopButton = nil

local optionsWindow
local optionsTabBar
local options = {}
local zBless = nil

function init()
  ShopButton = modules.client_topmenu.addRightGameToggleButton('ZShop', tr('Z Shop').. '', '/images/zshop/zpoints', toggle)
 -- ShopButton:setOn(false)
  for k,v in pairs(defaultOptions) do
    g_settings.setDefault(k, v)
    options[k] = v
  end
  connect(g_game, {
    onGameStart = online,
    onGameEnd = offline,
  })


  optionsWindow = g_ui.displayUI('options')
 -- optionsWindow:hide()

  changeClanWindow = g_ui.displayUI('Clans')
 -- changeClanWindow:hide()
  confirmationWindow = g_ui.displayUI('confirmation')

  optionsTabBar = optionsWindow:getChildById('optionsTabBar')
  optionsTabBar:setContentWidget(optionsWindow:getChildById('optionsTabContent'))

  marketPanel = g_ui.loadUI('market')
  optionsTabBar:addTab(tr(''), marketPanel, '/images/zshop/marketButton')

  outfitsPanel = g_ui.loadUI('outfits')
  optionsTabBar:addTab(tr(''), outfitsPanel, '/images/zshop/outfitsButton')

  addonsPanel = g_ui.loadUI('addons')
  optionsTabBar:addTab(tr(''), addonsPanel, '/images/zshop/addonsButton')

  itemsPanel = g_ui.loadUI('items')
  optionsTabBar:addTab(tr(''), itemsPanel, '/images/zshop/itemsButton')

 -- clansPanel = g_ui.loadUI('clans')
  --optionsTabBar:addTab(tr(''), clansPanel, '/images/ui/shop/8')
 
--  ShopButton:setVisible(false)
--  ShopButton:setWidth(32)
 -- ShopButton:setOpacity(0.5)
  
  ProtocolGame.registerExtendedOpcode(66, function(protocol, opcode, buffer) 
  local strings = string.explode(buffer, '-')  
  zPoints = tonumber(strings[1])
  dds = tonumber(strings[2])
reload(zPoints,dds)
  --local buffer = buffer
  --show(buffer)
  end)
  hide()
  
--  local widget = g_ui.createWidget('LocalesButtons', optionsWindow)
 -- widget:setImageSource('/game_shop/img/shop_logo')
end


function terminate()
  disconnect(g_game, {
    onGameStart = online,
    onGameEnd = offline,
  })
	ProtocolGame.unregisterExtendedOpcode(66)
end

function online()
  ShopButton:setVisible(true)
end

function offline()
  hide()
  ShopButton:setVisible(false)
end

function setup()
  setupGraphicsEngines()

  for k,v in pairs(defaultOptions) do
    if type(v) == 'boolean' then
      setOption(k, g_settings.getBoolean(k), true)
    elseif type(v) == 'number' then
      setOption(k, g_settings.getNumber(k), true)
    end
  end
end

function toggle()
  if ShopButton:isOn() then
    hide()
  else
    show()
	ShopButton:setOn(true)
  end
end

function show(buffer)
  g_game.talk('/reloadShop')
  if not zPoints then return true end
  optionsWindow:show()
  optionsWindow:raise()
  optionsWindow:focus()
  if zPoints < 10 then
  optionsWindow:getChildById('count1'):setMarginRight(35)
  elseif zPoints < 100 and zPoints >= 10 then
  optionsWindow:getChildById('count1'):setMarginRight(30)
  elseif zPoints < 1000 and zPoints >= 100 then
  optionsWindow:getChildById('count1'):setMarginRight(25)
  elseif zPoints < 10000 and zPoints >= 1000 then
  optionsWindow:getChildById('count1'):setMarginRight(20)
  else
  optionsWindow:getChildById('count1'):setMarginRight(15)
  end
  if dds < 10 then
  optionsWindow:getChildById('count2'):setMarginRight(113)
  elseif dds < 100 and dds >= 10 then
  optionsWindow:getChildById('count2'):setMarginRight(108)
  elseif dds < 1000 and dds >= 100 then
  optionsWindow:getChildById('count2'):setMarginRight(103)
  elseif dds < 10000 and dds >= 1000 then
  optionsWindow:getChildById('count2'):setMarginRight(98)
  else
  optionsWindow:getChildById('count2'):setMarginRight(93)
  end
  optionsWindow:getChildById('count1'):setText(zPoints)
  optionsWindow:getChildById('count2'):setText(dds)
 -- ShopButton:setOpacity(1.0)
  optionsWindow:getChildById('diamond'):setItemId(3028)
	--volcanic = changeClanWindow:getChildById("volcanic")
end

function hide()
	optionsWindow:hide()
	--ShopButton:setOpacity(0.5)
	hideChangeClan()
	hideConfirmationWindow()
	ShopButton:setOn(false)
end

function buydd()
  if zPoints > 0 then
    g_ui.displayUI('buydd'):setVisible(true)
  else
    g_game.talk('/buyddfail')
  end
end

function reload(zps,dds)
  if optionsWindow then
    if optionsWindow:getChildById('count1') then
      optionsWindow:getChildById('count1'):setText(zps)
    end
    if optionsWindow:getChildById('count2') then
      optionsWindow:getChildById('count2'):setText(dds)
    end
  end
end

function toggleOption(key)
  setOption(key, not getOption(key))
end

function setOption(key, value, force)
  if not force and options[key] == value then return end

  g_settings.set(key, value)
  options[key] = value
end

function getOption(key)
  return options[key]
end

function showMiniWindow()
  miniWindow = g_ui.displayUI('miniWindow')
  miniWindow:setVisible(true)
end

function hideMiniWindow()
  miniWindow:setVisible(false)
end

function showMiniWindowDone()
  miniWindow = g_ui.displayUI('miniWindowDone')
  miniWindow:setVisible(true)
end

function openChangeClan()
	changeClanWindow:show()
	changeClanWindow:raise()
	changeClanWindow:focus()
	costValue = changeClanWindow:getChildById("costValue")
	clans = changeClanWindow:getChildById("clans")
	ranks = changeClanWindow:getChildById("ranks")
	local priceByRank = {["rank1"] = 12, ["rank2"] = 25, ["rank3"] = 37, ["rank4"] = 50}
	costValue:setText(ranks:getFocusedChild() and priceByRank[ranks:getFocusedChild():getId()] or 99)
	

	ranks.onChildFocusChange = function(self, focusedChild)
		local value = 12
		if focusedChild == nil then return end
		if priceByRank[focusedChild:getId()] then
			value = priceByRank[focusedChild:getId()]
		else
			value = "?"
		end
		costValue:setText(value)
	end
	return true
end

function hideChangeClan()
	changeClanWindow:hide()
	return true
end

function changeClanButton()
	local rankNumber = ranks:getFocusedChild():getId():match("rank(.*)") --match(""..isSpecialType.."(.*)")
	local clanName = clans:getFocusedChild():getId()
	--print(clanName..""..rankNumber)
	local it = clanName..","..rankNumber
	local str = doCorrectString(clanName).." rank "..rankNumber
	sendConfirmationWindow(it, "Clan", str, costValue:getText())
	return true
end

function sendConfirmationWindow(item, type, string, value)
	if not optionsWindow:isVisible() then
		return true
	elseif not confirmationWindow:isVisible() then
		addEvent(function() g_effects.fadeIn(confirmationWindow, 250) end)
	end
	confirmationWindow:setVisible(true)
	confirmationWindow:show()
	confirmationWindow:raise()
	confirmationWindow:focus()
	if type == "Clan" or item == "ChangeGender" then
		confirmationWindow:getChildById('buyButton'):setText("Change")
	else
		confirmationWindow:getChildById('buyButton'):setText("Buy")
	end
	if type ~= "Clan" then
		msg = "Do you want "..(string ~= "Change Gender" and "buy " or "")..""..string.." with "..value.." diamond"..(tonumber(value) > 1 and "s" or "")..""..(item == "sditto" and " and Ditto +50" or "").." ?"
		confirmationWindow:setText("ZShop Confirmation")
		confirmationWindow:getChildById('buyItemText'):setText(msg)
		confirmationWindow.onEnter = function() g_game.talk("/"..type..""..item) hideConfirmationWindow() end
		confirmationWindow:getChildById('buyButton').onClick = function() g_game.talk("/"..type..""..item) hideConfirmationWindow() end
	
	    --g_game.talk("/"..type..""..item)
	else
		confirmationWindow:setText("Change Clan Confirmation")
		msg = "Do you want change your clan to "..string.." with "..value.." diamonds ?"
		confirmationWindow:getChildById('buyItemText'):setText(msg)
		confirmationWindow.onEnter = function() g_game.talk("/ZSchangeclan "..item) hideConfirmationWindow() end
		confirmationWindow:getChildById('buyButton').onClick = function() g_game.talk("/ZSchangeclan "..item) hideConfirmationWindow() end
	end
	return true
end

function hideConfirmationWindow()
	addEvent(function() g_effects.fadeOut(confirmationWindow, 250) end)
	scheduleEvent(function() confirmationWindow:hide() end, 250)
	return true
end


function doChangeClan()
	return true
end

function hideMiniWindowDone()
  miniWindow:setVisible(false)
end