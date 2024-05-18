local buildTurretButton = script.Parent
local buildGUI = buildTurretButton.Parent
local choiceGUI = buildGUI.Parent

buildTurretButton.MouseButton1Click:Connect(function()
	
	local Teams = game:GetService("Teams")
	local repSto = game:GetService("ReplicatedStorage")
	local localPlayerTeam = game:GetService("Players").LocalPlayer.Team
	local intValues = repSto.intValues 
	local buildValid = false
	
	if localPlayerTeam == Teams.A then
		if intValues.AChips.Value >= 5 then
			buildValid = true
			--Checks all the occupied rectangular nodes for a troop inside.
			local currentMap = game.Workspace.currentMap
			for i,v in pairs (currentMap.rectNodes:GetChildren()) do
				
				--Can only highlight rectangular notes that are empty but occupied by their own soldiers.
				if v:GetAttribute("ASideOccupied") == true and #v.PrimaryPart["Buildings"]:GetChildren() == 0 then
					v:SetAttribute("Greenified", true)
					v.PrimaryPart.Color = Color3.new(0.129412, 0.666667, 0.164706)
					v.ClickDetector.MaxActivationDistance = 500
				end
				
			end
		else
			repSto.Events.warning:FireServer("Not enough money for turrets.")
		end
	elseif localPlayerTeam == Teams.B then 
		if intValues.BChips.Value >= 5 then
			buildValid = true
			--Checks all the occupied rectangular nodes for a troop inside.
			local currentMap = game.Workspace.currentMap
			for i,v in pairs (currentMap.rectNodes:GetChildren()) do
				
				if v:GetAttribute("BSideOccupied") == true and #v.PrimaryPart["Buildings"]:GetChildren() == 0 then
					v:SetAttribute("Greenified", true)
					v.PrimaryPart.Color = Color3.new(0.129412, 0.666667, 0.164706)
					v.ClickDetector.MaxActivationDistance = 500
				end
				
			end
		else
			repSto.Events.warning:FireServer("Not enough money for turrets.")
		end
	end
	
	if buildValid == true then
		--Deactivation of already visible buttons
		buildGUI.Enabled = false

		--Activation of chooseBack

		choiceGUI.DecisionGUI.chooseBack.Visible = true
		choiceGUI.DecisionGUI.chooseBack.Active = true
		
		game.ReplicatedStorage.Events.turretBuild:FireServer()
	end
	
end)

buildTurretButton.MouseEnter:Connect(function()
	buildTurretButton.ImageTransparency = 0.75
	buildTurretButton.Transparency = 0.75
end)

buildTurretButton.MouseLeave:Connect(function()
	buildTurretButton.ImageTransparency = 0
	buildTurretButton.Transparency = 0
end)

