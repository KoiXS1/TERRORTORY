local buildButton = script.Parent
local defaultGUI = buildButton.Parent
local choiceGUI = defaultGUI.Parent
local buildGUI = choiceGUI.BuildGUI
local decisionGUI = choiceGUI.DecisionGUI

buildButton.MouseButton1Click:Connect(function()
	
	buildGUI.Enabled = true
	
	defaultGUI.Enabled = false
	
	--Entering Build Mode
	
	--SHOULD DEACTIVATE SOLDIER CLICKERS
	
	local currentMap = game.Workspace.currentMap
	
	for i,a in pairs (currentMap.octaNodes:GetChildren()) do
		for i,b in pairs (a.PrimaryPart.Troops:GetChildren()) do
			b.ClickDetector.MaxActivationDistance = 0
		end
	end
	
	for i,c in pairs (currentMap.rectNodes:GetChildren()) do
		for i,d in pairs (c.PrimaryPart.Troops:GetChildren()) do
			d.ClickDetector.MaxActivationDistance = 0
		end
	end

end)

buildButton.MouseEnter:Connect(function()
	buildButton.ImageTransparency = 0.75
	buildButton.Transparency = 0.75
end)

buildButton.MouseLeave:Connect(function()
	buildButton.ImageTransparency = 0
	buildButton.Transparency = 0
end)


-- For when the player does action in Movement Mode
local troopDecisionStart = game.ReplicatedStorage.Events.troopDecisionStart
local troopDecisionEnd = game.ReplicatedStorage.Events.troopDecisionEnd

--Visibility changes
troopDecisionStart.OnClientEvent:Connect(function()
	
	defaultGUI.Enabled = false
	
end)

troopDecisionEnd.OnClientEvent:Connect(function()

	defaultGUI.Enabled = true

end)

-- For when build mode ends via constructing.
local buildDecisionEnd = game.ReplicatedStorage.Events.buildDecisionEnd
buildDecisionEnd.OnClientEvent:Connect(function()
	
	local currentMap = game.Workspace.currentMap
	
	for i,v in pairs (currentMap.octaNodes:GetChildren()) do
		if (v:GetAttribute("Greenified") == true) then
			v.PrimaryPart.Color = v:GetAttribute("lastTeamColor")
			v:SetAttribute("Greenified", false)
			v.ClickDetector.MaxActivationDistance = 0
		end
	end

	for i,v in pairs (currentMap.rectNodes:GetChildren()) do
		if (v:GetAttribute("Greenified") == true) then
			v.PrimaryPart.Color = v:GetAttribute("lastTeamColor")
			v:SetAttribute("Greenified", false)
			v.ClickDetector.MaxActivationDistance = 0
		end
	end
	
	defaultGUI.Enabled = true
	
	buildGUI.Enabled = false
	
	decisionGUI.chooseBack.Visible = false
	decisionGUI.chooseBack.Active = false
	
	--Should reactivate click detectors
	local currentMap = game.Workspace.currentMap

	for i,a in pairs (currentMap.octaNodes:GetChildren()) do
		for i,b in pairs (a.PrimaryPart.Troops:GetChildren()) do
			b.ClickDetector.MaxActivationDistance = 100
		end
	end

	for i,c in pairs (currentMap.rectNodes:GetChildren()) do
		for i,d in pairs (c.PrimaryPart.Troops:GetChildren()) do
			d.ClickDetector.MaxActivationDistance = 100
		end
	end
	
end)

local temporaryDisable = game.ReplicatedStorage.Events.temporaryDisableInteraction
temporaryDisable.OnClientEvent:Connect(function(timeWait)
	defaultGUI.Enabled = false
	task.wait(timeWait)
	defaultGUI.Enabled = true
end)

local startTurn = game:GetService("ReplicatedStorage").Events.startTurn
startTurn.OnClientEvent:Connect(function()
	
	defaultGUI.Enabled = true
	
end)