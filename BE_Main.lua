-- BE_Main for Barbarians Enhanced
-- Author: Nutty
-- DateCreated: 4/15/2014 4:33:16 PM
--------------------------------------------------------------

print("Ahoy!  It's Barbarians Enhanced!")

WARN_NOT_SHARED = true
include("ShareData.lua")
include("SaveUtils.lua")
MY_MOD_NAME = "BarbariansEnhanced"

include("BE_Init.lua")
--Events.ActivePlayerTurnEnd.Add(BE_Save)

function BE_Main()
	
	--Kill the traditional barbarians.  (There's got to be a better way!)
	for unit in Players[GameDefines.MAX_PLAYERS-1]:Units() do
		unit:Kill()
	end

	--Main Loop
	for i = 1, #tBarbarians do
		local pPlayer = Players[tBarbarians[i].Player]

		if tBarbarians[i].Active then
			if pPlayer:GetNumCities() > 0 then
				--do stuff...
			else
				tBarbarians[i].CoolDown = COOLDOWN_TURNS;
				tBarbarians[i].Active = false;
			end
		else
			if pPlayer:GetNumCities() <= 0 then
				if tBarbarians[i].CoolDown <= 0 then
					DPrint("Founding a new barbarian city for player ".. tBarbarians[i].Player .."...", BE_DEBUG)
					local iW, iH = Map.GetGridSize()
					local max = 0
					local max_x = -1
					local max_y = -1

					for y = 0, iH - 1 do
						for x = 0, iW - 1 do
							local v = pPlayer:AI_foundValue(x,y)
							if v > max then
								max = v
								max_x = x
								max_y = y
							end
						end
					end
					--distanceToNextCity = Map.PlotDistance(cityPlotX, cityPlotY, max_x, max_y)
					--if (distanceToNextCity >= cityDistanceLimit) then
					--	DPrint(" next city over distance limit ", BE_DEBUG)
					--	return;			
					--end
					if max_x > -1 then
						if pPlayer:CanFound(max_x,max_y) then
							pPlayer:Found(max_x,max_y)
							plot = Map.GetPlot(max_x,max_y)
							--plot:IsCoastalLand() --for pirates
							city = plot:GetPlotCity()
							pPlayer:InitUnit(GameInfo.Units.UNIT_BARBARIAN_WARRIOR.ID, max_x, max_y)
							tBarbarians[i].Active = true
							if tBarbarians[i].Pirate then
								city:SetName(Locale.ConvertTextKey(GameInfo.MinorCivPirates[tBarbarians[i].ID].Description))
							else
								city:SetName(Locale.ConvertTextKey(GameInfo.MinorCivBarbarians[tBarbarians[i].ID].Description))
							end
						end
					end
				else
					tBarbarians[i].CoolDown = tBarbarians[i].CoolDown - 1
					DPrint(tBarbarians[i].CoolDown .." turn(s) until barbarian player ".. tBarbarians[i].Player .." (re-)spawns.", BE_DEBUG)
				end
			end
		end
	end
	--BESave()
end
Events.ActivePlayerTurnStart.Add(BE_Main)

include("BE_Popup.lua")
Events.SerialEventGameMessagePopup.Add(OnEventReceived)
Events.SerialEventGameDataDirty.Add(OnGameDataDirty)