
--This script restricts the movement of troops and only frees movement when it's their turn.

--Makes every click detector by default zero.

local currentMap = game.Workspace.currentMap
local rectNodes = currentMap.rectNodes
local octaNodes = currentMap.octaNodes

local Events = game:GetService("ReplicatedStorage").Events

--Ensures all click detectors on the client is disabled the instant a match begins.
Events.mapChosen.OnClientEvent:Connect(function()
	
	wait(0.25)
	
	for i,v in pairs (currentMap.rectNodes:GetChildren()) do
		
		--v represents a node. 
		for j, w in pairs (v.PrimaryPart.Troops:GetChildren()) do
			w.ClickDetector.MaxActivationDistance = 0
		end

	end
	
	for i,v in pairs (currentMap.octaNodes:GetChildren()) do

		--v represents a node.
		for j, w in pairs (v.PrimaryPart.Troops:GetChildren()) do
			w.ClickDetector.MaxActivationDistance = 0
		end

	end
	
end)

--Enables click detectors when someone's turn begins
Events.startTurn.OnClientEvent:Connect(function()
	
	wait(0.15)

	for i,v in pairs (currentMap.rectNodes:GetChildren()) do

		--v represents a node.
		for j, w in pairs (v.PrimaryPart.Troops:GetChildren()) do
			w.ClickDetector.MaxActivationDistance = 200
		end

	end

	for i,v in pairs (currentMap.octaNodes:GetChildren()) do

		--v represents a node.
		for j, w in pairs (v.PrimaryPart.Troops:GetChildren()) do
			w.ClickDetector.MaxActivationDistance = 200
		end

	end

end)

--Disables click detectors when someone's turn ends
Events.endTurn.OnClientEvent:Connect(function()

	for i,v in pairs (currentMap.rectNodes:GetChildren()) do

		--v represents a node.
		for j, w in pairs (v.PrimaryPart.Troops:GetChildren()) do
			w.ClickDetector.MaxActivationDistance = 0
		end

	end

	for i,v in pairs (currentMap.octaNodes:GetChildren()) do

		--v represents a node.
		for j, w in pairs (v.PrimaryPart.Troops:GetChildren()) do
			w.ClickDetector.MaxActivationDistance = 0
		end

	end

end)

