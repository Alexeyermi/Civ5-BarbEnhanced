print("This is the 'Improvement - Airfield (Land Carriers)' mod script.")

local isGandK = (GameInfoTypes.UNITCOMBAT_NAVALMELEE ~= nil)

local iDomainLand = GameInfoTypes.DOMAIN_LAND
local iImprovementAirfield = GameInfoTypes.IMPROVEMENT_AIRFIELD
local iEarlyUnitClass = GameInfoTypes.UNITCLASS_AIRFIELD_DEFENSE_AA
local iLateUnitClass = GameInfoTypes.UNITCLASS_AIRFIELD_DEFENSE_SAM
local iEarlyUnit = GameInfoTypes.UNIT_AIRFIELD_DEFENSE_AA
local iLateUnit = GameInfoTypes.UNIT_AIRFIELD_DEFENSE_SAM
local iEarlyTech = GameInfoTypes[GameInfo.Units.UNIT_AIRFIELD_DEFENSE_AA.PrereqTech]
local iLateTech = GameInfoTypes[GameInfo.Units.UNIT_AIRFIELD_DEFENSE_SAM.PrereqTech]
local iMissionFortify = GameInfoTypes.MISSION_FORTIFY

local iBaseDamage = 5
if (isGandK) then
  iBaseDamage = 50
end

--
-- Commission Airfields - called at the end of a players turn
--
-- EITHER
--   If the player has the required tech and they have any units solely in possession of vacant airfields, commission them
-- OR
--   Pillage any vacant airfields they are on
-- 
function CommissionAirfields(iPlayer)
  -- print(string.format("Commission airfields for player %d", iPlayer))

  local pPlayer = Players[iPlayer]
  local pTeam = Teams[pPlayer:GetTeam()]

  for iPlot = 0, Map.GetNumPlots()-1, 1 do
    local pPlot = Map.GetPlotByIndex(iPlot)

    -- For every non-pillaged airfield on the map
    if (pPlot:GetImprovementType() == iImprovementAirfield and pPlot:IsImprovementPillaged() == false) then
      local bCommissioned = false;
      local iOwner = -1;

      -- Find out if it is commissioned or in the possession of a single player
      for iUnit = 0, pPlot:GetNumUnits()-1, 1 do
        local pUnit = pPlot:GetUnit(iUnit)

        if (iOwner == -1) then
          iOwner = pUnit:GetOwner()
        elseif (iOwner ~= pUnit:GetOwner()) then
          -- Two competing players, so give it to the Barbs!
          iOwner = GameDefines.MAX_CIV_PLAYERS-1
        end

        if (pUnit:GetUnitType() == iEarlyUnit or pUnit:GetUnitType() == iLateUnit) then
          bCommissioned = true
        end
      end

      -- Only interested in non-commissioned airfields
      if (bCommissioned == false) then
        -- In sole possession of this player
        if (iOwner == iPlayer) then
          local sUnitClass = nil
          if (pTeam:IsHasTech(iLateTech)) then
            sUnitClass = "UNITCLASS_AIRFIELD_DEFENSE_SAM"
          elseif (pTeam:IsHasTech(iEarlyTech)) then
            sUnitClass = "UNITCLASS_AIRFIELD_DEFENSE_AA"
          end

          if (sUnitClass ~= nil) then
            -- The player has the required tech, so commission the airfield
            local pAirfieldUnit = pPlayer:InitUnit(GameInfoTypes[GetCivSpecificUnit(pPlayer, sUnitClass)], pPlot:GetX(), pPlot:GetY(), UNITAI_COUNTER)
            pAirfieldUnit:SetDamage(iBaseDamage)
            pAirfieldUnit:PushMission(iMissionFortify)
            print(string.format("Commissioned airfield for player %d at plot %d, %d", iPlayer, pPlot:GetX(), pPlot:GetY()))

            for iUnit = pPlot:GetNumUnits()-1, 0, -1 do
              local pUnit = pPlot:GetUnit(iUnit)

              if (pUnit:IsCombatUnit() and pUnit:GetDomainType() == iDomainLand and pUnit:GetID() ~= pAirfieldUnit:GetID()) then
                pUnit:JumpToNearestValidPlot()
              end
            end
          else
            -- The player doesn't have the required tech, if this is not their land, pillage the airfield
            if (pPlot:GetOwner() ~= iPlayer) then
              pPlot:SetImprovementPillaged(true);
              print(string.format("Pillaged airfield at plot %d, %d by player %d", pPlot:GetX(), pPlot:GetY(), iPlayer))
            end
          end
        end
      end
    end
  end
end

function GetCivSpecificUnit(pPlayer, sUnitClass)
  local sUnitType = nil
  local sCivType = GameInfo.Civilizations[pPlayer:GetCivilizationType()].Type

  for pOverride in GameInfo.Civilization_UnitClassOverrides{CivilizationType = sCivType, UnitClassType = sUnitClass} do
    sUnitType = pOverride.UnitType
    break
  end

  if (sUnitType == nil) then
    sUnitType = GameInfo.UnitClasses[sUnitClass].DefaultUnit
  end

  return sUnitType
end


function OnCityCanTrain(iPlayer, iCity, iUnit)
  local iUnitClass = GameInfoTypes[GameInfo.Units[iUnit].Class]

  return (iUnitClass ~= iEarlyUnitClass and iUnitClass ~= iLateUnitClass)
end
GameEvents.CityCanTrain.Add(OnCityCanTrain)


local iLastPlayer = -1
function OnPlayerDoTurn(iPlayer)
  -- print(string.format("Start turn for player %d", iPlayer))

  if (iLastPlayer == -1) then
    iLastPlayer = iPlayer - 1
    local pLastPlayer = Players[iLastPlayer]

    while (iLastPlayer >= 0 and pLastPlayer:IsAlive() == false) do
      iLastPlayer = iLastPlayer - 1
      pLastPlayer = Players[iLastPlayer]
    end

    if (iLastPlayer < 0) then
      iLastPlayer = GameDefines.MAX_CIV_PLAYERS-1
    end
  end

  if (iLastPlayer < GameDefines.MAX_MAJOR_CIVS) then
    CommissionAirfields(iLastPlayer)
  end

  iLastPlayer = iPlayer
end
GameEvents.PlayerDoTurn.Add(OnPlayerDoTurn)
