--!native
--!optimize 2

-- Modules
local Debugger = require("./Debugger")

local waitHandlers = {
    Roblox = task.wait,
    Lune = task.wait,
}
-- Module
local TaskLibrary = {}

TaskLibrary.wait = function(duration: number)
    
end

return TaskLibrary