local enemyCurrencyLabel = script.Parent

local repSto = game:GetService("ReplicatedStorage")
local events = repSto.Events

local localPlayer = game.Players.LocalPlayer
local Teams = game:GetService("Teams")

--All of the functions are text updaters.
events.mapChosen.OnClientEvent:Connect(function()
	
	--[[
	intValues is not replicated outside the event as
	intValues is only created just very shortly before mapChosen is fired.
	]]--
	local intValues = repSto:WaitForChild("intValues")
	
	if localPlayer.Team == Teams.A then
		enemyCurrencyLabel.Text = "Enemy Chips: "..intValues.BChips.Value
	elseif localPlayer.Team == Teams.B then
		enemyCurrencyLabel.Text = "Enemy Chips: "..intValues.AChips.Value
	end
	
	enemyCurrencyLabel.Visible = true

end)

events.buildDecisionEnd.OnClientEvent:Connect(function()
	
	local intValues = repSto:WaitForChild("intValues")
	
	if localPlayer.Team == Teams.A then
		enemyCurrencyLabel.Text = "Enemy Chips: "..intValues.BChips.Value
	elseif localPlayer.Team == Teams.B then
		enemyCurrencyLabel.Text = "Enemy Chips: "..intValues.AChips.Value
	end
	
end)

events.troopDecisionEnd.OnClientEvent:Connect(function()
	
	local intValues = repSto:WaitForChild("intValues")
	
	if localPlayer.Team == Teams.A then
		enemyCurrencyLabel.Text = "Enemy Chips: "..intValues.BChips.Value
	elseif localPlayer.Team == Teams.B then
		enemyCurrencyLabel.Text = "Enemy Chips: "..intValues.AChips.Value
	end
	
end)

events.endFullTurn.OnClientEvent:Connect(function()
	
	local intValues = repSto:WaitForChild("intValues")

	if localPlayer.Team == Teams.A then
		enemyCurrencyLabel.Text = "Enemy Chips: "..intValues.BChips.Value
	elseif localPlayer.Team == Teams.B then
		enemyCurrencyLabel.Text = "Enemy Chips: "..intValues.AChips.Value
	end
	
end)

events.updateCurrencyGUI.OnClientEvent:Connect(function()

	local intValues = repSto:WaitForChild("intValues")

	if localPlayer.Team == Teams.A then
		enemyCurrencyLabel.Text = "Enemy Chips: "..intValues.BChips.Value
	elseif localPlayer.Team == Teams.B then
		enemyCurrencyLabel.Text = "Enemy Chips: "..intValues.AChips.Value
	end
	
end)