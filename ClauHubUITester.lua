
-- ClauHubUITester.lua
-- Standalone Roblox UI testing demo
-- Intended for an authorized test environment.

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local previous = playerGui:FindFirstChild("ClauHubUITester")
if previous then
    previous:Destroy()
end

local gui = Instance.new("ScreenGui")
gui.Name = "ClauHubUITester"
gui.ResetOnSpawn = false
gui.DisplayOrder = 50
gui.Parent = playerGui

local purple = Color3.fromRGB(145, 100, 255)
local panelColor = Color3.fromRGB(25, 25, 34)
local buttonColor = Color3.fromRGB(43, 43, 57)
local white = Color3.fromRGB(245, 245, 250)

local main = Instance.new("Frame")
main.Name = "Main"
main.Size = UDim2.fromOffset(270, 330)
main.Position = UDim2.new(0.5, -135, 0.5, -165)
main.BackgroundColor3 = panelColor
main.BorderSizePixel = 0
main.Parent = gui

Instance.new("UICorner", main).CornerRadius =
    UDim.new(0, 12)

local stroke = Instance.new("UIStroke")
stroke.Color = purple
stroke.Transparency = 0.2
stroke.Parent = main

local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 44)
header.BackgroundColor3 = Color3.fromRGB(38, 34, 52)
header.BorderSizePixel = 0
header.Parent = main

Instance.new("UICorner", header).CornerRadius =
    UDim.new(0, 12)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -90, 1, 0)
title.Position = UDim2.fromOffset(12, 0)
title.BackgroundTransparency = 1
title.Text = "CLAU HUB"
title.TextColor3 = white
title.Font = Enum.Font.GothamBold
title.TextSize = 15
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

local function makeButton(parent, text, height)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -20, 0, height or 36)
    button.BackgroundColor3 = buttonColor
    button.BorderSizePixel = 0
    button.Text = text
    button.TextColor3 = white
    button.Font = Enum.Font.GothamMedium
    button.TextSize = 12
    button.TextWrapped = true
    button.Parent = parent

    Instance.new("UICorner", button).CornerRadius =
        UDim.new(0, 7)

    return button
end

local minimize = makeButton(header, "-", 28)
minimize.Size = UDim2.fromOffset(28, 28)
minimize.Position = UDim2.new(1, -64, 0, 8)

local close = makeButton(header, "X", 28)
close.Size = UDim2.fromOffset(28, 28)
close.Position = UDim2.new(1, -32, 0, 8)
close.BackgroundColor3 = Color3.fromRGB(110, 48, 65)

local tabs = Instance.new("Frame")
tabs.Size = UDim2.new(1, -16, 0, 34)
tabs.Position = UDim2.fromOffset(8, 51)
tabs.BackgroundTransparency = 1
tabs.Parent = main

local tabLayout = Instance.new("UIListLayout")
tabLayout.FillDirection = Enum.FillDirection.Horizontal
tabLayout.Padding = UDim.new(0, 5)
tabLayout.Parent = tabs

local content = Instance.new("ScrollingFrame")
content.Size = UDim2.new(1, -16, 1, -116)
content.Position = UDim2.fromOffset(8, 91)
content.BackgroundTransparency = 1
content.BorderSizePixel = 0
content.ScrollBarThickness = 3
content.AutomaticCanvasSize = Enum.AutomaticSize.Y
content.CanvasSize = UDim2.new()
content.Parent = main

local list = Instance.new("UIListLayout")
list.Padding = UDim.new(0, 7)
list.HorizontalAlignment = Enum.HorizontalAlignment.Center
list.Parent = content

local footer = Instance.new("TextLabel")
footer.Size = UDim2.new(1, -16, 0, 18)
footer.Position = UDim2.new(0, 8, 1, -21)
footer.BackgroundTransparency = 1
footer.Text = "UI TESTER | READY"
footer.TextColor3 = Color3.fromRGB(180, 180, 195)
footer.Font = Enum.Font.Gotham
footer.TextSize = 10
footer.Parent = main

local function clearContent()
    for _, item in ipairs(content:GetChildren()) do
        if not item:IsA("UIListLayout") then
            item:Destroy()
        end
    end
end

local function info(text)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -4, 0, 38)
    label.BackgroundColor3 = buttonColor
    label.BorderSizePixel = 0
    label.Text = text
    label.TextColor3 = white
    label.Font = Enum.Font.Gotham
    label.TextSize = 11
    label.TextWrapped = true
    label.Parent = content

    Instance.new("UICorner", label).CornerRadius =
        UDim.new(0, 7)
end

local function action(text, callback)
    local button = makeButton(content, text, 36)
    button.Activated:Connect(callback)
end

local function showTab(name)
    clearContent()

    if name == "Visual" then
        action("Toggle Demo Highlight", function()
            local effect = main:FindFirstChild("DemoHighlight")
            if effect then
                effect:Destroy()
            else
                effect = Instance.new("UIStroke")
                effect.Name = "DemoHighlight"
                effect.Color = Color3.fromRGB(255, 210, 100)
                effect.Thickness = 3
                effect.Parent = main
            end
        end)

        action("Restore Demo Highlight", function()
            local effect = main:FindFirstChild("DemoHighlight")
            if effect then effect:Destroy() end
        end)

        info("Visual changes apply to this demo panel only.")

    elseif name == "UI Test" then
        local checks = {
            "Check 1: Buttons visible",
            "Check 2: Text readable",
            "Check 3: Panel positioned correctly",
            "Check 4: Touch targets accessible",
        }

        for _, check in ipairs(checks) do
            action(check, function()
                footer.Text = check .. " | REVIEWED"
            end)
        end

    elseif name == "Reports" then
        info("Clau Hub UI Tester")
        info("Player: " .. player.Name)
        info("UserId: " .. tostring(player.UserId))
        info("Report status: Local demo only")

        action("Mark UI Review Complete", function()
            footer.Text = "UI review completed locally"
        end)
    end
end

local currentTab

for index, name in ipairs({"Visual", "UI Test", "Reports"}) do
    local button = makeButton(tabs, name, 32)
    button.Size = UDim2.new(0, 80, 0, 32)
    button.LayoutOrder = index

    button.Activated:Connect(function()
        if currentTab then
            currentTab.BackgroundColor3 = buttonColor
        end

        currentTab = button
        button.BackgroundColor3 = purple
        showTab(name)
    end)
end

tabs:GetChildren()[1].BackgroundColor3 = purple
showTab("Visual")

local minimized = false

minimize.Activated:Connect(function()
    minimized = not minimized
    tabs.Visible = not minimized
    content.Visible = not minimized
    footer.Visible = not minimized

    main.Size = minimized
        and UDim2.fromOffset(270, 44)
        or UDim2.fromOffset(270, 330)

    minimize.Text = minimized and "+" or "-"
end)

close.Activated:Connect(function()
    gui:Destroy()
end)

footer.Text = "UI TESTER | READY"
