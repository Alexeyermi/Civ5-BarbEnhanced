-- BE_Popup for Barbarians Enhanced
-- Author: Nutty
-- DateCreated: 4/12/2014 11:10:28 PM
--------------------------------------------------------------

local g_iMinorCivID = -1
--local g_iMinorCivTeamID = -1
local g_control = nil
local m_PopupInfo = nil

-------------------
-- Revised Popup --
-------------------

function DoBarbarianPopup(iBarb)
	--if tBarbarians[iBarb].Pirate then
	--local pPlayer = Players[g_iMinorCivID]
	--local sMinorCivType = pPlayer:GetMinorCivType()
	ContextPtr:LookUpControl(g_control .."TitleLabel"):LocalizeAndSetText("[COLOR_WARNING_TEXT]{".. GameInfo.MinorCivPirates[tBarbarians[iBarb].ID].Description ..":upper}[ENDCOLOR]");
	--ContextPtr:LookUpControl(g_control .."TitleIcon"):UnloadTexture()
	ContextPtr:LookUpControl(g_control .."TitleIcon"):SetTextureAndResize("barbarianpopuptop300.dds")
	--else
	--end
end

-------------------------
-- On City State PopUp --
-------------------------
function OnEventReceived(popupInfo)
	
	if popupInfo.Type == ButtonPopupTypes.BUTTONPOPUP_CITY_STATE_DIPLO then
		g_control = "/InGame/CityStateDiploPopup/"
	elseif popupInfo.Type == ButtonPopupTypes.BUTTONPOPUP_CITY_STATE_GREETING then
		g_control = "/InGame/CityStateGreetingPopup/"
	elseif popupInfo.Type == ButtonPopupTypes.BUTTONPOPUP_CITY_STATE_MESSAGE then
		g_control = "/InGame/CityStateDiploPopup/"
	else
		return
	end
	
	m_PopupInfo = popupInfo	
	
    local iPlayer = popupInfo.Data1
    local pPlayer = Players[iPlayer]
	--local iTeam = pPlayer:GetTeam()
	--local pTeam = Teams[iTeam]
    
    g_iMinorCivID = iPlayer
    g_iMinorCivTeamID = iTeam
	
	local bForcePeace = false

	for i = 1, #tBarbarians do
		if iPlayer == tBarbarians[i].Player then
			DoBarbarianPopup(i)
		end
	end
end

function OnGameDataDirty()
	if not ContextPtr:LookUpControl("/InGame/CityStateDiploPopup"):IsHidden() then
		g_control = "/InGame/CityStateDiploPopup/"
	elseif not ContextPtr:LookUpControl("/InGame/CityStateGreetingPopup"):IsHidden() then
		g_control = "/InGame/CityStateGreetingPopup/"
	else
		return
	end

	m_PopupInfo = popupInfo	
	
    local iPlayer = popupInfo.Data1
    local pPlayer = Players[iPlayer]
	--local iTeam = pPlayer:GetTeam()
	--local pTeam = Teams[iTeam]
    
    g_iMinorCivID = iPlayer
    g_iMinorCivTeamID = iTeam
	
	local bForcePeace = false

	for i = 1, #tBarbarians do
		if iPlayer == tBarbarians[i].Player then
			DoBarbarianPopup(i)
		end
	end
end