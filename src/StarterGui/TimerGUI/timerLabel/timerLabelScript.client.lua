local timerLabel = script.Parent

local repSto = game:GetService("ReplicatedStorage")
local Events = repSto.Events
local intValues = repSto.intValues

local updateTimerThread

Events.mapChosen.OnClientEvent:Connect(function()
	
	timerLabel.Visible = true
	
	--Start timer.
	local function updateTimer() 
		
		while (true) do
			local seconds = intValues.secsSinceStart.Value
			local secondLabel = seconds % 60 
			local minuteLabel = math.floor(seconds / 60)
			
			if secondLabel < 10 then
				secondLabel = "0"..secondLabel
			end
			
			if minuteLabel < 10 then
				minuteLabel = "0"..minuteLabel
			end
			
			timerLabel.Text = minuteLabel..":"..secondLabel
			
			task.wait(1)
			intValues.secsSinceStart.Value = intValues.secsSinceStart.Value + 1			
		end
		
	end
	
	updateTimerThread = coroutine.create(updateTimer)
	coroutine.resume(updateTimerThread)
	
end)

Events.endGame.OnClientEvent:Connect(function()
	
	print("ENDGAME")
	coroutine.close(updateTimerThread)
	
end)


	
