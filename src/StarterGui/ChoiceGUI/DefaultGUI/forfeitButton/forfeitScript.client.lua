local forfeitButton = script.Parent
local defaultGUI = forfeitButton.Parent
local choiceGUI = defaultGUI.Parent

local Events = game.ReplicatedStorage.Events

forfeitButton.MouseButton1Click:Connect(function()
	
	--Disables GUI
	defaultGUI.Enabled = false

	--Team finding
	if game.Players.LocalPlayer.Team == game.Teams.A then
		Events.warning:FireServer("B Side wins by forfeit.")
		Events.endGame:FireServer()
	else 
		Events.warning:FireServer("A Side wins by forfeit.")
		Events.endGame:FireServer()
	end
	
end)

--When the user moves their troop, this button should be hidden.
local troopDecisionStart = Events.troopDecisionStart
troopDecisionStart.OnClientEvent:Connect(function()

	forfeitButton.Visible = false
	forfeitButton.Active = false

end)

--When the user stops moving their troop, this button should be shown again.
local troopDecisionEnd = Events.troopDecisionEnd
troopDecisionEnd.OnClientEvent:Connect(function()

	forfeitButton.Visible = true
	forfeitButton.Active = true

end)

--When the user finishes their building decision, this button should be shown again.
local buildDecisionEnd = Events.buildDecisionEnd
buildDecisionEnd.OnClientEvent:Connect(function()

	forfeitButton.Visible = true
	forfeitButton.Active = true

end)