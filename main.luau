local VezScript = require("./src/ReplicatedStorage/VezScript/Engine")
local _CodeToTest = require("./src/ReplicatedFirst/Bin/TestCode")

local exampleLine = { "int x = 5;" }

VezScript.CompileToLuau(exampleLine)
