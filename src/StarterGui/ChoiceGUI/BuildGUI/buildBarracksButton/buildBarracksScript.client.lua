local buildBarracksButton = script.Parent
local buildGUI = buildBarracksButton.Parent
local choiceGUI = buildGUI.Parent

buildBarracksButton.MouseButton1Click:Connect(function()
	
	local RepSto = game:GetService("ReplicatedStorage")
	local intValues = RepSto.intValues
	local Events = RepSto.Events
	 
	local localPlayer = game.Players.LocalPlayer
	local buildValid = false

	-- Checks for all occupied nodes

	local currentMap = game.Workspace.currentMap

	if localPlayer.Team.Name == "A" then

		if intValues.AChips.Value >= 4 then
			buildValid = true
			for i, v in pairs (currentMap.octaNodes:GetChildren()) do
				local buildingNumber = v:GetAttribute("factoryNumber") + v:GetAttribute("barrackNumber")

				if v:GetAttribute("ASideOccupied") == true and buildingNumber < 2 then
					v:SetAttribute("Greenified", true)
					v.PrimaryPart.Color = Color3.new(0.129412, 0.666667, 0.164706)
					v.ClickDetector.MaxActivationDistance = 500
				end
			end
		else
			Events.warning:FireServer("Not enough money for barracks!")
		end


	elseif localPlayer.Team.Name == "B" then

		if intValues.BChips.Value >= 4 then
			buildValid = true
			for i, v in pairs (currentMap.octaNodes:GetChildren()) do
				local buildingNumber = v:GetAttribute("factoryNumber") + v:GetAttribute("barrackNumber")

				if v:GetAttribute("BSideOccupied") == true and buildingNumber < 2 then
					v:SetAttribute("Greenified", true)
					v.PrimaryPart.Color = Color3.new(0.129412, 0.666667, 0.164706)
					v.ClickDetector.MaxActivationDistance = 500
				end
			end
		else
			Events.warning:FireServer("Not enough money for barracks!")
		end
	end

	if buildValid == true then
		--Deactivation of already visible buttons
		buildGUI.Enabled = false

		--Activation of chooseBack

		choiceGUI.DecisionGUI.chooseBack.Visible = true
		choiceGUI.DecisionGUI.chooseBack.Active = true
		
		_G.decisionType = "buildBarracks"
		game.ReplicatedStorage.Events.barracksBuild:FireServer()
	end

end)

buildBarracksButton.MouseEnter:Connect(function()
	buildBarracksButton.ImageTransparency = 0.75
	buildBarracksButton.Transparency = 0.75
end)

buildBarracksButton.MouseLeave:Connect(function()
	buildBarracksButton.ImageTransparency = 0
	buildBarracksButton.Transparency = 0
end)