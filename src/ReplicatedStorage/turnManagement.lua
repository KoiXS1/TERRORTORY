--Module Scripts are apparently used for holding
--code that will be continually reused for code.

-- CODE TO CONSIDER PUTTING IN MODULE SCRIPTS:
-- 1. Generating Troops
-- 2. Generating Chips per turn

local mapParts = game.ReplicatedStorage["Map Parts"]

local turnManagement = {}

-- Functions that will affect other parts of the game.

	local RepSto = game:GetService("ReplicatedStorage")
	local Events = RepSto.Events

	_G.soldierNumber = 0

	function turnManagement.troopSpawn(nodeName, troopSpawns, side, previousNode)
		
		local spawnNode = game.Workspace["currentMap"]:FindFirstChild(nodeName, true).PrimaryPart
		-- setting the second parameter of FindFirstChild allows the function to search through the 
		-- octaNodes and rectNodes folders (sets recursive function to true)

		--Checks if they are already enemy troops at the barracks (this would happen if a node is in the process
		--of being destroyed)
		local enemyPopulation = 0
		local enemySoldier1
		local enemySoldier2
	
		--For programmed soldier destruction in the case of enemies later.
		if #spawnNode["Troops"]:GetChildren() >= 1 and spawnNode["Troops"]:GetChildren()[1]:GetAttribute("allegiance") ~= side then
		
			enemyPopulation = #spawnNode["Troops"]:GetChildren()
			enemySoldier1 = spawnNode["Troops"]:GetChildren()[1]
			
			if enemyPopulation > 1 then
				enemySoldier2 = spawnNode["Troops"]:GetChildren()[2]
			end
		end
	
		local spawnCenterX = spawnNode.CFrame.X
		local spawnCenterY = spawnNode.CFrame.Y
		local spawnCenterZ = spawnNode.CFrame.Z
	
		--CFrames
		local cfPlacement
		local newSoldier1
		local newSoldier2
		local luger

		for i = 1, troopSpawns, 1 do

			local newSoldier = mapParts.Soldier:Clone()
			newSoldier.Parent = spawnNode["Troops"]
			luger = newSoldier.Luger
			
			if spawnNode.Parent.Parent.Name == "octaNodes" then
			
				-- math.random generates a random double from 0 to 1. Hence, we multiply it by 360 here.
				local randomAngle = math.rad((math.random()) * 360)

				local xIncrementChange = 20*math.sin(randomAngle)
				local zIncrementChange = 20*math.cos(randomAngle)

				cfPlacement = 
					CFrame.new(spawnCenterX + xIncrementChange, spawnCenterY + 4, spawnCenterZ + zIncrementChange )

			elseif spawnNode.Parent.Parent.Name == "rectNodes"then

				local areaChooser = math.random(1,6)  -- Chooses 1 of the 6 spawn areas in the rectangular space model

				local xChange = math.random() 
				local zChange = math.random()

				local chosenSpawnArea = spawnNode.Parent:FindFirstChild("spawnArea"..areaChooser)

				local chosenAreaX = chosenSpawnArea.CFrame.X
				local chosenAreaZ = chosenSpawnArea.CFrame.Z

				cfPlacement = 
					CFrame.new(chosenAreaX + ((xChange-0.5) * 8), spawnNode.CFrame.Y + 4, chosenAreaZ + ((zChange-0.5) * 8))

				--Each spawn area is 10 by 10 studs wide.
				--To prevent troops from spawning on the edge, we don't multiply the result by 10 but by 8.


			end

			if side == "A" then
				newSoldier.Helmet.Color = Color3.new(52, 84, 209)
				newSoldier.Armor.Color = Color3.new(52, 84, 209)
				cfPlacement *= CFrame.fromEulerAngles(0, math.rad(180), 0)
				luger.PrimaryPart.PivotOffset *= CFrame.fromEulerAngles(0,math.rad(180),0) 
			else
				newSoldier.Helmet.Color = Color3.new(255, 186, 8)
				newSoldier.Armor.Color = Color3.new(255, 186, 8)
			end
			
			newSoldier:SetPrimaryPartCFrame(cfPlacement)

			_G.soldierNumber = _G.soldierNumber + 1
			newSoldier.Name = "Soldier".._G.soldierNumber

			newSoldier:SetAttribute(
				"allegiance",
				side

			) 

			newSoldier:SetAttribute(
				"currentNode",
				nodeName
			) 

			newSoldier:SetAttribute(
				"previousNode",
				previousNode
			) 

			newSoldier:SetAttribute(
				"soldierID",
				_G.soldierNumber
			)
		
			if i == 1 then
				newSoldier1 = newSoldier
			elseif i == 2 then
				newSoldier2 = newSoldier
			end

		end

		spawnNode.Parent:SetAttribute(
			"troopPopulation",
			spawnNode.Parent:GetAttribute("troopPopulation") + 1
		)
	
		local buildingGenerator = require(RepSto.buildingGenerator)
	
		--A variable used to disable movements in the case of a fight. (IN THE CASE OF A FIGHT.)
		local disabledPlayer

		if side == "A" then
			disabledPlayer = game:GetService("Teams").A:GetPlayers()[1]
		elseif side == "B" then
			disabledPlayer = game:GetService("Teams").B:GetPlayers()[1]
		end
	
		--Priority attacking system (Turret Check --> Enemy Check --> Safe)
		if  --Turret check
			#spawnNode["Buildings"]:GetChildren() > 0 and 
			spawnNode["Buildings"]:GetChildren()[1].Name == "Turret" and 
			spawnNode["Buildings"]:GetChildren()[1]:GetAttribute("sideOwner") ~= side
		then
		
			local turret = spawnNode["Buildings"]:GetChildren()[1]
			local currentTurretHealth = turret:GetAttribute("Health")
			
			--Disallows the soldier to escape.
			newSoldier1.ClickDetector.MaxActivationDistance = 0
			
			--Produces flashes
			local function turretFlash ()
			
				turret.Barrel1.PointLight.Enabled = true
				turret["Turret Fire"]:Play()
				task.wait(0.05)
				turret.Barrel1.PointLight.Enabled = false
				task.wait(0.15)
				
				turret.Barrel2.PointLight.Enabled = true
				turret["Turret Fire"]:Play()
				task.wait(0.05)
				turret.Barrel2.PointLight.Enabled = false
				task.wait(0.15)
				
				turret.Barrel1.PointLight.Enabled = true
				turret["Turret Fire"]:Play()
				task.wait(0.05)
				turret.Barrel1.PointLight.Enabled = false	
				task.wait(0.15)
				
				turret.Barrel2.PointLight.Enabled = true
				turret["Turret Fire"]:Play()
				task.wait(0.05)
				turret.Barrel2.PointLight.Enabled = false
				task.wait(0.15)
				
				turret.Barrel1.PointLight.Enabled = true
				turret["Turret Fire"]:Play()
				task.wait(0.05)
				turret.Barrel1.PointLight.Enabled = false
				
			end
			
			local turretFlashThread = coroutine.create(turretFlash)
			coroutine.resume(turretFlashThread)

			Events.temporaryDisableInteraction:FireClient(disabledPlayer, 1.75)
			task.wait(1.75)
			
			--Reduces health of the turret.
			turret:setAttribute("Health", currentTurretHealth - 1)

			--The soldier dies.
			buildingGenerator.tombstoneBuild(newSoldier1.Armor.CFrame, newSoldier1:GetAttribute("allegiance"))
			newSoldier1:Destroy()

			if turret:GetAttribute("Health") == 0 then
				turret:Destroy()
			else
				turret.PrimaryPart.turretHealthIndicator.healthLabel.Text = turret:GetAttribute("Health")
			end
		
		elseif enemyPopulation >= 1 then  -- Enemy check
			
			--Gun positioning
			local gunAngle1 = -(math.atan(newSoldier1.Head.CFrame:ToObjectSpace(enemySoldier1.Head.CFrame).Z / newSoldier1.Head.CFrame:ToObjectSpace(enemySoldier1.Head.CFrame).X))
			
			--This fixes an absurd bug
			local correctionAddon = 0
			if (newSoldier1.Head.CFrame.X > enemySoldier1.Head.CFrame.X) then 
				correctionAddon = math.pi
			end
			
			
			newSoldier1.Luger:SetPrimaryPartCFrame(
				CFrame.new(
					newSoldier1.Armor.Position.X + (0.8 * math.sin(gunAngle1 + (math.pi/2) + correctionAddon)),
					newSoldier1.Armor.Position.Y + 0.75,
					newSoldier1.Armor.Position.Z + (0.8 * math.cos(gunAngle1 + (math.pi/2) + correctionAddon))
				) 
					*
				CFrame.fromEulerAngles(
					0,
					gunAngle1 + math.pi + correctionAddon,
					0
				)
			)	
			enemySoldier1.Luger:SetPrimaryPartCFrame(
				CFrame.new(
					enemySoldier1.Armor.Position.X + (0.8 * math.sin(gunAngle1 + (3 * math.pi/2) + correctionAddon)),
					enemySoldier1.Armor.Position.Y + 0.75,
					enemySoldier1.Armor.Position.Z + (0.8 * math.cos(gunAngle1 + (3 * math.pi/2) + correctionAddon))
				) 
					*
				CFrame.fromEulerAngles(
					0,
					gunAngle1 + correctionAddon,
					0
				)
			)
		
			--Gun flashes and shots
			local function flashRepeat() 
					
				newSoldier1.Luger["Firing Hole"].Flash.Enabled = true
				newSoldier1.Sounds["Luger Fire"]:Play()
				task.wait(0.1)
				newSoldier1.Luger["Firing Hole"].Flash.Enabled = false
					
				task.wait(0.07)
					
				enemySoldier1.Luger["Firing Hole"].Flash.Enabled = true
				enemySoldier1.Sounds["Luger Fire"]:Play()
				task.wait(0.1)
				enemySoldier1.Luger["Firing Hole"].Flash.Enabled = false

				task.wait(0.06)
					
				newSoldier1.Luger["Firing Hole"].Flash.Enabled = true
				newSoldier1.Sounds["Luger Fire"]:Play()
				task.wait(0.1)
				newSoldier1.Luger["Firing Hole"].Flash.Enabled = false

				task.wait(0.09)		

				newSoldier1.Luger["Firing Hole"].Flash.Enabled = true
				newSoldier1.Sounds["Luger Fire"]:Play()
				task.wait(0.1)
				newSoldier1.Luger["Firing Hole"].Flash.Enabled = false

				task.wait(0.12)
					
				enemySoldier1.Luger["Firing Hole"].Flash.Enabled = true
				enemySoldier1.Sounds["Luger Fire"]:Play()
				task.wait(0.1)
				enemySoldier1.Luger["Firing Hole"].Flash.Enabled = false
					
			end	
			local flashThread = coroutine.create(flashRepeat)
			coroutine.resume(flashThread)

			--To make sure the player can't make a soldier "escape"
			enemySoldier1.ClickDetector.MaxActivationDistance = 0
			newSoldier1.ClickDetector.MaxActivationDistance = 0	

			if enemyPopulation >= 2 and troopSpawns == 2 then
						
				local gunAngle2 = -(math.atan(newSoldier2.Head.CFrame:ToObjectSpace(enemySoldier2.Head.CFrame).Z / newSoldier2.Head.CFrame:ToObjectSpace(enemySoldier2.Head.CFrame).X))

				newSoldier2.Luger:SetPrimaryPartCFrame(
					CFrame.new(
						newSoldier2.Armor.Position.X + (0.8 * math.sin(gunAngle2 + (math.pi/2))),
						newSoldier2.Armor.Position.Y + 0.75,
						newSoldier2.Armor.Position.Z + (0.8 * math.cos(gunAngle2 + (math.pi/2)))
					) 
						*
					CFrame.fromEulerAngles(
						0,
						gunAngle2 + math.pi,
						0
					)
				)

				enemySoldier2.Luger:SetPrimaryPartCFrame(
					CFrame.new(
						enemySoldier2.Armor.Position.X + (0.8 * math.sin(gunAngle2 + (3 * math.pi/2))),
						enemySoldier2.Armor.Position.Y + 0.75,
						enemySoldier2.Armor.Position.Z + (0.8 * math.cos(gunAngle2 + (3 * math.pi/2)))
					) 
						*
					CFrame.fromEulerAngles(
						0,
						gunAngle2,
						0
					)
				)
				
				local function flashRepeat2() 
					
					task.wait(0.25)

					newSoldier2.Luger["Firing Hole"].Flash.Enabled = true
					newSoldier2.Sounds["Luger Fire"]:Play()
					task.wait(0.1)
					newSoldier2.Luger["Firing Hole"].Flash.Enabled = false

					task.wait(0.07)

					enemySoldier2.Luger["Firing Hole"].Flash.Enabled = true
					enemySoldier2.Sounds["Luger Fire"]:Play()
					task.wait(0.1)
					enemySoldier1.Luger["Firing Hole"].Flash.Enabled = false

					task.wait(0.06)

					newSoldier2.Luger["Firing Hole"].Flash.Enabled = true
					newSoldier2.Sounds["Luger Fire"]:Play()
					task.wait(0.1)
					newSoldier1.Luger["Firing Hole"].Flash.Enabled = false

					task.wait(0.09)		

					newSoldier2.Luger["Firing Hole"].Flash.Enabled = true
					newSoldier2.Sounds["Luger Fire"]:Play()
					task.wait(0.1)
					newSoldier2.Luger["Firing Hole"].Flash.Enabled = false

					task.wait(0.12)

					enemySoldier2.Luger["Firing Hole"].Flash.Enabled = true
					enemySoldier2.Sounds["Luger Fire"]:Play()
					task.wait(0.1)
					enemySoldier2.Luger["Firing Hole"].Flash.Enabled = false

				end

				local flashThread2 = coroutine.create(flashRepeat2)
				coroutine.resume(flashThread2)

				enemySoldier2.ClickDetector.MaxActivationDistance = 0
				newSoldier2.ClickDetector.MaxActivationDistance = 0
				
			end
	
			Events.temporaryDisableInteraction:FireClient(disabledPlayer, 1.3)
			task.wait(1.3)

			--Creates the tombstones
			local thisAllegiance = newSoldier1:GetAttribute("allegiance")
			local enemyAllegiance = enemySoldier1:GetAttribute("allegiance")

			buildingGenerator.tombstoneBuild(enemySoldier1.Armor.CFrame, enemyAllegiance)
			buildingGenerator.tombstoneBuild(newSoldier1.Armor.CFrame, thisAllegiance)
			
			enemySoldier1:Destroy()
			newSoldier1:Destroy()

			if enemyPopulation >= 2 and troopSpawns == 2 then
				buildingGenerator.tombstoneBuild(enemySoldier2.Armor.CFrame, enemyAllegiance)
				buildingGenerator.tombstoneBuild(newSoldier2.Armor.CFrame, thisAllegiance)
				enemySoldier2:Destroy()
				newSoldier2:Destroy()
			end

			--Checks for the color of the node.
			if #spawnNode["Troops"]:GetChildren() > 0 then
				local localAllegiance = spawnNode["Troops"]:GetChildren()[1]:GetAttribute("allegiance")

				if localAllegiance == "A" then
					spawnNode.Parent:SetAttribute("lastTeamColor", Color3.fromRGB(255, 186, 8))
					spawnNode.Color = spawnNode.Parent:GetAttribute("lastTeamColor")
				elseif localAllegiance == "B" then
					spawnNode.Parent:SetAttribute("lastTeamColor", Color3.fromRGB(52, 84, 209))
					spawnNode.Color = spawnNode.Parent:GetAttribute("lastTeamColor")
				end

			end

		else -- The soldier survives.
		
			--Determines last color of the node.
			local sideOccupied = newSoldier1:GetAttribute("allegiance")
			if sideOccupied == "A" then
				spawnNode.Parent:SetAttribute("lastTeamColor", Color3.fromRGB(255, 186, 8))
				spawnNode.Color = spawnNode.Parent:GetAttribute("lastTeamColor")
			elseif sideOccupied == "B" then
				spawnNode.Parent:SetAttribute("lastTeamColor", Color3.fromRGB(52, 84, 209))
				spawnNode.Color = spawnNode.Parent:GetAttribute("lastTeamColor")
			end
			
			if (nodeName ~= previousNode) then         --indicative of movement
				newSoldier1.Sounds.soldierSteps:Play()
			else                                       --indicative of a spawn
				
				--Deactivates click detectors for B-side soldiers since upon spawning, it will be side A's turn
				--and therefore, B cannot move.
				if (side == "B") then
					newSoldier1.ClickDetector.MaxActivationDistance = 0
					if (troopSpawns == 2) then
						newSoldier2.ClickDetector.MaxActivationDistance = 0
					end		
				end
				
			end
		
		end
	
	end

