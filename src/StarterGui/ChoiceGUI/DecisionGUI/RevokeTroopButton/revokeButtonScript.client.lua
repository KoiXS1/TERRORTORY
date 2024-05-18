local revokeButton = script.Parent
local decisionGUI = revokeButton.Parent
local defaultGUI = decisionGUI.Parent.DefaultGUI

local troopDecisionStart = game.ReplicatedStorage.Events.troopDecisionStart
local troopDecisionEnd = game.ReplicatedStorage.Events.troopDecisionEnd

local currentMap = game.Workspace.currentMap

revokeButton.MouseButton1Click:Connect(function()
	
	troopDecisionEnd:FireServer()
	
	for i,v in pairs (defaultGUI:GetChildren()) do
		v.Active = true
		v.Visible = true
	end
	
end)

revokeButton.MouseEnter:Connect(function()
	revokeButton.ImageTransparency = 0.75
	revokeButton.Transparency = 0.75
end)

revokeButton.MouseLeave:Connect(function()
	revokeButton.ImageTransparency = 0
	revokeButton.Transparency = 0
end)

troopDecisionStart.OnClientEvent:Connect(function()
	revokeButton.Visible = true
	revokeButton.Active = true
end)

troopDecisionEnd.OnClientEvent:Connect(function()
	revokeButton.Visible = false
	revokeButton.Active = false
end)