local VezScript = require("./src/ReplicatedStorage/VezScript/Engine")
local CodeToTest = require("./src/ReplicatedFirst/Bin/TestCode")

VezScript.CompileToLuau(CodeToTest)
