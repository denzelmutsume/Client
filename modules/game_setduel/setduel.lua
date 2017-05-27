local timez = 1
local totalpokes = 1
local playername = nil
local only1t1a = nil
local noequals = nil
local noshinys = nil

function init()
  connect(g_game, { onGameEnd = onGameEnd })
  ProtocolGame.registerExtendedOpcode(55, function(protocol, opcode, buffer)

  local strings = string.explode(buffer, '-')
  if #strings > 1 then
  show(strings[1], strings[2], strings[3], strings[4], strings[5], strings[6], strings[7])
  else
  show(buffer)
  end
  end)

  setduelWindow = g_ui.displayUI('setduel')
  acceptduelWindow = g_ui.displayUI('acceptduel')
  hide()
  hideAccept()
end

function terminate()
  disconnect(g_game, { onGameEnd = onGameEnd })
  ProtocolGame.unregisterExtendedOpcode(55)

  setduelWindow:destroy()
  acceptduelWindow:destroy()
end

function onGameEnd()
  if setduelWindow:isVisible() then
    setduelWindow:hide()
  end
  if acceptduelWindow:isVisible() then
    acceptduelWindow:hide()
  end
end

function show(name, accept, duelinfos, infosp1, infosp2, infosp3)

if not accept then
  if not name then
  hide()
  return true
  end
  playername = name
  if not setduelWindow:isVisible() then
    addEvent(function() g_effects.fadeIn(setduelWindow, 250) end)
  end
  setduelWindow:show()
  setduelWindow:raise()
  setduelWindow:focus()
  x1button = setduelWindow:getChildById('x1Button')
  x2button = setduelWindow:getChildById('x2Button')
  setduelWindow:getChildById('balls'):setItemId(3003)
  poke1button = setduelWindow:getChildById('1poke')
  poke2button = setduelWindow:getChildById('2poke')
  poke3button = setduelWindow:getChildById('3poke')
  poke4button = setduelWindow:getChildById('4poke')
  poke5button = setduelWindow:getChildById('5poke')
  poke6button = setduelWindow:getChildById('6poke')
elseif duelinfos and infosp1 then
  local msg = ""
  if not acceptduelWindow:isVisible() then
    addEvent(function() g_effects.fadeIn(acceptduelWindow, 250) end)
  end
  acceptduelWindow:show()
  acceptduelWindow:raise()
 local duelinfo = string.explode(duelinfos, '!')
 local info = string.explode(infosp1, '!')
 local info2 = nil
 local info3 = nil
 
 if infosp2 then info2 = string.explode(infosp2, '!') end
 if infosp3 then info3 = string.explode(infosp3, '!') end
 
 playername = info[1]
 if duelinfo[1] ~= "1" and info[4] then --2x2 same and first team
 msg = info[1] .. " invited you to first team for a duel.\nDuel Informations: " .. duelinfo[1] .. "x" .. duelinfo[1] .. ", " .. duelinfo[2] .. " Pokemons"..(duelinfo[3] == "yes" and ", Only 1 T1A" or "")..""..(duelinfo[4] == "yes" and ", no Equals Pokemons" or "")..""..(info[duelinfo5] == "yes" and ", no Shiny Pokemons" or "")..".\nYour Team: " .. info[1] .. "(" .. info[3] .. ") Level " .. info[2] .. " and You\nOther Team: empty."
 
 elseif duelinfo[1] ~= "1" and infosp2 and not infosp3 then --2x2 second team
 msg = info[1] .. " invited you to a duel.\nDuel Informations: " .. duelinfo[1] .. "x" .. duelinfo[1] .. ", " .. duelinfo[2] .. " Pokemons"..(duelinfo[3] == "yes" and ", Only 1 T1A" or "")..""..(duelinfo[4] == "yes" and ", no Equals Pokemons" or "")..""..(info[duelinfo5] == "yes" and ", no Shiny Pokemons" or "")..".\nYour Team: You\nOther Team: " .. info[1] .. "(" .. info[3] .. ") Level " .. info[2] .. " and " .. info2[1] .. "(" .. info2[3] .. ") Level " .. info2[2] .. "."
 
 elseif duelinfo[1] ~= "1" and infosp3 and info3[4] then --2x2 same and second team
 msg = info[1] .. " invited you to second team for a duel.\nDuel Informations: " .. duelinfo[1] .. "x" .. duelinfo[1] .. ", " .. duelinfo[2] .. " Pokemons"..(duelinfo[3] == "yes" and ", Only 1 T1A" or "")..""..(duelinfo[4] == "yes" and ", no Equals Pokemons" or "")..""..(info[duelinfo5] == "yes" and ", no Shiny Pokemons" or "")..".\nYour Team: " .. info3[1] .. "(" .. info3[3] .. ") Level " .. info3[2] .. " and You\nOther Team: " .. info[1] .. "(" .. info[3] .. ") Level " .. info[2] .. " and " .. info2[1] .. "(" .. info2[3] .. ") Level " .. info2[2] .. "."
 
 else --duel 1x1
 msg = info[1] .. " invited you to a duel.\nDuel Informations: " .. duelinfo[1] .. "x" .. duelinfo[1] .. ", " .. duelinfo[2] .. " Pokemons"..(duelinfo[3] == "yes" and ", Only 1 T1A" or "")..""..(duelinfo[4] == "yes" and ", no Equals Pokemons" or "")..""..(duelinfo[5] == "yes" and ", no Shiny Pokemons" or "")..".\nYour Team: You\nOther Team: " .. info[1] .. "(" .. info[3] .. ") Level " .. info[2] .. ""
 end
 
  acceptduelWindow:getChildById('duelMessage'):setText(msg)