--------------------- CURRENCY SYSTEM ---------------------------------------------------

	function turnManagement.turnPayments() -- THIS IS UNTESTED.
		
		local factoryProduction = 3
		
		local AChips = RepSto.intValues.AChips
		local BChips = RepSto.intValues.BChips

		local octaNodes = game.Workspace.currentMap.octaNodes

		--Retrieves all the octagonal nodes present in the map
		for i, v in pairs (octaNodes:GetChildren()) do

			if v:GetAttribute("sideWithBuildings") == "A"  then

				AChips.Value = AChips.Value + (factoryProduction * v:GetAttribute("factoryNumber"))

			elseif v:GetAttribute("sideWithBuildings") == "B" then

				BChips.Value = BChips.Value + (factoryProduction * v:GetAttribute("factoryNumber"))

			end
		end

	end

	--[[
	Function that switches turns and includes
	functionality of barracks and factories when B side ends.
	]]--
	Events.endTurn.OnServerEvent:Connect(function(playerEnd)
		
		local Teams = game:GetService("Teams")
		local ASidePlayer = Teams.A:GetPlayers()[1]
		local BSidePlayer = Teams.B:GetPlayers()[1]
		
		local gameManagement = require(RepSto.gameManagement)
		gameManagement.scanDestruction()
		
		if playerEnd.Team == Teams.A then
			
			Events.startTurn:FireClient(BSidePlayer)
			Events.updateTurnLabel:FireAllClients(" - B")
			
		elseif playerEnd.Team == Teams.B then
			
			-- Hands out the payments & implements the factory's functionality.
			turnManagement.turnPayments()
			
			--Generates a troop for each barrack when the next turn is an even number.
			if RepSto:WaitForChild("intValues").turnNumber.Value % 2 == 1 then

				local currentMap = game.Workspace.currentMap
			
				for i,v in pairs (currentMap.octaNodes:GetChildren()) do
				
					local barrackNumber = v:GetAttribute("barrackNumber")
				
					if barrackNumber > 0 then
					
						if v:GetAttribute("sideWithBuildings") == "A" then
							turnManagement.troopSpawn(v.Name, barrackNumber, "A", v.Name)
						elseif v:GetAttribute("sideWithBuildings") == "B" then
							turnManagement.troopSpawn(v.Name, barrackNumber, "B", v.Name)
						end
					
						gameManagement.verifyOccupancies()
						gameManagement.verifyTroopPopulations()
					
					end
				
				end
			end
		
			--Updates the value of chips from turnPayments.
			RepSto:WaitForChild("intValues").turnNumber.Value += 1 
			Events.endFullTurn:FireAllClients()
		
			Events.updateTurnLabel:FireAllClients(" - A")
			
			--Passes the turn to the other player.
			Events.startTurn:FireClient(ASidePlayer)
		
		end
		
	end)

return turnManagement
