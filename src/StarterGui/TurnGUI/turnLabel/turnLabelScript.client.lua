local turnLabel = script.Parent

local repSto = game:GetService("ReplicatedStorage")
local Events = repSto.Events

Events.mapChosen.OnClientEvent:Connect(function()
	
	local intValues = repSto:WaitForChild("intValues")
	
	turnLabel.Text = "Turn: "..intValues.turnNumber.Value.." - A"
	
	turnLabel.Visible = true
	
	
end)

Events.updateTurnLabel.OnClientEvent:Connect(function(sideLabel)
	
	local intValues = repSto:WaitForChild("intValues")

	turnLabel.Text = "Turn: "..intValues.turnNumber.Value..sideLabel
	
end)

	
