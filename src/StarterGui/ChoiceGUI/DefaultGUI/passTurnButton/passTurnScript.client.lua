local passTurnButton = script.Parent
local defaultGUI = passTurnButton.Parent
local RepSto = game:GetService("ReplicatedStorage")

--When pressed, the button should end the turn and deactivate choices.
passTurnButton.MouseButton1Click:Connect(function()
	
	--[[Deters a bug where when the user passes the turn to their enemy and then enemy
	    passes it back, the button is already translucent instead of being opaque.]]
	passTurnButton.ImageTransparency = 0
	passTurnButton.Transparency = 0
	
	--Deactivates the GUI
	defaultGUI.Enabled = false
	
	local endTurn = RepSto.Events.endTurn
	endTurn:FireServer()
	
	local Events = RepSto.Events
	local startTurn = Events.startTurn
	local currentMap = game.Workspace.currentMap
	

	--Searches each octagonal node for its soldiers and DEACTIVATES the click detectors.
	for i,v in pairs(currentMap.octaNodes:GetChildren()) do
		for k,w in pairs (v.PrimaryPart.Troops:GetChildren()) do
			w.ClickDetector.MaxActivationDistance = 0
		end
	end

	--Searches each rectangular node for its soldiers and DEACTIVATES the click detectors
	for i,v in pairs(currentMap.rectNodes:GetChildren()) do
		for k,w in pairs (v.PrimaryPart.Troops:GetChildren()) do
			w.ClickDetector.MaxActivationDistance = 0
		end
	end
	
end)

passTurnButton.MouseEnter:Connect(function()
	passTurnButton.ImageTransparency = 0.75
	passTurnButton.Transparency = 0.75
end)

passTurnButton.MouseLeave:Connect(function()
	passTurnButton.ImageTransparency = 0
	passTurnButton.Transparency = 0
end)

--When the user moves their troop, this button should be hidden.
local troopDecisionStart = RepSto.Events.troopDecisionStart
troopDecisionStart.OnClientEvent:Connect(function()

	passTurnButton.Visible = false
	passTurnButton.Active = false

end)

--When the user stops moving their troop, this button should be shown again.
local troopDecisionEnd = RepSto.Events.troopDecisionEnd
troopDecisionEnd.OnClientEvent:Connect(function()

	passTurnButton.Visible = true
	passTurnButton.Active = true

end)

--When the user finishes their building decision, this button should be shown again.
local buildDecisionEnd = RepSto.Events.buildDecisionEnd
buildDecisionEnd.OnClientEvent:Connect(function()

	passTurnButton.Visible = true
	passTurnButton.Active = true

end)

