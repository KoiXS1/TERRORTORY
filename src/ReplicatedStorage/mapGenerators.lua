local mapGenerators = {}

-- For accessing the directory for parts more simply.
local rep = game.ReplicatedStorage
local mapParts = rep["Map Parts"]

-- Actual map objects
local octaNode = mapParts["Octagonal Space w/ Divider"]
local rectNode = mapParts["Rectangular Space"]

-- Constructs the map, depending on the mapName given. 
	function mapGenerators.constructOpenField()

		--[[
		Visualization of forest map array.
	
		mapArray =
		{
			{0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,1,1,1,1,1,0,0,0},
			{0,0,0,1,0,1,0,1,0,0,0},
			{0,1,1,1,1,1,1,1,1,1,0},
			{0,0,0,1,0,1,0,1,0,0,0},
			{0,0,0,1,1,1,1,1,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0},
		}
		]]--
			
		--OCTAGONAL NODE GENERATION
		for i = 1, 11, 1 do 

			local octaCopy = octaNode:Clone() 
			octaCopy.Parent = game.Workspace["currentMap"].octaNodes
			octaCopy.Name = "Octa"..tostring(i)                  --Concatenates the 2 elements into a singular string.
		
			local octaLocation
		
			if i <= 3 then  -- Generates the top row of octagonal nodes.
				
				octaLocation = Vector3.new(90*(i-1),0,0)   -- Vector3 is a way to give an X, Y, and Z coordinate.

				octaCopy:SetAttribute(
					"movementArrayX",
					2
				)
			
				octaCopy:SetAttribute(
					"movementArrayZ",
					4 + 2*(i-1)
				)
				 --[[
				  Generates the node so that each node is 90 studs apart.
				  CONFIGURATION AFTER ROW IS DONE
				 
				         Node 1       Node 2        Node 3
				 
				 --]]

			elseif  i <= 8 then -- Generates the middle row of octagonal nodes.
				
				octaLocation = Vector3.new(-90 + 90*(i-4) , 0 ,90)

				octaCopy:SetAttribute(
					"movementArrayX",
					4
				)
			
				octaCopy:SetAttribute(
					"movementArrayZ",
					2 + 2*(i-4)
				)
			
				--[[
				  Generates the node so that each node is 90 studs apart.
				   CONFIGURATION AFTER ROW IS DONE
				  
				       			  Node 1       Node 2        Node 3
				       			  
				        Node 4    Node 5       Node 6        Node 7       Node 8
				 
				 --]]

			else -- Generates the bottom row of octagonal nodes.
				
				octaLocation = Vector3.new(90*(i-9), 0, 180)

				octaCopy:SetAttribute(
					"movementArrayX",
					6
				)

				octaCopy:SetAttribute(
					"movementArrayZ",
					4 + 2*(i-9)
				)
				--[[
				  Generates the node so that each node is 90 studs apart.
				  CONFIGURATION AFTER ROW IS DONE
				  
				       			  Node 1       Node 2        Node 3
				       			  
				        Node 4    Node 5       Node 6        Node 7       Node 8
				        
				        			  Node 9       Node 10       Node 11
				 
				 --]]

			end
		
			octaCopy:MoveTo(octaLocation)
		
		end

		--RECTANGULAR NODE GENERATION
		for i = 1, 14, 1 do
			local rectCopy = rectNode:Clone()
			rectCopy.Parent = game.Workspace["currentMap"].rectNodes
			rectCopy.Name = "Rect"..tostring(i)
		
			local newCF
		
			if i <= 2 then
				newCF = 
					CFrame.new (45 + 90*(i-1), 0.25, 0) * 
					CFrame.fromEulerAngles(0, 0, 0)
			
				rectCopy:SetAttribute(
					"movementArrayX",
					2
				)

				rectCopy:SetAttribute(
					"movementArrayZ",
					5 + 2*(i-1)
				)
			
			elseif i <= 5 then
				newCF = 
					CFrame.new (90*(i-3), 0.4, 45) * 
					CFrame.fromEulerAngles(0, math.rad(90), 0)
			
				rectCopy:SetAttribute(
					"movementArrayX",
					3
				)

				rectCopy:SetAttribute(
					"movementArrayZ",
					4 + 2*(i-3)
				)
			
				
			elseif i <= 9 then
				newCF = 
					CFrame.new (-45 + 90*(i-6), 0.4, 90) * 
					CFrame.fromEulerAngles(0, 0, 0)
			
				rectCopy:SetAttribute(
					"movementArrayX",
					4
				)

				rectCopy:SetAttribute(
					"movementArrayZ",
					3 + 2*(i-6)
				)
			
			
			elseif i <= 12 then
				newCF = 
					CFrame.new (90*(i-10), 0.4, 135) * 
					CFrame.fromEulerAngles(0, math.rad(90), 0)
			
				rectCopy:SetAttribute(
					"movementArrayX",
					5
				)

				rectCopy:SetAttribute(
					"movementArrayZ",
					4 + 2*(i-10)
				)
			
			else
				newCF = 
					CFrame.new (45+ 90*(i-13), 0.4, 180) * 
					CFrame.fromEulerAngles(0, 0, 0)
			
				rectCopy:SetAttribute(
					"movementArrayX",
					6
				)

				rectCopy:SetAttribute(
					"movementArrayZ",
					5 + 2*(i-13)
				)
			
			end
		
			rectCopy:SetPrimaryPartCFrame(newCF)
		
		end
	
	end

	function mapGenerators.constructCenterGame()
		mapGenerators.constructOpenField()
	
		--Allows time for the map to load
		local rectNodes = game.Workspace.currentMap.rectNodes 
		rectNodes:WaitForChild("Rect7"):Destroy()
		rectNodes:WaitForChild("Rect8"):Destroy()
	
	end

	function mapGenerators.constructTheRing()
		mapGenerators.constructCenterGame()
	
		local rectNodes = game.Workspace.currentMap.rectNodes
		rectNodes:WaitForChild("Rect4"):Destroy()
		rectNodes:WaitForChild("Rect11"):Destroy()
	
		local octaNodes = game.Workspace.currentMap.octaNodes
		octaNodes:WaitForChild("Octa6"):Destroy()
	end
	
