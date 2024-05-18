local warningLabel = script.Parent

local Events = game:WaitForChild("ReplicatedStorage").Events

Events.warning.OnClientEvent:Connect(function(warningText)
	
	warningLabel.Text = warningText
	warningLabel.Visible = true
	
	if warningText:sub(1,11) ~= "A Side wins" and warningText:sub(1,11) ~= "B Side wins" then
		
		task.wait(2)

		warningLabel.Visible = false
		warningLabel.Text = ""
		
	end
	
end)
