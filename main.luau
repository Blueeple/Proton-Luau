local Proton_Luau = require("./src/ReplicatedStorage/Proton-Luau/Engine")
local _CodeToTest = require("./src/ReplicatedFirst/Bin/TestCode")

local exampleLine = { "int x = 5;" }

Proton_Luau.CompileToLuau(exampleLine)
