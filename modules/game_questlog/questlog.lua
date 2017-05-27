questLogButton = nil
questLineWindow = nil

function init()
  g_ui.importStyle('questlogwindow')
  g_ui.importStyle('questlinewindow')

  questLogButton = modules.client_topmenu.addLeftGameToggleButton('questLogButton', tr('Quest Log'), '/images/topbuttons/questlog', function() g_game.talk("/requestquestlog")  end, true)-- g_game.requestQuestLog() end)
  questLogButton:setVisible(false)

  connect(g_game, { onQuestLog = onGameQuestLog,
                    onQuestLine = onGameQuestLine,
					onGameStart = online,
                    onGameEnd = offline})
	ProtocolGame.registerExtendedOpcode(61, function(protocol, opcode, buffer)
		local strings = string.explode(buffer, ';')  
		toggleButton(strings)
	end)
	ProtocolGame.registerExtendedOpcode(60, function(protocol, opcode, buffer)
		if questLogWindow and questLogWindow:getChildById('questInfo') then
			questLogWindow:getChildById('questInfo'):setText(buffer)
		end
	end)
end


function online()
  questLogButton:setVisible(true)
end


function offline()
  questLogButton:setVisible(false)
  destroyWindows()
end

function terminate()
  disconnect(g_game, { onQuestLog = onGameQuestLog,
                       onQuestLine = onGameQuestLine,
					   onGameStart = online,
                       onGameEnd = offline})

  destroyWindows()
  questLogButton:destroy()
  ProtocolGame.unregisterExtendedOpcode(61)
  ProtocolGame.unregisterExtendedOpcode(60)
end

function destroyWindows()
  if questLogWindow then
    questLogWindow:destroy()
  end

  if questLineWindow then
    questLineWindow:destroy()
  end
	questLogButton:setOn(false)
end

function onGameQuestLog(questTable)
  destroyWindows()

  questLogWindow = g_ui.createWidget('QuestLogWindow', rootWidget)
  local questList = questLogWindow:getChildById('questList')
  local questInfo = questLogWindow:getChildById('questInfo')

--  for i,questEntry in pairs(quests) do
   -- local id, name, completed = unpack(questEntry)
   for id = 1, #questTable do
    local questLabel = g_ui.createWidget('QuestLabel', questList)
	local infos = string.explode(questTable[id], '|') 
	local name = infos[1]
  --  questLabel:setOn(completed)
	local status = tonumber(infos[2])
	local colorbystatus = status == -1 and '#ff4c4c' or status == 0 and '#ffff66' or '#66ff66'
    questLabel:setText(name)
    questLabel:setFont("verdana-11px-rounded")
	questLabel:setColor(colorbystatus)
    questLabel.id = id
    questLabel.name = name
  end

  g_keyboard.bindKeyPress('Down', function() questList:focusNextChild(KeyboardFocusReason) end, questLogWindow)
  g_keyboard.bindKeyPress('Up', function() questList:focusPreviousChild(KeyboardFocusReason) end, questLogWindow)
  
  questLogWindow.onDestroy = function()
    questLogWindow = nil
    g_keyboard.unbindKeyPress('Down')
    g_keyboard.unbindKeyPress('Up')
  end
  
	questList.onChildFocusChange = function(self, focusedChild)
		if focusedChild == nil then return end
		self:ensureChildVisible(focusedChild)
		g_game.talk("/showquestdesc ".. focusedChild.name)
	end
end

function toggleButton(strings)
	if questLogButton:isOn() then
		destroyWindows()
	elseif strings then
		onGameQuestLog(strings)
		questLogButton:setOn(true)
	end
end

function onGameQuestLine(questId, questMissions)
  if questLogWindow then questLogWindow:hide() end
  if questLineWindow then questLineWindow:destroy() end

  questLineWindow = g_ui.createWidget('QuestLineWindow', rootWidget)
  local missionList = questLineWindow:getChildById('missionList')
  local missionDescription = questLineWindow:getChildById('missionDescription')

  connect(missionList, { onChildFocusChange = function(self, focusedChild)
    if focusedChild == nil then return end
    missionDescription:setText(focusedChild.description)
    missionDescription:setFont("verdana-11px-rounded")
  end })

  for i,questMission in pairs(questMissions) do
    local name, description = unpack(questMission)

    local missionLabel = g_ui.createWidget('MissionLabel')
    missionLabel:setText(name)
    missionLabel:setFont("verdana-11px-rounded")
    missionLabel.description = description
    missionList:addChild(missionLabel)
  end

  questLineWindow.onDestroy = function()
    if questLogWindow then questLogWindow:show() end
    questLineWindow = nil
  end
	questLogButton:setOn(true)
  missionList:focusChild(missionList:getFirstChild())
end

