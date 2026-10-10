
-- Clau Hub v2 | Mobile UI Demo
-- LocalScript / authorized client test environment

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
if not player then return end

local playerGui = player:WaitForChild("PlayerGui")

local oldGui = playerGui:FindFirstChild("ClauHubDemo")
if oldGui then oldGui:Destroy() end

local gui = Instance.new("ScreenGui")
gui.Name = "ClauHubDemo"
gui.ResetOnSpawn = false
gui.DisplayOrder = 20
gui.Parent = playerGui

local function create(className, props, parent)
    local obj = Instance.new(className)
    for key, value in pairs(props) do
        obj[key] = value
    end
    obj.Parent = parent
    return obj
end

local main = create("Frame", {
    Name = "Main",
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.5, 0.5),
    Size = UDim2.new(0.88, 0, 0, 340),
    BackgroundColor3 = Color3.fromRGB(23, 25, 32),
    BorderSizePixel = 0,
}, gui)

create("UISizeConstraint", {
    MinSize = Vector2.new(260, 300),
    MaxSize = Vector2.new(420, 420),
}, main)

create("UICorner", {
    CornerRadius = UDim.new(0, 12),
}, main)

create("UIStroke", {
    Color = Color3.fromRGB(65, 70, 88),
    Thickness = 1,
}, main)

local header = create("Frame", {
    Name = "Header",
    Size = UDim2.new(1, 0, 0, 46),
    BackgroundTransparency = 1,
    Active = true,
}, main)

local title = create("TextLabel", {
    Position = UDim2.fromOffset(14, 0),
    Size = UDim2.new(1, -65, 1, 0),
    BackgroundTransparency = 1,
    Text = "CLAU HUB  /  MOBILE",
    TextColor3 = Color3.fromRGB(240, 242, 250),
    TextSize = 15,
    Font = Enum.Font.GothamBold,
    TextXAlignment = Enum.TextXAlignment.Left,
}, header)

local close = create("TextButton", {
    Position = UDim2.new(1, -40, 0, 7),
    Size = UDim2.fromOffset(32, 32),
    BackgroundColor3 = Color3.fromRGB(58, 62, 76),
    Text = "×",
    TextColor3 = Color3.new(1, 1, 1),
    TextSize = 22,
    Font = Enum.Font.GothamBold,
}, header)

create("UICorner", {
    CornerRadius = UDim.new(0, 8),
}, close)

local tabs = create("Frame", {
    Position = UDim2.fromOffset(10, 52),
    Size = UDim2.new(1, -20, 0, 36),
    BackgroundTransparency = 1,
}, main)

create("UIListLayout", {
    FillDirection = Enum.FillDirection.Horizontal,
    HorizontalAlignment = Enum.HorizontalAlignment.Left,
    Padding = UDim.new(0, 5),
    SortOrder = Enum.SortOrder.LayoutOrder,
}, tabs)

local content = create("TextLabel", {
    Name = "Content",
    Position = UDim2.fromOffset(10, 96),
    Size = UDim2.new(1, -20, 1, -106),
    BackgroundColor3 = Color3.fromRGB(32, 35, 44),
    TextColor3 = Color3.fromRGB(225, 228, 235),
    TextSize = 14,
    Font = Enum.Font.Gotham,
    TextWrapped = true,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextYAlignment = Enum.TextYAlignment.Top,
    Text = "",
}, main)

create("UICorner", {
    CornerRadius = UDim.new(0, 8),
}, content)

create("UIPadding", {
    PaddingTop = UDim.new(0, 12),
    PaddingLeft = UDim.new(0, 12),
    PaddingRight = UDim.new(0, 12),
    PaddingBottom = UDim.new(0, 8),
}, content)

local pages = {
    ["Visual"] =
        "VISUAL PREVIEW\n\n" ..
        "• Panel: aktif\n" ..
        "• Layout: mobile\n" ..
        "• Mode: demo\n\n" ..
        "Periksa jarak, warna, dan keterbacaan.",

    ["UI Test"] =
        "UI TEST CHECKLIST\n\n" ..
        "[ ] Tombol mudah disentuh\n" ..
        "[ ] Teks tidak terpotong\n" ..
        "[ ] Panel tidak menutupi kontrol\n" ..
        "[ ] Panel bisa digeser\n\n" ..
        "Checklist ini hanya contoh.",

    ["Recent Log"] =
        "RECENT LOG\n\n" ..
        "[DEMO] Clau Hub dibuka\n" ..
        "[DEMO] Mobile layout dibuat\n" ..
        "[DEMO] UI siap diperiksa",
}

for index, name in ipairs({
    "Visual",
    "UI Test",
    "Recent Log",
}) do
    local button = create("TextButton", {
        Name = "Tab" .. index,
        Size = UDim2.new(1 / 3, -4, 1, 0),
        BackgroundColor3 = Color3.fromRGB(48, 52, 65),
        Text = name,
        TextColor3 = Color3.new(1, 1, 1),
        TextSize = 11,
        TextScaled = false,
        Font = Enum.Font.GothamMedium,
        LayoutOrder = index,
    }, tabs)

    create("UICorner", {
        CornerRadius = UDim.new(0, 7),
    }, button)

    button.Activated:Connect(function()
        content.Text = pages[name]

        for _, other in ipairs(tabs:GetChildren()) do
            if other:IsA("TextButton") then
                other.BackgroundColor3 =
                    Color3.fromRGB(48, 52, 65)
            end
        end

        button.BackgroundColor3 =
            Color3.fromRGB(45, 95, 155)
    end)
end

local reopen = create("TextButton", {
    Name = "Reopen",
    AnchorPoint = Vector2.new(0, 0.5),
    Position = UDim2.new(0, 10, 0.5, 0),
    Size = UDim2.fromOffset(50, 44),
    BackgroundColor3 = Color3.fromRGB(38, 42, 55),
    Text = "CL",
    TextColor3 = Color3.new(1, 1, 1),
    TextSize = 16,
    Font = Enum.Font.GothamBold,
    Visible = false,
}, gui)

create("UICorner", {
    CornerRadius = UDim.new(0, 10),
}, reopen)

close.Activated:Connect(function()
    main.Visible = false
    reopen.Visible = true
end)

reopen.Activated:Connect(function()
    main.Visible = true
    reopen.Visible = false
end)

-- Drag panel using mouse or touch
local dragging = false
local dragInput
local dragStart
local startPosition

header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then

        dragging = true
        dragStart = input.Position
        startPosition = main.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

header.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input == dragInput then
        local delta = input.Position - dragStart

        main.Position = UDim2.new(
            startPosition.X.Scale,
            startPosition.X.Offset + delta.X,
            startPosition.Y.Scale,
            startPosition.Y.Offset + delta.Y
        )
    end
end)

content.Text = pages["Visual"]
