--!strict
-- Services
local ReplicatedFirst = game:GetService("ReplicatedFirst")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Folders
local _Bin = ReplicatedFirst:WaitForChild("Bin")

-- Packages
local Transulator = require(ReplicatedStorage:WaitForChild("VezScript").Engine)

-- CodeToTest
local Test = require("@game/ReplicatedFirst/Bin/TestCode")

Transulator.CompileToLuau(Test)
