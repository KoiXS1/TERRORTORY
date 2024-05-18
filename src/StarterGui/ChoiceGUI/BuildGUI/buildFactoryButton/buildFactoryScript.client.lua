local buildFactoryButton = script.Parent
local buildGUI = buildFactoryButton.Parent
local choiceGUI = buildGUI.Parent

buildFactoryButton.MouseButton1Click:Connect(function()
	
	local repSto = game:GetService("ReplicatedStorage")
	local intValues = repSto.intValues
	local localPlayer = game.Players.LocalPlayer
	local buildValid = false
	
	-- Checks for all occupied nodes

	local currentMap = game.Workspace.currentMap
	
	if localPlayer.Team.Name == "A" then
		
		if intValues.AChips.Value >=8 then
			buildValid = true
			for i, v in pairs (currentMap.octaNodes:GetChildren()) do
				local buildingNumber = v:GetAttribute("factoryNumber") + v:GetAttribute("barrackNumber")

				print(
					"Name: "..v.Name..'\n'..
						"ASideOccupied? : "..tostring(v:GetAttribute("ASideOccupied"))..'\n'..	
						"Building Number: "..buildingNumber
				)

				if v:GetAttribute("ASideOccupied") == true and buildingNumber < 2 then
					v:SetAttribute("Greenified", true)
					v.PrimaryPart.Color = Color3.new(0.129412, 0.666667, 0.164706)
					v.ClickDetector.MaxActivationDistance = 500
				end
			end
		else
			repSto.Events.warning:FireServer("Not enough money for factories.")
		end
		
		
	elseif localPlayer.Team.Name == "B" then
		
		if intValues.BChips.Value >=8 then
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
			repSto.Events.warning:FireServer("Not enough money for factories.")
		end	
	end
	
	if buildValid == true then
		--Deactivation of already visible buttons
		buildGUI.Enabled = false

		--Activation of chooseBack

		choiceGUI.DecisionGUI.chooseBack.Visible = true
		choiceGUI.DecisionGUI.chooseBack.Active = true
		
		_G.decisionType = "buildFactory"
		game.ReplicatedStorage.Events.factoryBuild:FireServer()
	end

end)

buildFactoryButton.MouseEnter:Connect(function()
	buildFactoryButton.ImageTransparency = 0.75
	buildFactoryButton.Transparency = 0.75
end)

buildFactoryButton.MouseLeave:Connect(function()
	buildFactoryButton.ImageTransparency = 0
	buildFactoryButton.Transparency = 0
end)