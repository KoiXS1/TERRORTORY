local gameManagement = require(game:getService("ReplicatedStorage").gameManagement)
local thisSoldier = script.Parent

local troopDecisionStart = game.ReplicatedStorage.Events.troopDecisionStart

thisSoldier.ClickDetector.MouseClick:Connect(function(player)
	
	local Teams = game:GetService("Teams")
	local intValues = game:WaitForChild("ReplicatedStorage").intValues
	
	if 
		
		(thisSoldier:GetAttribute("allegiance") == "A" and player.Team == Teams.A and intValues.AChips.Value >= 1) 
			or 
		(thisSoldier:GetAttribute("allegiance") == "B" and player.Team == Teams.B and intValues.BChips.Value >= 1)
		
	then
		
		print("Allegiance: "..thisSoldier:GetAttribute("allegiance"))
		print("Player Team: "..player.Team)
		print("A Chip Value: ".. intValues.AChips.Value.." B Chip Value: "..intValues.BChips.Value)
		
		local soldierNodeName = thisSoldier:GetAttribute("currentNode")
		print("Verified side.")
		
		--Event management is located in StarterPlayerScripts.soldierSelect
		troopDecisionStart:FireClient(player, thisSoldier, soldierNodeName)
		
	end

end)


