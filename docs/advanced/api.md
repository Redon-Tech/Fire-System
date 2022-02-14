# API Reference

## How to use

To use the API from the server add the following to your script:
```lua
local API = game.ServerStorage:WaitForChild("RTFSServerAPI")
```
Client:
```lua
local API = game.ReplicatedStorage:WaitForChild("RTFSClientAPI")
```

This is the format which events come in
```
Call, ...
```

## API Events

### System Events
--------------------------------------------
#### **Startup**
Called when the system starts up

| Call    | Other Info |
| ------- | ---------- |
| Startup | N/A        |

### Fire Events

--------------------------------------------
#### **Fire Start**
Fires when a fire is started by the system.

| Call        | Other Info     |
| ----------- | -------------- |
| FireStarted | Size, Location |
  
Size will either be "Small" or "Large", location is the model which the fire started from. 

--------------------------------------------
#### **Fire End**
Fires when a fire is detected over by the system.

| Call      | Other Info |
| --------- | ---------- |
| FireEnded | N/A        |