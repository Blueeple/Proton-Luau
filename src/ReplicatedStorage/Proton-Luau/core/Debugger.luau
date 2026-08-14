--!strict
--!native
-- Modules
local LRT_Detector = require("../dependencies/LRT-Detector")

-- Roblox Luau Natives
local logWarn: (...any) -> ()
local _LuauScript: { Name: string }

-- Funtions
--[[
    Developing this is gonna be HELL bro anything but work on the parser :sob:

    - Anyhow this is for the [Redacted] who use Luau CLI instead of Lune.
    - Don't complain about slightly bad formatting for string LMAO.
    - ChatGPT wrote this btw (I'm fixing this bih later LMAO)
]]
local function FormatTextForLuauCLI(...)
	local output = {}
	local visited = {}

	local function indent(depth)
		return string.rep("    ", depth)
	end
	local function write(value: any, depth)
		local t = typeof(value)
		if t == "table" then
			if visited[value] then
				table.insert(output, "<cycle>")
				return
			end
			visited[value] = true
			table.insert(output, "{\n")
			for key, v in pairs(value) do
				table.insert(output, indent(depth + 1))
				if typeof(key) == "string" then
					table.insert(output, key .. " = ")
				else
					table.insert(output, "[" .. tostring(key) .. "] = ")
				end
				write(v, depth + 1)
				table.insert(output, ",\n")
			end
			table.insert(output, indent(depth))
			table.insert(output, "}")
			return
		end
		if t == "string" then
			table.insert(output, string.format("%q", value))
		else
			table.insert(output, tostring(value))
		end
	end

	local args = { ... }
	for i, v in ipairs(args) do
		write(v, 0)

		if i ~= #args then
			table.insert(output, " ")
		end
	end
	print(table.concat(output))
end

--[[
    Gets the name of the script from the environment.
    Returns "FileNameNotImplemented" if not available.
]]
local function GetScriptFileName()
    local pluau_runtime = LRT_Detector.getRuntime()
	local fileName, lineNumber = debug.info(3, "sl")

	if pluau_runtime == "rblx" then
		return `{fileName:match("([^.]+)$")} | {lineNumber}`
	elseif pluau_runtime == "lune" then
		return `{fileName:match("([^\\]+)$")} | {lineNumber}`
	else
		return `{fileName:match("([^/]+)$")} | {lineNumber}` -- Lute  or other Unknown Luau RunTimes
	end
end

local containers = {} :: { [string]: {} }
local Debugger = {}

if LRT_Detector.getRuntime() == "lune" or LRT_Detector.getRuntime() == "rblx"  then
	logWarn = getfenv().warn
	_LuauScript = getfenv().script
end

-- creates a new debugger class in DOD and basically allow for erm? yeh alert and what not and option to track that stuff
Debugger.new = function(name: string)
	if containers[name] then
		warn(`[{script.Name}] - name: {name} already exists.`)
	end
	containers[name] = {}
end

Debugger.Warn = function(...)
	local FileName = GetScriptFileName()
	if LRT_Detector.getRuntime() == "rblx" then
		logWarn(...)
	end
	-- Detects if the message has a Table to prettify in Luau
	if LRT_Detector.getRuntime() == "lute" or LRT_Detector.getRuntime() == "luau" then
		FormatTextForLuauCLI(`[!][{FileName}] -`, ...)
		return
	end
	print(`[!][{FileName}] -`, ...)
end

Debugger.Out = function(...)
	local FileName = GetScriptFileName()

	-- Detects if the message has a Table to prettify in Luau
	if LRT_Detector.getRuntime() == "lute" or LRT_Detector.getRuntime() == "luau" then
		FormatTextForLuauCLI(`[{FileName}] -`, ...)
		return
	end
	print(`[{FileName}] -`, ...)
end

return Debugger
