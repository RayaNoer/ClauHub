
-- ClauHubClient.client.lua
-- Compact mobile testing UI

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")

local player = Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "ClauHub"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local remote = ReplicatedStorage:WaitForChild("ClauHubEvent")

local main = Instance.new("Frame")
main.Size = UDim2.fromOffset(260, 290)
main.Position = UDim2.new(0.5, -130, 0.5, -145)
main.BackgroundColor3 = Color3.fromRGB(25, 25, 34)
main.Parent = gui

Instance.new("UICorner", main).CornerRadius =
    UDim.new(0, 10)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 42)
title.BackgroundColor3 = Color3.fromRGB(42, 35, 60)
title.Text = "CLAU HUB"
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.Parent = main

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 7)
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Parent = main

-- Keep the title at the top.
title.LayoutOrder = 0

local function addButton(text, callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -20, 0, 38)
    button.BackgroundColor3 = Color3.fromRGB(50, 43, 68)
    button.TextColor3 = Color3.new(1, 1, 1)
    button.Text = text
    button.TextSize = 12
    button.Font = Enum.Font.GothamMedium
    button.LayoutOrder = #main:GetChildren()
    button.Parent = main

    Instance.new("UICorner", button).CornerRadius =
        UDim.new(0, 6)

    button.Activated:Connect(callback)
end

addButton("Visual: Toggle Brightness", function()
    local effect = Lighting:FindFirstChild("ClauBrightness")
    if effect then
        effect:Destroy()
    else
        effect = Instance.new("ColorCorrectionEffect")
        effect.Name = "ClauBrightness"
        effect.Brightness = 0.08
        effect.Parent = Lighting
    end
end)

addButton("Utility: Show My UserId", function()
    print("Clau Hub UserId:", player.UserId)
end)

addButton("Admin: Check Permission", function()
    remote:FireServer("GetStatus")
end)

addButton("Admin: Toggle Test Day", function()
    remote:FireServer("ToggleTestDay")
end)

addButton("Close Hub", function()
    gui:Destroy()
end)

remote.OnClientEvent:Connect(function(kind, data)
    if kind == "Status" then
        print(data.authorized and
            "Clau Hub: Admin verified" or
            "Clau Hub: No admin permission")
    elseif kind == "Result" then
        print(data.message)
    end
end)
