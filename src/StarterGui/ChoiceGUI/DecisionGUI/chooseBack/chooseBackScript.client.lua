local chooseBack = script.Parent
local decisionGUI = chooseBack.Parent
local choiceGUI = decisionGUI.Parent
local buildGUI = choiceGUI.BuildGUI

local currentMap = game.Workspace.currentMap

chooseBack.MouseButton1Click:Connect(function()
	
	chooseBack.Visible = false
	chooseBack.Active = false
	
	--Re-enables the build GUI
	buildGUI.Enabled = true
	
	
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
	
end)

chooseBack.MouseEnter:Connect(function()
	
	chooseBack.ImageTransparency = 0.75
	chooseBack.Transparency = 0.75
	
end)
