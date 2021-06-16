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

--\ SETUP /--
local MainModule = {}
MainModule.Version = "2.0.1" -- Will remain at x.x.1 until the first testing starts
MainModule.OutputPrefix = "Redon Tech Fire System V".. MainModule.Version ..":"
MainModule.Settings = script:WaitForChild("DefaultSettings")

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
local FireParticles = script:WaitForChild("FireParticles"):GetChildren()

function MainModule.IgnitePart(Part)
    local FireSize = Instance.new("IntValue")
    FireSize.Value = 100
    FireSize.Name = "FireSize"
    FireSize.Parent = Part
    for i,v in pairs(FireParticles) do
        if v:IsA("ParticleEmitter") then
            local Particle = v:Clone()
            Particle.Parent = Part
            Particle.Enabled = true
            Particle.Rate = Part.Size.X * Part.Size.Y * Part.Size.Z * 0.5 -- Change 0.4 to adjust rate
        end
    end
    local TouchFunction
    TouchFunction = Part.Touched:Connect(function(TouchPart)
        if string.lower(TouchPart.Name == "water") then
            TouchPart:Destroy() -- Comment out of you want water to stay after hiting
            if FireSize > 0 then
                FireSize = FireSize - 1 -- Change 1 to the rate that you want the fire to die
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
        end
    end)
end

function MainModule.BuildingFire(Building, Size)
end

function MainModule.BrushFire(Area, Size)
end


--\ LOAD /--
function MainModule.Load(Settings)
    if Settings and Settings:IsA("ModuleScript") and Settings.Version == MainModule.Version then
        MainModule.Settings = Settings
        -- Setup later
    else
        error(MainModule.OutputPrefix .." Settings are outdated or invalid.")
    end
end

return MainModule