local currencyLabel = script.Parent
local Teams = game:GetService("Teams")

local RepSto = game:GetService("ReplicatedStorage")

-- Shows the currency text upon the game's start.
local mapChosen = RepSto.Events.mapChosen
mapChosen.OnClientEvent:Connect(function()
	
	--Makes the label visible upon map loading.
	currencyLabel.Active = true
	currencyLabel.Visible = true
	
	local intValues = RepSto.intValues
	
	--Retrieves the client player's side.
	local playerTeam = game:GetService("Players").LocalPlayer.Team

	--Determines the text that will be shown on screen in regards to currency:
	if playerTeam == Teams.A then
		currencyLabel.Text = "Chips: "..intValues.AChips.Value
	elseif playerTeam == Teams.B then
		currencyLabel.Text = "Chips: "..intValues.BChips.Value
	end
	
	
end)

-- Updates the currency text after every build decision's end.
local buildDecisionEnd = RepSto.Events.buildDecisionEnd
buildDecisionEnd.OnClientEvent:Connect(function()
	local intValues = RepSto.intValues

	--Retrieves the client player's side.
	local playerTeam = game:GetService("Players").LocalPlayer.Team

	--Determines the text that will be shown on screen in regards to currency:
	if playerTeam == Teams.A then
		currencyLabel.Text = "Chips: "..intValues.AChips.Value
	elseif playerTeam == Teams.B then
		currencyLabel.Text = "Chips: "..intValues.BChips.Value
	end
end)

-- Updates the currency text after every troop decision's end
local troopDecisionEnd = RepSto.Events.troopDecisionEnd
troopDecisionEnd.OnClientEvent:Connect(function()
	local intValues = RepSto.intValues

	--Retrieves the client player's side.
	local playerTeam = game:GetService("Players").LocalPlayer.Team

	--Determines the text that will be shown on screen in regards to currency:
	if playerTeam == Teams.A then
		currencyLabel.Text = "Chips: "..intValues.AChips.Value
	elseif playerTeam == Teams.B then
		currencyLabel.Text = "Chips: "..intValues.BChips.Value
	end
end)

local endFullTurn = RepSto.Events.endFullTurn
endFullTurn.OnClientEvent:Connect(function()
	local intValues = RepSto.intValues

	--Retrieves the client player's side.
	local playerTeam = game:GetService("Players").LocalPlayer.Team

	--Determines the text that will be shown on screen in regards to currency:
	if playerTeam == Teams.A then
		currencyLabel.Text = "Chips: "..intValues.AChips.Value
	elseif playerTeam == Teams.B then
		currencyLabel.Text = "Chips: "..intValues.BChips.Value
	end
end)

local updateCurrencyGUI = RepSto.Events.updateCurrencyGUI
updateCurrencyGUI.OnClientEvent:Connect(function()
	local intValues = RepSto.intValues

	--Retrieves the client player's side.
	local playerTeam = game:GetService("Players").LocalPlayer.Team

	--Determines the text that will be shown on screen in regards to currency:
	if playerTeam == Teams.A then
		currencyLabel.Text = "Chips: "..intValues.AChips.Value
	elseif playerTeam == Teams.B then
		currencyLabel.Text = "Chips: "..intValues.BChips.Value
	end
end)