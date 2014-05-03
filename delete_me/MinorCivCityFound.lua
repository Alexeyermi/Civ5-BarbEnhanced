-- Lua Script1
-- Author: Davii
-- DateCreated: 9/30/2011 5:12:39 AM
--------------------------------------------------------------

include ( "InstanceManager" );
include ( "SupportFunctions" );

print("---Begin CS Expansion Script---")

function CreateCSCities()
	
	print("Running CS expansion check")
	
	local iPlayer = Game.GetActivePlayer();
	local pPlayer = Players[ iPlayer ];
	local pTeam = Teams[pPlayer:GetTeam()];
	local numTotalMinorAlive = 0;
			
	for iPlayerLoop = GameDefines.MAX_MAJOR_CIVS, GameDefines.MAX_CIV_PLAYERS-1, 1 do
		
		pOtherPlayer = Players[iPlayerLoop];
		iOtherTeam = pOtherPlayer:GetTeam();
	
		if (pPlayer:GetTeam() ~= iOtherTeam and pOtherPlayer:IsAlive()) then
		
			if (pOtherPlayer:IsMinorCiv()) then
				numTotalMinorAlive = numTotalMinorAlive + 1;
										
			local cityName = pOtherPlayer:GetNameKey();
			local localizedCityName = Locale.ConvertTextKey(cityName);
			local convertedKey = Locale.ToUpper(localizedCityName);
			local numCities = pOtherPlayer:GetNumCities();

				for pCity in pOtherPlayer:Cities() do

					local cityPop = pCity:GetPopulation();
					local cityPlotX = pCity:GetX();
					local cityPlotY = pCity:GetY();
					local distanceToNextCity;
					local cityLimit = 0;
					local cityDistanceLimit = 12;
					
					if (cityPop / numCities > 5) then
						
						if (numTotalMinorAlive >= 12) then
													
							if (numCities >= 2) then

								cityLimit = 1;
							
								print(convertedKey .. " expansion NOT available (2) ");
							
							end
						end

						if (numCities >= 3) then

							cityLimit = 1;

							print(convertedKey .. " expansion NOT available (3) ");
																																
						end
							
						if (cityLimit ~= 0) then

							print(convertedKey .. " currently restricted from expansion ");
							
							return;

						else
										
							print(convertedKey .. " expansion available ");

							local iW, iH = Map.GetGridSize();
							local max = 0;
							local max_x = -1;
							local max_y = -1;

							for y = 0, iH - 1 do
								for x = 0, iW - 1 do
									local v = pOtherPlayer:AI_foundValue(x,y);
									if v > max then
										max = v;
										max_x = x;
										max_y = y;
									end
								end
							end
							
							distanceToNextCity = Map.PlotDistance(cityPlotX, cityPlotY, max_x, max_y)

							if (distanceToNextCity >= cityDistanceLimit) then

								print(convertedKey .. " next city over distance limit ");
								return;
														
							elseif (max_x > -1) then
																
								if (pOtherPlayer:CanFound(max_x,max_y)) then
								
									pOtherPlayer:Found(max_x,max_y); --how to require settlers? (would stop cities spawning in places CS cannot reach)

								end
							end
						end
					end
				end
			end
		end
	end
end

print("---End Of CS Expansion Script---")

function RunCSCheck()

	CreateCSCities()
	
end

RunCSCheck();

Events.ActivePlayerTurnStart.Add(RunCSCheck)
--Events.ActivePlayerTurnStart.Add(CreateCSCities)