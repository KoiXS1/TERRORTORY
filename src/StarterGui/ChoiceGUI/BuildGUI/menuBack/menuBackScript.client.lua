local menuBack = script.Parent
local buildGUI = menuBack.Parent
local choiceGUI = buildGUI.Parent
local defaultGUI = choiceGUI.DefaultGUI

local buildDecisionEnd = game.ReplicatedStorage.Events.buildDecisionEnd

menuBack.MouseButton1Click:Connect(function(player)

	buildGUI.Enabled = false

	defaultGUI.Enabled = true
	
	--Exiting Build Mode

	_G.decisionType = ""
	
	local currentMap = game.Workspace.currentMap

	for i,a in pairs (currentMap.octaNodes:GetChildren()) do
		for i,b in pairs (a.PrimaryPart.Troops:GetChildren()) do
			b.ClickDetector.MaxActivationDistance = 500
		end
	end

	for i,c in pairs (currentMap.rectNodes:GetChildren()) do
		for i,d in pairs (c.PrimaryPart.Troops:GetChildren()) do
			d.ClickDetector.MaxActivationDistance = 500
		end
	end

end)

menuBack.MouseEnter:Connect(function()
	menuBack.ImageTransparency = 0.75
	menuBack.Transparency = 0.75
end)

menuBack.MouseLeave:Connect(function()
	menuBack.ImageTransparency = 0
	menuBack.Transparency = 0
end)