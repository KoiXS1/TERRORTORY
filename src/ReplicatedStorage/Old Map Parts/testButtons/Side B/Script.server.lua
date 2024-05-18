--These scripts are supposed to fire when the player is allowed to click on a node to move a troop from one place to another.

local Teams = game:GetService("Teams")
local Players = game:GetService("Players")

script.Parent.ClickDetector.MouseClick:Connect(function(player)

	player.Team = Teams.B
	
	--If the player was already on side A and is switching to B, A's side becomes defaulted.

	if (_G.ASidePlayer == player.Name) then
		_G.ASidePlayer = " "
	end
	
	_G.BSidePlayer = player.Name


end)
