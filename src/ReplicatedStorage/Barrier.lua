--[[
-- Created on Tue Apr 20 2021
--
-- Copyright (c) 2021 Letus Entertainment
--]]

--[[
	This module creates a ray from left towards the point.  If the ray intersects with an odd amount of barriers,
	then the point is within the shape.  Otherwise, the point is outside of the shape
]]

local Barrier = {}

local OFFSET = Vector3.new(1000, 0, 0)

local barrierFolder = workspace.Barrier

--[[
	Recursive function that combines a lot of small rays to check a longer one
]]
local function getNumberOfContactsRec(rayOrigin, goal, number, alreadyHit) : Number
	local rayDirection = goal - rayOrigin
	
	local raycastParams = RaycastParams.new()
	raycastParams.FilterDescendantsInstances = barrierFolder:GetChildren()
	raycastParams.FilterType = Enum.RaycastFilterType.Whitelist

	local result = workspace:Raycast(rayOrigin, rayDirection, raycastParams)

	if result and not table.find(alreadyHit, result.Instance) then
		table.insert(alreadyHit, result.Instance)
		return getNumberOfContactsRec(result.Position, goal, number + 1, alreadyHit)
	else
		return number
	end
end

--[[
	Helper function for the Recursive getNumberOfContactsRec function
]]
local function getNumberOfContacts(rayOrigin, goal) : Number
	return getNumberOfContactsRec(rayOrigin, goal, 0, {})
end

function Barrier:isPointInsideBarrier(point : Vector3) : Boolean
	local rayOrigin = point - OFFSET

	local numberOfContacts = getNumberOfContacts(rayOrigin, point)

	return not (numberOfContacts % 2 == 0)
end

return Barrier