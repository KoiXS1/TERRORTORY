--These scripts are supposed to fire when the player is allowed to click on a node to move a troop from one place to another.

local Teams = game:GetService("Teams")

script.Parent.ClickDetector.MouseClick:Connect(function(player)

	player.Team = Teams.A
	
	--If the player was already on side B and is switching to A, B's side becomes defaulted.
	if (_G.BSidePlayer == player.Name) then
		_G.BSidePlayer = ""
	end
	
	_G.ASidePlayer = player.Name

	
end)
