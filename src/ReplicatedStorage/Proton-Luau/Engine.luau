--[=[
    Scripted by @Blueeple on @Github
]=]
print("[ProtonLuau][Emulator] - Started")

-- Modules
local EZSignal = require("../VezScript/dependencies/EZSignal")
local parser = require("../VezScript/core/parser")
local lexer = require("../VezScript/core/lexer")
local Debugger = require("../VezScript/core/Debugger")

-- Roblox Detection
local isRoblox = Debugger.IsRoblox()
local isLune = Debugger.IsLune()

if isRoblox then
	print("[Debugger] - Running in Roblox | Applying Roblox Natives")
elseif isLune then
	print("[Debugger] - Running in Lune | Applying Lune Natives")
else
	print("[Debugger] - Running in Luau CLI | Or unknown Runtime")
	
end

-- Variables
local currentFile = {} :: typeof(parser.newFile())

-- Module
local LuauProtonEngine = {}

-- Signals
EZSignal.new("ProtonLuau")
EZSignal.new("ProtonLuau-Parser")

-- [ Signal Binds ]
EZSignal.BindTo("ProtonLuau", function(intructionId: number, arg: string)
	print(intructionId, arg)
end)
EZSignal.BindTo("ProtonLuau-Parser", function(charTable: { string })
	currentFile = parser.newFile()
	parser.parseLexerResult(charTable)

	if currentFile then
		Debugger.Out(currentFile)
	end
end)

LuauProtonEngine.CompileToLuau = function(code: { string })
	lexer.ReadCode(code[1])
end

return LuauProtonEngine
