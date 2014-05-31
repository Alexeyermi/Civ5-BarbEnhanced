-- BE_Main for Barbarians Enhanced
-- Author: Nutty
-- DateCreated: 4/15/2014 4:33:16 PM
--------------------------------------------------------------

print("Ahoy!  It's Barbarians Enhanced!")

WARN_NOT_SHARED = true
include ("ShareData")
include ("SaveUtils")
MY_MOD_NAME = "BarbariansEnhanced"

include ("BE_Init")
--Events.ActivePlayerTurnEnd.Add(BE_Save)

include ("BE_Popup")
Events.SerialEventGameMessagePopup.Add(OnEventReceived)
Events.SerialEventGameDataDirty.Add(OnGameDataDirty)

function BE_Main()
	
	--Kill the traditional barbarians.  (There's got to be a better way!)
	--for unit in Players[GameDefines.MAX_PLAYERS-1]:Units() do
		--unit:Kill()
	--end

	--Main Loop
	for i = 1, #tBarbarians do
		local pPlayer = Players[tBarbarians[i].Player]

		if tBarbarians[i].Active then
			if pPlayer:GetNumCities() > 0 then
				if tBarbarians[i].CoolDown <= 0 then
					DPrint("Barbarian player ".. tBarbarians[i].Player .." is ready to kick some arse!", BE_DEBUG)
					local iRandChoice = Game.Rand(100, "Deciding whether to attack this turn.")
					if iRandChoice <= ATTACK_PCT then
						AttackCity(pPlayer)
					end
				end
			else
				tBarbarians[i].CoolDown = SPAWN_COOLDOWN;
				tBarbarians[i].Active = false;
			end
		else
			if pPlayer:GetNumCities() <= 0 then
				if tBarbarians[i].CoolDown <= 0 then
					DPrint("Putting up a new pallisade for barbarian player ".. tBarbarians[i].Player .."...", BE_DEBUG)
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
					if max_x > -1 then
						plot = Map.GetPlot(max_x,max_y)
						if tBarbarians[i].Pirate then
							if plot:IsCoastalLand() then
								--do nothing
							else
								break
							end
						end
						if pPlayer:CanFound(max_x,max_y) then
							pPlayer:Found(max_x,max_y)
							city = plot:GetPlotCity()
							--set surrounding plot ownership to nobody
							--plot:SetOwner(-1, -1, false, false) --causes crash
							Map.GetPlot(max_x+1,max_y):SetOwner(-1, -1, false, false)
							Map.GetPlot(max_x-1,max_y):SetOwner(-1, -1, false, false)
							Map.GetPlot(max_x,max_y+1):SetOwner(-1, -1, false, false)
							Map.GetPlot(max_x,max_y-1):SetOwner(-1, -1, false, false)
							Map.GetPlot(max_x+1,max_y+1):SetOwner(-1, -1, false, false)
							Map.GetPlot(max_x-1,max_y+1):SetOwner(-1, -1, false, false)
							Map.GetPlot(max_x+1,max_y-1):SetOwner(-1, -1, false, false)
							Map.GetPlot(max_x-1,max_y-1):SetOwner(-1, -1, false, false)
							--give them a unit
							--plot:SetImprovementType(GameInfo.Improvements.IMPROVEMENT_BARBARIAN_CAMP.ID)	--doesn't work on a city
							--pPlayer:InitUnit(GameInfo.Units.UNIT_BARBARIAN_CAMP.ID, max_x, max_y)			--doesn't work after the first turn with Immobile=1
							pPlayer:InitUnit(GameInfo.Units.UNIT_BARBARIAN_WARRIOR.ID, max_x, max_y)
							tBarbarians[i].Active = true
							if tBarbarians[i].Pirate then
								city:SetName(Locale.ConvertTextKey(GameInfo.MinorCivPirates[tBarbarians[i].ID].Description))
							else
								city:SetName(Locale.ConvertTextKey(GameInfo.MinorCivBarbarians[tBarbarians[i].ID].Description))
							end
							tBarbarians[i].CoolDown = ATTACK_COOLDOWN
						end
					end
				else
					tBarbarians[i].CoolDown = tBarbarians[i].CoolDown - 1
					DPrint(tBarbarians[i].CoolDown .." turn(s) until barbarian player ".. tBarbarians[i].Player .." is (re-)spawned.", BE_DEBUG)
				end
			else
				tBarbarians[i].CoolDown = tBarbarians[i].CoolDown - 1
				DPrint(tBarbarians[i].CoolDown .." turn(s) until barbarian player ".. tBarbarians[i].Player .." attacks.", BE_DEBUG)
			end
		end
	end
	--BESave()
end
Events.ActivePlayerTurnStart.Add(BE_Main)

function AttackCity(pPlayer)
	pSourceCity = pPlayer:GetCapitalCity()
	pTargetCity = GetNearestCity(pSourceCity)
	if pTargetCity then
		local iX = pTargetCity:GetX() + 1
		local iY = pTargetCity:GetY()
		local iBarbarians = GameDefines.MAX_CIV_PLAYERS
		local team = Teams[iBarbarians]
		--melee units
		if team:HasTech(GameInfo.Technologies.TECH_MOBILE_TACTICS.ID) then
			iUnitID = GameInfoTypes["UNIT_MECHANIZED_INFANTRY"];
		elseif team:HasTech(GameInfo.Technologies.TECH_PLASTIC.ID) then
			iUnitID = GameInfoTypes["UNIT_INFANTRY"];
		elseif team:HasTech(GameInfo.Technologies.TECH_REPLACEABLE_PARTS.ID) then
			iUnitID = GameInfoTypes["UNIT_GREAT_WAR_INFANTRY"];
		elseif team:HasTech(GameInfo.Technologies.TECH_RIFLING.ID) then
			iUnitID = GameInfoTypes["UNIT_RIFLEMAN"];
		elseif team:HasTech(GameInfo.Technologies.TECH_GUNPOWDER.ID) then
			iUnitID = GameInfoTypes["UNIT_MUSKETMAN"];
		elseif team:HasTech(GameInfo.Technologies.TECH_STEEL.ID) then
			iUnitID = GameInfoTypes["UNIT_BARBARIAN_LONGSWORDSMAN"];
		elseif team:HasTech(GameInfo.Technologies.TECH_IRON_WORKING.ID) then
			iUnitID = GameInfoTypes["UNIT_BARBARIAN_SWORDSMAN"];
		else 
			iUnitID = GameInfoTypes["UNIT_BARBARIAN_WARRIOR"];
		end
		for i = 1, ATTACK_MELEE do
			unit = pPlayer:InitUnit(iUnitID, iX, iY, UNITAI_ATTACK);
			unit:JumpToNearestValidPlot();
		end
		--ranged units
		if team:HasTech(GameInfo.Technologies.TECH_NUCLEAR_FISSION.ID) then
			iUnitID = GameInfoTypes["UNIT_BAZOOKA"];
		elseif team:HasTech(GameInfo.Technologies.TECH_BALLISTICS.ID) then
			iUnitID = GameInfoTypes["UNIT_MACHINE_GUN"];
		elseif team:HasTech(GameInfo.Technologies.TECH_INDUSTRIALIZATION.ID) then
			iUnitID = GameInfoTypes["UNIT_GATLINGGUN"];
		elseif team:HasTech(GameInfo.Technologies.TECH_MACHINERY.ID) then
			iUnitID = GameInfoTypes["UNIT_BARBARIAN_CROSSBOWMAN"];
		elseif team:HasTech(GameInfo.Technologies.TECH_CONSTRUCTION.ID) then
			iUnitID = GameInfoTypes["UNIT_BARBARIAN_COMPOSITE_BOWMAN"];
		elseif team:HasTech(GameInfo.Technologies.TECH_THE_WHEEL.ID) then
			iUnitID = GameInfoTypes["UNIT_BARBARIAN_ARCHER"];
		elseif team:HasTech(GameInfo.Technologies.TECH_ARCHERY.ID) then
			iUnitID = GameInfoTypes["UNIT_BARBARIAN_AXMAN"];
		else
			iUnitID = GameInfoTypes["UNIT_BARBARIAN_WARRIOR"];
		end
		for i = 1, ATTACK_RANGED do
			unit = pPlayer:InitUnit(iUnitID, iX, iY, UNITAI_ATTACK);
			unit:JumpToNearestValidPlot();
		end
		--siege units
		if team:HasTech(GameInfo.Technologies.TECH_ROCKETRY.ID) then
			iUnitID = GameInfoTypes["UNIT_ROCKET_ARTILLERY"];
		elseif team:HasTech(GameInfo.Technologies.TECH_DYNAMITE.ID) then
			iUnitID = GameInfoTypes["UNIT_ARTILLERY"];
		elseif team:HasTech(GameInfo.Technologies.TECH_CHEMISTRY.ID) then
			iUnitID = GameInfoTypes["UNIT_CANNON"];
		elseif team:HasTech(GameInfo.Technologies.TECH_PHYSICS.ID) then
			iUnitID = GameInfoTypes["UNIT_TREBUCHET"];
		elseif team:HasTech(GameInfo.Technologies.TECH_MATHEMATICS.ID) then
			iUnitID = GameInfoTypes["UNIT_CATAPULT"];
		else
			iUnitID = GameInfoTypes["UNIT_BARBARIAN_WARRIOR"];
		end
		for i = 1, ATTACK_SIEGE do
			unit = pPlayer:InitUnit(iUnitID, iX, iY, UNITAI_ATTACK);
			unit:JumpToNearestValidPlot();
		end

--fast melee
--UNITCLASS_MECH.ID				TECH_NUCLEAR_FUSION.ID
--UNITCLASS_MODERN_ARMOR.ID		TECH_LASERS.ID
--UNITCLASS_HELICOPTER_GUNSHIP.ID	TECH_COMPUTERS.ID
--UNITCLASS_TANK.ID				TECH_COMBINED_ARMS.ID
--UNITCLASS_WWI_TANK.ID			TECH_COMBUSTION.ID
--UNITCLASS_CAVALRY.ID			TECH_MILITARY_SCIENCE.ID
--UNITCLASS_KNIGHT.ID				TECH_CHIVALRY.ID
--UNITCLASS_HORSEMAN.ID			TECH_HORSEBACK_RIDING.ID
--UNITCLASS_CHARIOT_ARCHER.ID		TECH_THE_WHEEL.ID
--anti fast
--UNITCLASS_ANTI_TANK_GUN.ID	TECH_COMBINED_ARMS.ID
--UNITCLASS_LANCER.ID			TECH_METALLURGY.ID
--UNITCLASS_PIKEMAN.ID		TECH_CIVIL_SERVICE.ID
--UNITCLASS_SPEARMAN.ID		TECH_BRONZE_WORKING.ID
--anti air
--UNITCLASS_MOBILE_SAM.ID			TECH_ROCKETRY.ID
--UNITCLASS_ANTI_AIRCRAFT_GUN.ID	TECH_BALLISTICS.ID
--other
--UNITCLASS_NUCLEAR_MISSILE.ID	TECH_ADVANCED_BALLISTICS.ID
--NO--UNITCLASS_ATOMIC BOMB		TECH_NUCLEAR_FISSION.ID
--NO--UNITCLASS_PARATROOPER		TECH_RADAR.ID	xcom
--NO--UNITCLASS_MARINE			TECH_PENICILIN.ID	dead end
--NO--UNITCLASS_XCOM_SQUAD		TECH_NANOTECHNOLOGY.ID
--melee naval
--UNITCLASS_DESTROYER.ID	TECH_STEAM_POWER.ID
--UNITCLASS_IRONCLAD.ID	TECH_COMBUSTION.ID
--UNITCLASS_PRIVATEER.ID	TECH_NAVIGATION.ID
--UNITCLASS_CARAVEL.ID	TECH_ASTRONOMY.ID
--UNITCLASS_TRIREME.ID	TECH_SAILING.ID
--UNITCLASS_GALLEY.ID
--anti naval
--UNITCLASS_NUCLEAR_SUBMARINE.ID	TECH_TELECOM.ID
--UNITCLASS_SUBMARINE.ID			TECH_REFRIGERATION.ID
--ranged naval
--UNITCLASS_MISSILE_CRUISER.ID	TECH_ROBOTICS.ID
--UNITCLASS_BATTLESHIP.ID			TECH_ELECTRONICS.ID
--UNITCLASS_FRIGATE.ID			TECH_NAVIGATION.ID
--UNITCLASS_GALLEASS.ID			TECH_COMPASS.ID
--air
--UNITCLASS_STEALTH_BOMBER.ID	TECH_STEALTH.ID
--UNITCLASS_GUIDED_MISSILE.ID	TECH_ADVANCED_BALLISTICS.ID
--UNITCLASS_BOMBER.ID			TECH_RADAR.ID
--UNITCLASS_WWI_BOMBER.ID		TECH_FLIGHT.ID
--anti air
--UNITCLASS_JET_FIGHTER.ID	TECH_LASERS.ID
--UNITCLASS_FIGHTER.ID		TECH_RADAR.ID
--UNITCLASS_TRIPLANE.ID		TECH_FLIGHT.ID

	end
end

function GetNearestCity(city)
	local iShortestDistance = 99999
	local pNearestCity = nil
	
	local iPlotX = city:GetX()
	local iPlotY = city:GetY()
	
	for iPlayer=0, GameDefines.MAX_CIV_PLAYERS-2, 1 do
		local pPlayer = Players[iPlayer]
		if (pPlayer:IsEverAlive() and pPlayer:IsAlive()) then
			for pCity in pPlayer:Cities() do
				local iDist = Map.PlotDistance(pCity:GetX(), pCity:GetY(), iPlotX, iPlotY)
				if (iDist < iShortestDistance) then
					iShortestDistance = iDist
					--pNearestPlayer = pPlayer
					pNearestCity = pCity
				end
			end
		end
	end
	return pNearestCity
end