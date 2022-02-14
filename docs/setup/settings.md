# Installation

## Settings

Finally, to finish setting up you want to insert the model and change the settings, here is a guide on the settings.

```lua
--\ MANUAL FIRES /--

-- COMING SOON --

--\ TEAMS /--

Settings.FireTeams = {"test1", "test2"}
Settings.MinFirefighters = 1
Settings.MinLarge = 1

--\ MISC /--

Settings.BuildingLocations = {game.Workspace.Buildings, game.Workspace.Test}
Settings.BrushFireLocations = {game.Workspace.Buildings, game.Workspace.Test}

Settings.WaitTimes = {
    ResourceSaver = 60,
    CheckFireTime = 10,
    BetweenTimes = {
        Min = 10,
        Max = 30,
    }
}

--\ API /--

Settings.EnableAPI = false
```

- FireTeams [List of Strings]: The team names of which FireFighters are on. 
- MinFirefighters [Integer]: How many FireFighters must be online for fires to start.
- MinLarge [Integer]: How many FireFighters must be online for large fires to start.
- BuildingLocations [List of Locations]: A list of places will buildings are stored which are setup to work on the system
- BrushFireLocations [List of Locations]: Placeholder (Future proofing)
- WaitTimes [Table]:
  - ResourceSaver [Integer]: The amount of time to wait before checking if the fire is out or not
  - CheckFireTime [Integer]: How long to wait between checking if fires are out
  - BetweenTimes [Table]:
    - Min [Integer]: The shortest wait time possible in minutes between fire
    - Max [Integer]: The max wait time possible in minutes between fires
- EnableAPI [Bool]: If true then the script will create a RemoteEvent and BindableEvent which other scripts can use to know the status of the system, read more [here](tba)

## Finally

- Copy & Paste the provided hose into where it needs to be (Supports R6 & R15)