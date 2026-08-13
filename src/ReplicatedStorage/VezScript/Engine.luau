--[=[
    Scripted by @Blueeple on @Github

    Vez script aims to be an Luau counterpart for roblox games that need a simple english
    like scripting language that gives the same benifits of luau but for your average Joe.
]=]
print("[VezScript][Emu] - Started")

--Modules
local EZSignal = require("../VezScript/dependencies/EZSignal")
local Lexer = require("../VezScript/core/Lexer")

local LuauProtonEngine = {}

-- Signals
EZSignal.new("ProtonLuau")
EZSignal.new("ProtonLuau-Parser")

-- [ Signal Binds ]
EZSignal.BindTo("ProtonLuau", function(intructionId: number, arg: string)
	print(intructionId, arg)
	
end)
EZSignal.BindTo("ProtonLuau-Parser", function(charTable: { string })
    print(table.unpack(charTable))
end)

LuauProtonEngine.CompileToLuau = function(code: { string })
	Lexer.ReadCode(code[1])
end

return LuauProtonEngine