-- Constructs the decor for the map.
	function mapGenerators.generateDecor(mapSetup) 
		
		for i,v in pairs (workspace.Decor["Edge Slopes"]:GetChildren()) do
			
			if mapSetup == "The Ring" then
				
				for j,w in pairs (v:GetChildren()) do
					
					if w.Name == "The Ring" then
						
						for k,x in pairs (w:GetChildren()) do
							print(x.Name)
							x.CanCollide = true
							x.Transparency = 0
						end

					end
					
				end
				
			elseif mapSetup == "Center Game" then 
				
				for j,w in pairs (v:GetChildren()) do
					
					if w.Name == "The Ring" or w.Name == "Center Game" then

						for k,x in pairs (w:GetChildren()) do
							x.CanCollide = true
							x.Transparency = 0
						end

					end					
						
				end
				
			elseif mapSetup == "Open Field" then 
				
				for j,w in pairs (v:GetChildren()) do

					if w.Name == "The Ring" or w.Name == "Center Game" or w.Name == "Open Field" then

						for k,x in pairs (w:GetChildren()) do
							x.CanCollide = true
							x.Transparency = 0
						end

					end					

				end
				
			end
 				
		end
		
		for i,v in pairs (workspace.Decor.Boundaries:GetChildren()) do
			v.CanCollide = true
		end
		
		for i,v in pairs (workspace.Decor.Rocks:GetChildren()) do
			
			v.CanCollide = true
			v.Transparency = 0
			
		end
		
		for i,v in pairs (workspace.Decor.Structures:GetChildren()) do
			
			for j,w in pairs (v:GetChildren()) do
				w.CanCollide = true
				w.Transparency = 0
			end
			
		end
	
		for i,v in pairs (workspace.Decor["Sand Bags"]:GetChildren()) do

			for j,w in pairs (v:GetChildren()) do
				w.CanCollide = true
				w.Transparency = 0
			end

		end

		for i,v in pairs (workspace.Decor["Stone Linings"]:GetChildren()) do
				
			if mapSetup == "The Ring" then
				
				if v.Name == "The Ring" then
					
					for j,w in pairs (v:GetChildren()) do

						for k,x in pairs (w:GetChildren()) do
							x.CanCollide = true
							x.Transparency = 0
						end

					end
					
				end

			elseif mapSetup == "Center Game" then 
				
				if v.Name == "Center Game" or v.Name == "The Ring" then
					
					for j,w in pairs (v:GetChildren()) do

						for k,x in pairs (w:GetChildren()) do
							x.CanCollide = true
							x.Transparency = 0
						end

					end
				
				end

			elseif mapSetup == "Open Field" then
					
				if  v.Name == "Center Game" or v.Name == "The Ring" or v.Name == "Open Field" then
					
					for j,w in pairs (v:GetChildren()) do

						for k,x in pairs (w:GetChildren()) do
							x.CanCollide = true
							x.Transparency = 0
						end

					end
					
				end

			end

		end
		
		for i,v in pairs (workspace.Decor.Trees:GetChildren()) do
			
			if mapSetup == "The Ring" then
				
				if v.Name == "Open Field" or v.Name == "Center Game" or v.Name == "The Ring" then

					for j,w in pairs (v:GetChildren()) do

						for k,x in pairs (w:GetChildren()) do
							x.CanCollide = true
							x.Transparency = 0
						end

					end

				end

			elseif mapSetup == "Center Game" then 
				
				if v.Name == "Open Field" or v.Name == "Center Game" then

					for j,w in pairs (v:GetChildren()) do
						
						for k,x in pairs (w:GetChildren()) do
							x.CanCollide = true
							x.Transparency = 0
						end

					end

				end

			elseif mapSetup == "Open Field" then 
				
				if v.Name == "Open Field" then

					for j,w in pairs (v:GetChildren()) do

						for k,x in pairs (w:GetChildren()) do
							x.CanCollide = true
							x.Transparency = 0
						end

					end

				end

			end
			
			
		end
		
		workspace.Decor["Forest Floor"].Transparency = 0
		workspace.Decor["Rain Part"].Rain.Enabled = true
		
	end
	
	function mapGenerators.setAtmosphere(mapSetup)
		local Lighting = game.Lighting
		
		--Destroys the selection area's atmosphere.
		Lighting.lobbyAtmo:Destroy()
		Lighting.lobbySky:Destroy()
		Lighting.lobbyBlur:Destroy()
		Lighting.lobbyColor:Destroy()
		
		--Add the atmosphere for the map.
		for i,v in pairs (Lighting:FindFirstChild(mapSetup):GetChildren()) do
			local atmosComponent = v:Clone()
			atmosComponent.Parent = Lighting
		end
	end
	

return mapGenerators
