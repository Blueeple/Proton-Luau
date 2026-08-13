--[=[
	Was supposed to be type solver but lowkey got carried away a bit?
]=]
--!strict
-- optimize 2
-- Folders
local _cppInfo = script.Parent:WaitForChild("langInfo")

-- Variables
local Annotations = { "//", "/*" }
local CompilerDirectives = { "#" }

-- Modules
local KeywordFlags = require("./langInfo/keywordFlags") :: { [string]: string }
local Keywords = require("../langInfo/keywords")
local _Debugger = require("../Core/Debugger")

-- Namespaces
local void = {}
local func_ = {}

-- Funcionts
func_.GetKeywordHandleFlag = @native function(keyword: string)
    return KeywordFlags[keyword]
end

func_.FindKeywordInLine = @native function(line: string, detectFlags: boolean)
	local keyword = line:match("%S+") :: string
	local handleFlag = ""

    if table.find(Annotations, keyword) or table.find(CompilerDirectives, keyword) then
        return "--cfd", "-nf" -- cfd means check for directive or similar thing
    end

	if keyword and table.find(Keywords, keyword) then
        if detectFlags then
            handleFlag = func_.GetKeywordHandleFlag(keyword)
        end

        return keyword, handleFlag
	else
		return "--n", "-nf"
	end
end

func_.GetLines = @native function(code: string)
	local lines = {} :: { string }
	for line in code:gmatch("[^\r\n]+") do
		table.insert(lines, line)
	end
	return lines
end

func_.GenerateOperationsForLine = @native function(line: string)
    local Keyword, handleFlag = func_.FindKeywordInLine(line, true)
    print(Keyword, handleFlag)
end

-- Public functions
void.GetLines = func_.GetLines
void.GenerateOperationsFL = func_.GenerateOperationsForLine

return void
-- Allow the other parser options and pragmas
