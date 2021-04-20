local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Barrier = require(ReplicatedStorage.Barrier)

while wait(0.2) do
	local isInside = Barrier:isPointInsideBarrier(Players.LocalPlayer.Character.HumanoidRootPart.Position)
	Players.LocalPlayer.PlayerGui.ScreenGui.TextLabel.Text = isInside and "INSIDE" or "OUTSIDE"
end