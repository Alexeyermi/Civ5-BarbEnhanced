-- BE_Init for Barbarians Enhanced
-- Author: Nutty
-- DateCreated: 4/13/2014 4:50:17 PM
--------------------------------------------------------------

--set this in pre-game custom setup?:

MAX_BARBS = 7			--maximum barbarians at any one time
MAX_PIRATES = 3			--maximum pirates at any one time
COOLDOWN_TURNS = 10		--minimum turns between spawns
BE_DEBUG = true			--output to log file
--DOUBLECROSS_PCT = 5		--percent chance barb will renege on agreement [unused]

tBarbarians = {}

local bInit = false

function DPrint(str, bOutput)
	if bOutput == nil then
		bOutput = true
	end
	if bOutput then
		print(str)
	end
end

function BE_Save()
	--save(0, "barbarians", tBarbarians)
end

function BE_Load(key)
	for k,v in pairs(load(0)) do
		if k == key then
			return v
		else
			return false
		end
	end
end

--bInit = BE_Load("init")
if bInit then
	DPrint("Barbarians Enhanced is loading previous database...", BE_DEBUG)
	--tBarbarians = BE_Load("barbarians")
	return
end

DPrint("Barbarians Enhanced is initializing...", BE_DEBUG)

local tMinorPlayers = {}
local tOpenMinorPlayers = {}
local iNumBarbs = MAX_BARBS
local iNumPirates = MAX_PIRATES

PreGame.SetNumMinorCivs(GameDefines.MAX_CIV_PLAYERS - GameDefines.MAX_MAJOR_CIVS)

--Check the player list for openings
for iPlayer = GameDefines.MAX_MAJOR_CIVS, GameDefines.MAX_CIV_PLAYERS-1 do
	local player = Players[iPlayer]
	local minorCivType = player:GetMinorCivType()
	if minorCivType ~= -1 then
		local minorCivInfo = GameInfo.MinorCivilizations[minorCivType];
		table.insert(tMinorPlayers, iPlayer)

		--if player:GetPersonality() == 2 then
		--	player:SetPersonalityType(1)	--[doesn't work for minors]
		--end

		if player:GetNumUnits() == 0 then
			table.insert(tOpenMinorPlayers, iPlayer)
		end
	end
end
	
if #tMinorPlayers > 0 then
	local iNumPlayersToSteal = 0
	if MAX_BARBS + MAX_PIRATES <= #tOpenMinorPlayers then
		DPrint("Plenty of room for barbarians...", BE_DEBUG)
	elseif #tOpenMinorPlayers <= 0 then
		DPrint("No room for barbarians!  Commandeering half of all city states for use as barbarians...", BE_DEBUG)
		iNumPlayersToSteal = #tMinorPlayers/2
		iNumPirates = iNumPlayersToSteal/3
		iNumBarbs = iNumPlayersToSteal - iNumPirates
	else
		iNumPlayersToSteal = (MAX_BARBS + MAX_PIRATES - #tOpenMinorPlayers)/2
		if iNumPlayersToSteal <= #tMinorPlayers - #tOpenMinorPlayers then
			DPrint("Not enough room for all barbarians!  Commandeering some city states for use as barbarians...", BE_DEBUG)
			iNumPirates = (#tOpenMinorPlayers + iNumPlayersToSteal)/3
			iNumBarbs = #tOpenMinorPlayers + iNumPlayersToSteal - iNumPirates
		else
			DPrint("Not enough room for all barbarians!  Will have to use less...", BE_DEBUG)
			iNumPlayersToSteal = 0
			iNumPirates = #tOpenMinorPlayers/3
			iNumBarbs = #tOpenMinorPlayers - iNumPirates
		end
	end
		
	--Commandeer city states to use as barbarians, if necessary
	if iNumPlayersToSteal > 0 then
		for i, iPlayer in ipairs(tMinorPlayers) do
			local player = Players[iPlayer]
			--Make the player inactive by killing off their units
			for unit in player:Units() do
				unit:Kill()
			end	
			table.insert(tOpenMinorPlayers, iPlayer)

			iNumPlayersToSteal = iNumPlayersToSteal-1
			if iNumPlayersToSteal <= 0 then
				break
			end
		end
	end

	local barbID = 1
	local pirateID = 1

	--Create barbarian table
	for i, iPlayer in ipairs(tOpenMinorPlayers) do
		if iNumPirates <= 0 then
			break
		end
		--Declare permanent war on all major civs
		local player = Players[tMinorPlayers[iPlayer]]
		PreGame.SetTeam(iPlayer, GameDefines.MAX_PLAYERS-1)
		local iTeam = player:GetTeam()
		for iEnemy = 0, GameDefines.MAX_MAJOR_CIVS do
			local enemy = Players[iEnemy]
			local iEnemyTeam = enemy:GetTeam()
			local enemyTeam = Teams[iEnemyTeam]
			enemyTeam:DeclareWar(iTeam)
			enemyTeam:SetPermanentWarPeace(iTeam)
			Teams[iTeam]:SetPermanentWarPeace(iEnemyTeam)
		end
		--player:SetPersonalityType(2)	--[doesn't work for minors]
		if iNumBarbs > 0 then
			tBarbarians[i] = { ID = barbID, Player = iPlayer, Active = false, CoolDown = i*2, Pirate = false }
			--Type = GameInfo.MinorCivBarbarians[barbID].Type
			iNumBarbs = iNumBarbs-1
			barbID = barbID+1
		elseif iNumPirates > 0 then
			tBarbarians[i] = { ID = pirateID, Player = iPlayer, Active = false, CoolDown = i*2, Pirate = true }
			--Type = GameInfo.MinorCivPirates[pirateID].Type
			iNumPirates = iNumPirates-1
			pirateID = pirateID+1
		end
	end
	for i = 1, #tBarbarians do
		PreGame.SetPlayerColor(tBarbarians[i].Player, GameInfo.PlayerColors["PLAYERCOLOR_BARBARIAN"].ID)
		if tBarbarians[i].Pirate then
			local descr = Locale.ConvertTextKey(GameInfo.MinorCivPirates[tBarbarians[i].ID].Description)
			DPrint(i .." Player ".. tBarbarians[i].Player .." = Pirate ".. tBarbarians[i].ID .." ".. descr, BE_DEBUG)
			PreGame.SetCivilizationDescription(tBarbarians[i].Player, descr)
			PreGame.SetCivilizationShortDescription(tBarbarians[i].Player, descr)
			PreGame.SetCivilizationAdjective(tBarbarians[i].Player, descr)
		else
			local descr = Locale.ConvertTextKey(GameInfo.MinorCivBarbarians[tBarbarians[i].ID].Description)
			DPrint(i .." Player ".. tBarbarians[i].Player .." = Barbarian ".. tBarbarians[i].ID .." ".. descr, BE_DEBUG)
			PreGame.SetCivilizationDescription(tBarbarians[i].Player, descr)
			PreGame.SetCivilizationShortDescription(tBarbarians[i].Player, descr)
			PreGame.SetCivilizationAdjective(tBarbarians[i].Player, descr)
		end
	end
else
	DPrint("Warning!  No city states enabled; can't set up any barbarians!", BE_DEBUG)
end

--save(0, "init", true)
--BE_Save()

DPrint("Barbarians Enhanced initialization is complete.", BE_DEBUG)