elseif accept == "close" then
hideAccept()
end
end

function setTeam(team)
if not team then team = 1 end
if timez == team then return true end
if team == 1 then 
timez = 1
x1button:setImageSource('/images/duel/1x1on.png')
x2button:setImageSource('/images/duel/2x2.png')
elseif team == 2 then
timez = 2
x1button:setImageSource('/images/duel/1x1.png')
x2button:setImageSource('/images/duel/2x2on.png')
end
return true
end

function setPokes(number)
if not number then number = 1 end
if number == totalpokes then return true end
setduelWindow:getChildById(number.."poke"):setImageSource("/images/duel/"..number.."on.png")
setduelWindow:getChildById(totalpokes.."poke"):setImageSource("/images/duel/"..totalpokes..".png")
totalpokes = number
return true
end

function test()
print("Inviting: "..playername)
print("Team: "..timez)
print("Pokes: "..totalpokes)
print("Only 1 T1A: "..(only1t1a and "yes" or "no"))
print("No Equals: "..(noequals and "yes" or "no"))
print("No Shinys: "..(noshinys and "yes" or "no"))
end
  

function hide()
  addEvent(function() g_effects.fadeOut(setduelWindow, 250) end)
  scheduleEvent(function() setduelWindow:hide() end, 250)
end

function hideAccept()
  addEvent(function() g_effects.fadeOut(acceptduelWindow, 250) end)
  scheduleEvent(function() acceptduelWindow:hide() end, 250)
end

function inviteDuel()
g_game.talk("!inviteduel "..playername..", "..timez..", "..totalpokes..", "..(only1t1a and "yes" or "no")..", "..(noequals and "yes" or "no")..", "..(noshinys and "yes" or "no").."")
hide()
end

function hideWindow()
  addEvent(function() g_effects.fadeOut(setduelWindow, 250) end)
  scheduleEvent(function() setduelWindow:hide() end, 250)
end


function setDuelOption(key, value, force)
local dueloptions = {
["only1t1a"] = only1t1a,
["noequals"] = noequals,
["noshinys"] = noshinys,
}
  if not force and dueloptions[key] == value then return end

if key == "only1t1a" then
only1t1a = value
elseif key == "noequals" then
noequals = value
elseif key == "noshinys" then
noshinys = value
end
end

function acceptDuel()
g_game.talk("!acceptduel "..playername)
end

function refuseDuel()
g_game.talk("!refuseduel "..playername)
hideAccept()
end
