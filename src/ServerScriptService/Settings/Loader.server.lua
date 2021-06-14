																																																					--[[
  _____               _                     _______                 _     
 |  __ \             | |                   |__   __|               | |    
 | |__) |   ___    __| |   ___    _ __        | |      ___    ___  | |__  
 |  _  /   / _ \  / _  |  / _ \  |  _ \       | |     / _ \  / __| |  _ \ 
 | | \ \  |  __/ | (_| | | (_) | | | | |      | |    |  __/ | (__  | | | |
 |_|  \_\  \___|  \__,_|  \___/  |_| |_|      |_|     \___|  \___| |_| |_|
                                                           Fire System 2.0
                                                     Loader
																																																						]]

-- DO NOT EDIT BELOW UNLESS YOU KNOW WHAT YOU ARE DOING --



-- CHANGING THIS SCRIPT MAY BREAK THE SYSTEM DO NOT CHANGE IT --



local LocalConfig = {
    DevelopmentMode = true,
    Asset = nil,
    Settings = require(script.Parent)
}

if not _G.RTFSLoaded then
    script.Parent.Parent = game.ServerScriptService

    _G.RTFS = script.Parent
    local Start = tick()
    local Module = ((LocalConfig.DevelopmentMode) and script:WaitForChild("MainModule") or LocalConfig.Asset)

    if Module(LocalConfig.Settings) then
        _G.RTFSLoaded = true
        print("Redon Tech Fire System: Loaded V".. LocalConfig.Settings.Version .." in ".. tick() - Start " seconds.")
    else
        error("Something went wrong while loading RTFS")
    end
else
    if script.Parent.Name == "Settings" then
        script.Parent:Destroy()
    end
end