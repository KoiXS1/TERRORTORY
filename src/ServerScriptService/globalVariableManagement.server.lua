local Events = game.ReplicatedStorage.Events

Events.factoryBuild.OnServerEvent:Connect(function()
	_G.decisionType = "buildFactory"
end)

Events.barracksBuild.OnServerEvent:Connect(function()
	_G.decisionType = "buildBarracks"
end)

Events.turretBuild.OnServerEvent:Connect(function()
	_G.decisionType = "buildTurret"
end)

Events.buildDecisionEnd.OnServerEvent:Connect(function()
	_G.decisionType = ""
end)

Events.troopDecisionEnd.OnServerEvent:Connect(function()
	_G.decisionType = ""
end)