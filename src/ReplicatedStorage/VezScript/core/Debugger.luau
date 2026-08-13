--!strict
--!native

local containers = {} :: { [string]: {} }
local Debugger = {}

-- creates a new debugger class in DOD and basically allow for erm? yeh alert and what not and option to track that stuff
Debugger.new = function(name: string)
    if containers[name] then
        warn(`[{script.Name}] - name: {name} already exists.`)
    end
    containers[name] = {}
end

return Debugger
