--[=[
	Was supposed to be type solver but lowkey got carried away a bit?
]=]
--!strict
-- optimize 2

-- Modules
--local KeywordFlags = require("../langInfo/keywordFlags") :: { [string]: string }
--local Keywords = require("../langInfo/keywords")
local Debugger = require("../core/Debugger")

-- Namespaces
local void = {}
local func_ = {}

-- Funcionts
func_.GetKeywordHandleFlag = @native function(keyword: string)
	return 0 --KeywordFlags[keyword]
end

func_.FindKeywordInLine = @native function(line: string, detectFlags: boolean)
    
end

func_.GetLines = @native function(code: string)
	local lines = {} :: { string }
	for line in code:gmatch("[^\r\n]+") do
		table.insert(lines, line)
	end
	return lines
end

func_.GenerateOperationsForLine = @native function(line: string)

end

func_.parseLexerResult = @native function(result: { string })
    Debugger.Out(result)
end

-- Public functions
void.GetLines = func_.GetLines
void.GenerateOperationsFL = func_.GenerateOperationsForLine
void.parseLexerResult = func_.parseLexerResult

--[=[
    Creates a new 'local' file in the parser.
]=]
void.newFile = function()
	local file = {} -- Temp stuff for now until I figure out how this file thing is gonna work with sanboxes
	return file
end

return void
-- Allow the other parser options and pragmas
