																																																					--[[
  _____               _                     _______                 _     
 |  __ \             | |                   |__   __|               | |    
 | |__) |   ___    __| |   ___    _ __        | |      ___    ___  | |__  
 |  _  /   / _ \  / _  |  / _ \  |  _ \       | |     / _ \  / __| |  _ \ 
 | | \ \  |  __/ | (_| | | (_) | | | | |      | |    |  __/ | (__  | | | |
 |_|  \_\  \___|  \__,_|  \___/  |_| |_|      |_|     \___|  \___| |_| |_|
                                                           Fire System 2.0
                                                   Settings
																																																						]]
                                                                                                                                                                                                                        local Settings = {}

--\ MANUAL FIRES /--

-- COMING SOON --

--\ TEAMS /--

Settings.FireTeams = {"test1", "test2"} -- The teams that firefighters are apart of
Settings.MinFirefighters = 1 -- How many firefighters are required(all teams combined) to start a fire
Settings.MinLarge = 1 -- How many firefighters are required(all teams combined) to start a large fire

--\ MISC /--

Settings.BuildingLocations = {game.Workspace.Buildings, game.Workspace.Test} -- The locations of buildings that are compatable with the system
Settings.BrushFireLocations = {game.Workspace.Buildings, game.Workspace.Test} -- The locations of trees/brush that are compatable with the system

Settings.WaitTimes = {
    ResourceSaver = 1, -- The amount of time from the start of the fire to wait before checking the fire status
    CheckFireTime = 1, -- The amount of time between each check of the fire status
    BetweenTimes = { -- The random time between each fire in minutes
        Min = 1,
        Max = 1,
    }
}

--\ API /--

Settings.EnableAPI = true -- Enable the API to allow other scripts to know information about whats going on

--\ DEVELOPER /--
Settings.WaitTimes.BetweenTimes.Multiplier = 60 -- This is to change the multiplier applied to the random time between fires (default is 60, turns the number into minutes)
-- DO NOT EDIT BELOW UNLESS YOU KNOW WHAT YOU ARE DOING

                                                                                                                                                                                                                        Settings.Debug = true;Settings.Version = "2.0.1";return Settings