local RulesGUI = script.Parent.Parent

local ExitButton = script.Parent

ExitButton.MouseButton1Click:Connect(function()
	ExitButton.Active = false
	ExitButton.Visible = false

	RulesGUI.Guide.Active = false
	RulesGUI.Guide.Visible = false
	
	RulesGUI.EnterGuide.Active = true
	RulesGUI.EnterGuide.Visible = true

end)