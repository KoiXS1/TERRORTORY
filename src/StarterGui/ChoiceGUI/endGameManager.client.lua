local choiceGUI = script.Parent

local Events = game:GetService("ReplicatedStorage").Events

Events.endGame.OnClientEvent:Connect(function()
	
	--Disables GUI
	choiceGUI.Enabled = false
	
	--Disables click detectors on all troops
	for i,v in pairs (workspace.currentMap.rectNodes:GetChildren()) do
		
		for j,w in pairs (v.PrimaryPart.Troops:GetChildren()) do
			
			if w then
				w.ClickDetector.MaxActivationDistance = 0
			end
			
		end
		
	end
	
	for i,v in pairs (workspace.currentMap.octaNodes:GetChildren()) do
		
		for j,w in pairs (v.PrimaryPart.Troops:GetChildren()) do
			
			if w then
				w.ClickDetector.MaxActivationDistance = 0
			end

		end

	end
	
end)
