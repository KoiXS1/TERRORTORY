
local gameManagement = require(game:getService("ReplicatedStorage").gameManagement)
local mapGenerators = require(game:GetService("ReplicatedStorage").mapGenerators)
local Teams = game:GetService("Teams")
local Players = game:GetService("Players")

script.Parent.ClickDetector.MouseClick:Connect(function(plr)
	
	if (#Players:GetPlayers() == 2) then
		--Destroys the entire selection area to prevent duplication in map generation.
		local selectionArea = game.Workspace["Selection Area"]
		for i, v in pairs (selectionArea:GetChildren()) do
			v:Destroy()
		end

		local APlayerName
		local BPlayerName = "PlaceHolderName"

		for i, v in pairs(Teams.A:GetPlayers()) do
			APlayerName = v.Name
		end

		for i,v in pairs (Players:GetPlayers()) do
			v:LoadCharacter()
		end

		game.Workspace.Baseplate.Transparency = 1
		game.Workspace.Baseplate.CanCollide = false
		gameManagement.startGame(APlayerName, BPlayerName , "theRing")
		mapGenerators.generateDecor("The Ring")
		mapGenerators.setAtmosphere("Foliage")
	else
		game.ReplicatedStorage.Events.warning:FireClient(plr, "Not enough players to start.")
	end
	
end)
