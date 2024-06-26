local currentMap = game.Workspace.currentMap
local Events = game:GetService("ReplicatedStorage").Events

--Event is mainly fired from: MoveScript in each soldier (seen in Replicated Storage)
-- This function "greenifies" nodes that a soldier can go into.
local troopDecisionStart = Events.troopDecisionStart
troopDecisionStart.OnClientEvent:Connect(function(thisSoldier, soldierNodeName)

	local soldierNode = currentMap:FindFirstChild(soldierNodeName, true)

	local soldierAllegiance = thisSoldier:GetAttribute("allegiance")
	
	local currentCoordinateX = soldierNode:GetAttribute("movementArrayX")
	local currentCoordinateZ = soldierNode:GetAttribute("movementArrayZ")
	
	--DETECTS AVAILABLE NODES TO GO TO.
	for i,v in pairs (currentMap.octaNodes:GetChildren()) do
		
		--Deactivates all click detector on soldiers.
		for j,w in pairs (v.PrimaryPart.Troops:GetChildren()) do

			if w:GetAttribute("allegiance") == game.Players.LocalPlayer.Team.Name  then
				w.ClickDetector.MaxActivationDistance = 0
			end

		end
		
		--"Greenifies available nodes that a troop can go to."
		local nodeX = v:GetAttribute("movementArrayX")
		local nodeZ = v:GetAttribute("movementArrayZ")
			
		if 
			(
				( -- To the west
					nodeX == currentCoordinateX - 1
							and
					nodeZ == currentCoordinateZ
				) 
					or
				( -- To the east
					nodeX == currentCoordinateX + 1
					and
					nodeZ == currentCoordinateZ	
				)
					or
				( -- To the north
					nodeX == currentCoordinateX
					and
					nodeZ == currentCoordinateZ - 1
				)
					or
				( -- To the south
					nodeX == currentCoordinateX
					and
					nodeZ == currentCoordinateZ + 1
				)
			)
		then
			v:SetAttribute("Greenified", true)
			v.PrimaryPart.Color = Color3.new(0.313725, 0.784314, 0.470588)
			v.ClickDetector.MaxActivationDistance = 500
			--Allows the user to then click on adjacent nodes that is possible to be clicked.
			--SHOULD NEVER BE SERVER SIDE BUT CLIENT SIDE.
		end		
		
	end
		
	for i,v in pairs (currentMap.rectNodes:GetChildren()) do
		
		--Reactivates all click detector on soldiers.
		for j,w in pairs (v.PrimaryPart.Troops:GetChildren()) do

			if w:GetAttribute("allegiance") == game.Players.LocalPlayer.Team.Name  then
				w.ClickDetector.MaxActivationDistance = 0
			end

		end
		
		--"Greenifies available rectangular nodes that a troop can go to."
		local nodeX = v:GetAttribute("movementArrayX")
		local nodeZ = v:GetAttribute("movementArrayZ")

		if 
			(
				( -- To the west
					nodeX == currentCoordinateX - 1
						and
					nodeZ == currentCoordinateZ
				) 
					or
				( -- To the east
					nodeX == currentCoordinateX + 1
					and
					nodeZ == currentCoordinateZ	
				)
					or
				( -- To the north
					nodeX == currentCoordinateX
					and
					nodeZ == currentCoordinateZ - 1
				)
					or
				( -- To the south
					nodeX == currentCoordinateX
					and
					nodeZ == currentCoordinateZ + 1
				)
			)
		then
			v:SetAttribute("Greenified", true)
			v.PrimaryPart.Color = Color3.new(0.129412, 0.666667, 0.164706)
			v.ClickDetector.MaxActivationDistance = 500
			--Allows the user to then click on adjacent nodes that is possible to be clicked.
		end		
	end
	
	local troopDecisionEnd = game.ReplicatedStorage.Events.troopDecisionEnd
	
	troopDecisionEnd.OnClientEvent:Wait()
	
	for i,v in pairs (currentMap.octaNodes:GetChildren()) do
		
		--Reactivates all click detector on soldiers.
		for j,w in pairs (v.PrimaryPart.Troops:GetChildren()) do
			
			if w:GetAttribute("allegiance") == game.Players.LocalPlayer.Team.Name  then
				w.ClickDetector.MaxActivationDistance = 500
			end
			
		end
		
		--Deactivates the "greenified nodes"
		if (v:GetAttribute("Greenified") == true) then
			v.PrimaryPart.Color = v:GetAttribute("lastTeamColor")
			v:SetAttribute("Greenified", false)
			v.ClickDetector.MaxActivationDistance = 0
		end
	end
	
	for i,v in pairs (currentMap.rectNodes:GetChildren()) do
		
		--Reactivates all click detector on soldiers.
		for j,w in pairs (v.PrimaryPart.Troops:GetChildren()) do

			if w:GetAttribute("allegiance") == game.Players.LocalPlayer.Team.Name  then
				w.ClickDetector.MaxActivationDistance = 500
			end

		end
		
		if (v:GetAttribute("Greenified") == true) then
			v.PrimaryPart.Color = v:GetAttribute("lastTeamColor")
			v:SetAttribute("Greenified", false)
			v.ClickDetector.MaxActivationDistance = 0
		end
	end
	
	_G.decisionType = ""
	
end)

local startTurn = Events.startTurn
startTurn.OnClientEvent:Connect(function()
	
	--Allows for all of the nodes to load in.
	wait(1)
	
	--Searches each octagonal node for its soldiers
	for i,v in pairs(currentMap.octaNodes:GetChildren()) do
		for k,w in pairs (v.PrimaryPart.Troops:GetChildren()) do
			w.ClickDetector.MaxActivationDistance = 500
		end
	end
	
	
	--Searches each rectangular node for its soldiers
	for i,v in pairs(currentMap.rectNodes:GetChildren()) do
		for k,w in pairs (v.PrimaryPart.Troops:GetChildren()) do
			w.ClickDetector.MaxActivationDistance = 500
		end
	end
	
end)