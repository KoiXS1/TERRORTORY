local Players = game:GetService("Players")

local Teams = game:GetService("Teams")

	Players.PlayerAdded:Connect(function(player)
		
		local sideDecider = math.random(0,1)

		if (#Players:GetPlayers() == 2) then  -- Case for 2 players in server.
			
			if (#Teams.A:GetPlayers() == 1) then
				player.Team = Teams.B
				print("2nd player joined. - B")
			else
				player.Team = Teams.A
				print("2nd player joined. - A")
			end
			
		else                                  -- Case that player joined is the 1st player.
		
			if (sideDecider == 0) then
				player.Team = Teams.A
				print("1st player joined. - A")
			else 
				player.Team = Teams.B
				print("1st player joined. - B")
			end
		
		end

end)

