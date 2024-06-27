local Settings = {}
Settings.FireTeams = game.Teams:GetChildren()
Settings.MinFirefighters = 1
Settings.MinLarge = 1
Settings.BuildingLocations = {game.Workspace}
Settings.BrushFireLocations = {game.Workspace}
Settings.WaitTimes = {ResourceSaver = 60,CheckFireTime = 10,BetweenTimes = {Min = 5,Max = 25,}}
Settings.EnableAPI = true
Settings.WaitTimes.BetweenTimes.Multiplier = 60
Settings.Debug = true
Settings.Version = "2.0.1"
return Settings