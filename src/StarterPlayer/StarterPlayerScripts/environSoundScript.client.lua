--Scripts that creates a rainy environment.
local RepSto = game:GetService("ReplicatedStorage")
globalSounds = RepSto["Global Sounds"]

local Events = game:GetService("ReplicatedStorage").Events

local function starterAmbiencePlay()
	while (true) do
		globalSounds.starterAmbience:Play()
		task.wait(64.2)
	end
end

local starterAudioThread = coroutine.create(starterAmbiencePlay)
coroutine.resume(starterAudioThread)

Events.mapChosen.OnClientEvent:Connect(function()
	
	coroutine.close(starterAudioThread)
	globalSounds.starterAmbience:Stop()
	
	--Creates the ambience of the rain.
	globalSounds.Rain:Play()

	--Create the ambience of the wind
	--Should play every 60 - 90 seconds
	local function windPlay()
		while (true) do
			globalSounds.Wind:Play()

			repeat
				globalSounds.Wind.Volume = globalSounds.Wind.Volume - 0.005
				task.wait(9.02/100)
			until globalSounds.Wind.Volume <= 0
			globalSounds.Wind.Volume = 0.5

			local waitTime = 75 - math.random(0,30)
			task.wait(waitTime)
		end
	end

	local windThread = coroutine.create(windPlay)
	coroutine.resume(windThread)

	--Create the ambience of raven caws
	--Should play ever 180 to 300 seconds
	local function ravenPlay()
		while true do
			globalSounds.Ravens:Play()

			repeat
				globalSounds.Ravens.Volume = globalSounds.Ravens.Volume - 0.005
				task.wait(5.4/100)
			until globalSounds.Ravens.Volume <= 0

			globalSounds.Ravens:Stop()
			globalSounds.Ravens.Volume = 0.5

			local waitTime = 300 - math.random(0,120)
			task.wait(waitTime)
		end
	end

	local ravenThread = coroutine.create(ravenPlay)
	coroutine.resume(ravenThread)
	
end)

-- RepSto.Events.endGame.OnClientEvent:Connect(function()
--	 RepSto["Global Sounds"].Rain:Stop()
-- end)

--Creates the particle effects of the rain.
--local rainLoop = true

--[[
RepSto.Events.endGame.OnClientEvent:Connect(function()
	rainLoop = false
end)

local function createRain()
	while rainLoop do
		
		
		local randomX = math.random(-500,500)
		local randomZ = Random.new(-500,500)

		local rainOrigin = Vector3.new(randomX, 100, randomZ)
		local rainDestination = Vector3.new(randomX + 17, 0, randomZ)
		
		
		
	end
end
]]--