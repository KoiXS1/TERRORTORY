local button = script.Parent
local ClickDetector = button.ClickDetector

ClickDetector.MouseClick:Connect(function(player)
	
	local intValues = game:WaitForChild("ReplicatedStorage").intValues
	
	intValues.AChips.Value = intValues.AChips.Value + 1000
	intValues.BChips.Value = intValues.BChips.Value + 1000
	
	local updateCurrencyGUI = game:WaitForChild("ReplicatedStorage").Events.updateCurrencyGUI
	updateCurrencyGUI:FireAllClients()
	
end)
