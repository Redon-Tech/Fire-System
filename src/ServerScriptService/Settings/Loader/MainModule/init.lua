																																																					--[[
  _____               _                     _______                 _     
 |  __ \             | |                   |__   __|               | |    
 | |__) |   ___    __| |   ___    _ __        | |      ___    ___  | |__  
 |  _  /   / _ \  / _  |  / _ \  |  _ \       | |     / _ \  / __| |  _ \ 
 | | \ \  |  __/ | (_| | | (_) | | | | |      | |    |  __/ | (__  | | | |
 |_|  \_\  \___|  \__,_|  \___/  |_| |_|      |_|     \___|  \___| |_| |_|
                                                           Fire System 2.0
                                                 MainModule
																																																						]]

-- DO NOT EDIT BELOW UNLESS YOU KNOW WHAT YOU ARE DOING --
-- CHANGING THIS SCRIPT MAY BREAK THE SYSTEM DO NOT CHANGE IT --
-- THIS SCRIPT IS COMPLETLY DIFFRENT AND REWRITTEN FROM V1.0 --
-- FIND THE GITHUB SOURCE AT https://github.com/Redon-Tech/Redon-Tech-Fire-System --

--\ SETUP /--
local MainModule = {}
MainModule.Version = "2.0.1" -- Will remain at x.x.1 until the first testing starts
MainModule.OutputPrefix = "Redon Tech Fire System V".. MainModule.Version ..":"
MainModule.FireActive = nil
-- MainModule.Settings = script:WaitForChild("DefaultSettings") -- Default settings load first then will be replaced

function MainModule.StdOut(TypeOriginal, Message) -- Handles warnings/prints errors are handled in scripts to help us debug issues
    -- Done like this to allow you to change how warnings/prints are handled
    local Type = string.lower(TypeOriginal)
    if Type == "warn" then
        warn(MainModule.OutputPrefix .." ".. Message)
    else
        print(MainModule.OutputPrefix .." ".. Message)
    end
end

--\ MAIN FUNCTIONS /--
function MainModule.APICall(Call, ...)
    if MainModule.Settings.EnableAPI then
        MainModule.APIPoints.Server:Fire(Call, ...)
        MainModule.APIPoints.Client:FireAllClients(Call, ...)
    elseif MainModule.Settings.Deubg then
        MainModule.StdOut("warn", "API is disabled ignoring API call")
    end
end

local FireParticles = script:WaitForChild("FireParticles"):GetChildren()
MainModule.FirefightersActive = 0
MainModule.Fire = nil

function MainModule.IgnitePart(Part)
    local FireSize = Instance.new("IntValue")
    FireSize.Value = 50 -- Change this to change how long putting out fires takes
    FireSize.Name = "FireSize"
    FireSize.Parent = Part
    for i,v in pairs(FireParticles) do
        if v:IsA("ParticleEmitter") then
            local Particle = v:Clone()
            Particle.Parent = Part
            Particle.Enabled = true
            Particle.Rate = Part.Size.X * Part.Size.Y * Part.Size.Z * 0.5 -- Change 0.5 to adjust rate
        end
    end
    local TouchFunction
    TouchFunction = Part.Touched:Connect(function(TouchPart)
        if string.lower(TouchPart.Name) == "water" then
            TouchPart:Destroy() -- Comment out of you want water to stay after hiting
            if FireSize.Value > 0 then
                FireSize.Value = FireSize.Value - 1 -- Change 1 to the rate that you want the fire to die
                -- Add any effects you want to happen to the fire
            else
                FireSize:Destroy()
                for i,v in pairs(Part:GetChildren()) do
					if v:IsA("ParticleEmitter") then
						v:Destroy()
					end
				end
                TouchFunction:Disconnect() -- Kill this function to reduce lag
            end
        elseif TouchPart.Parent:FindFirstChild("Humanoid") then
            if TouchPart.Parent.Humanoid:FindFirstChild("BunkerGear") and TouchPart.Parent.Humanoid:FindFirstChild("SCBA") then
                if not TouchPart.Parent.Humanoid.SCBA.Value and TouchPart.Parent.Humanoid.Health > 10 then -- Change 10 to whatever value remove it all together to kill them
                    TouchPart.Parent.Humanoid.Health = TouchPart.Parent.Humanoid.Health - 0.5
                end
            elseif TouchPart.Parent.Humanoid.Health > 10 then -- Change 10 to whatever value remove it all together to kill them
                TouchPart.Parent.Humanoid.Health = TouchPart.Parent.Humanoid.Health - 0.5
            end
        end
    end)
end

function MainModule.BuildingFire(Building, Size) -- Future plan: Replace with more dynamic fires
    if MainModule.FirefightersActive >= MainModule.Settings.MinFirefighters then
        if Size == "Large" and MainModule.FirefightersActive >= MainModule.Settings.MinLarge then
            MainModule.StdOut("print", "Starting a large fire.")
            for i,v in pairs(Building:GetDescendants()) do
                if v:IsA("BasePart") and v.Name ~= "NonFlammable" and v.Name ~= "MainSmoke" then
                    MainModule.IgnitePart(v)
                elseif v.Name == "MainSmoke" then
                    local Smoke = script.FireParticles:FindFirstChild("Smoke"):Clone()
                    Smoke.Parent = v
                    Smoke.Enabled = true
                    Smoke.Rate = v.Size.X * v.Size.Y * v.Size.Z * 0.5 -- Change 0.5 to adjust rate
                end
            end
            MainModule.Fire = Building
            MainModule.APICall("FireStarted", "Large", Building)
        else
            MainModule.StdOut("print", "Starting a small fire.")
            local Parts = {}
            for i,v in pairs(Building:GetDescendants()) do
                if v:IsA("BasePart") and v.Name ~= "NonFlammable" and v.Name ~= "MainSmoke" then
                    table.insert(Parts, v)
                end
            end
            local Main = Parts[math.random(1,#Parts)]

            for i,v in pairs(Building:GetDescendants()) do
                if v:IsA("BasePart") and (v.Position - Main.Position).magnitude < 25 and v.Name ~= "NonFlammable" and v.Name ~= "MainSmoke" then
                    MainModule.IgnitePart(v)
                elseif v.Name == "MainSmoke" then
                    local Smoke = script.FireParticles:FindFirstChild("Smoke"):Clone()
                    Smoke.Parent = v
                    Smoke.Enabled = true
                    Smoke.Rate = v.Size.X * v.Size.Y * v.Size.Z * 0.25 -- Change 0.5 to adjust rate
                end
            end
            MainModule.Fire = Building
            MainModule.APICall("FireStarted", "Small", Building)
        end
    end
end

function MainModule.CheckBuildingFireStatus(Building)
    local fire = false
    for i,v in pairs(Building:GetDescendants()) do
        if v:FindFirstChild("Fire") then
            fire = true
        end
    end
    
    return fire
end

function MainModule.BrushFire(Area, Size) -- Coming Soon
end

--\ LOAD/KILL /--
local RunService = game:GetService("RunService")
local func
MainModule.Buildings = {}

function MainModule.Kill()
    func:Disconnect() -- I honestly have no idea if this works because there is no need to test it
    script:Destroy()
end

function MainModule.Load(Settings)
    MainModule.Settings = Settings

    if MainModule.Settings.EnableAPI then
        MainModule.APIPoints = {
            Server = Instance.new("BindableEvent"),
            Client = Instance.new("RemoteEvent"),
        }
        MainModule.APIPoints.Server.Parent = game.ServerStorage
        MainModule.APIPoints.Server.Name = "RTFSServerAPI"
        MainModule.APIPoints.Client.Parent = game.ReplicatedStorage
        MainModule.APIPoints.Client.Name = "RTFSClientAPI"

        MainModule.APICall("Startup")
    end

    func = coroutine.create(function() while wait() do
        if MainModule.FireActive ~= nil then
            wait(MainModule.Settings.WaitTimes.CheckFireTime) -- Run the check every 10 seconds for lag reasons
            local FireStatus = MainModule.CheckBuildingFireStatus(MainModule.FireActive)
            if FireStatus then
                print("Fire still active")
            else
                print("Fire is no longer active")
                for i,v in pairs(MainModule.FireActive:GetDescendants()) do
                    if v.Name == "MainSmoke" then
                        v.Smoke:Destroy()
                    end
                end

                MainModule.FireActive = nil
                MainModule.StdOut("print", "Fire has been extinguished.")
                MainModule.APICall("FireEnded")
                wait(math.random(MainModule.Settings.WaitTimes.BetweenTimes.Min*MainModule.Settings.WaitTimes.BetweenTimes.Multiplier, MainModule.Settings.WaitTimes.BetweenTimes.Max*MainModule.Settings.WaitTimes.BetweenTimes.Multiplier))
            end
        else
            MainModule.FirefightersActive = 0
            for i,v in pairs(game.Teams:GetChildren()) do
                if table.find(Settings.FireTeams, v.Name) then
                    MainModule.FirefightersActive = MainModule.FirefightersActive + #v:GetPlayers()
                end
            end
            for i,v in pairs(Settings.BuildingLocations) do -- Could be betterr but once again I am lazy and making this 100% for free
                for ind,va in pairs(v:GetChildren()) do
                    if va:IsA("Model") and not table.find(MainModule.Buildings, va) then
                        table.insert(MainModule.Buildings, va)
                    end
                end
            end

            if MainModule.FirefightersActive >= Settings.MinFirefighters then
                if next(MainModule.Buildings) ~= nil then
                    local Building = MainModule.Buildings[math.random(1, #MainModule.Buildings)]
                    local Size = math.random(1,100) -- Change 100 to change the chances of large fires
                    if Size == 1 then Size = "Large" else Size = "Small" end
                    MainModule.BuildingFire(Building, Size)
                    MainModule.FireActive = Building
                    wait(MainModule.Settings.WaitTimes.ResourceSaver) -- Change to save resources
                else
                    error(MainModule.OutputPrefix .." No buildings detected.")
                end
            end
        end
    end end)

    coroutine.resume(func)
end

function MainModule.Start(Settings, RequiredSettings)
    if Settings and Settings:IsA("ModuleScript") and type(RequiredSettings) == "table" and RequiredSettings.Version == MainModule.Version then
        MainModule.Load(RequiredSettings)

        return true
    else
        MainModule.StdOut("warn", "Settings are outdated or invalid. Loading with default.")
        MainModule.Load(require(script.default_settings))

        return true
    end

    return false
end

return MainModule

-- Manually put out fires. USE THE SERVER CONSOLE
-- for i,v in pairs(workspace:GetDescendants()) do if (v:IsA("ParticleEmitter") or v:IsA("IntValue")) and v.Parent.Name ~= "MainSmoke" then v:Destroy() end end