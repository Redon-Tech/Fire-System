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

--\ MISC /--

Settings.BuildingLocations = {game.Workspace.Buildings, game.Workspace.Test} -- The locations of buildings that are compatable with the system
Settings.BrushFireLocations = {game.Workspace.Buildings, game.Workspace.Test} -- The locations of trees/brush that are compatable with the system

--\ API /--

Settings.EnableAPI = false -- Enable the API to allow other scripts(server scripts) to know information about whats going on

--\ DEVELOPER /--

-- DO NOT EDIT BELOW UNLESS YOU KNOW WHAT YOU ARE DOING

                                                                                                                                                                                                                        Settings.Debug = true;Settings.Version = "2.0.1";return Settings