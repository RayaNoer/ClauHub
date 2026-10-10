-- Clau Hub | UI Demo
-- Untuk pengujian UI yang diizinkan.
-- Memerlukan lingkungan Roblox Studio/test harness yang sah.

local Players = game:GetService("Players")
local player = Players.LocalPlayer
if not player then return end

local playerGui = player:WaitForChild("PlayerGui")

local oldGui = playerGui:FindFirstChild("ClauHubDemo")
if oldGui then
    oldGui:Destroy()
end

local gui = Instance.new("ScreenGui")
gui.Name = "ClauHubDemo"
gui.ResetOnSpawn = false
gui.DisplayOrder = 20
gui.Parent = playerGui

local function make(class, props, parent)
    local obj = Instance.new(class)
    for key, value in pairs(props) do
        obj[key] = value
    end
    obj.Parent = parent
    return obj
end

local main = make("Frame", {
    Name = "Main",
    Size = UDim2.new(0, 300, 0, 350),
    Position = UDim2.new(0.5, -150, 0.5, -175),
    BackgroundColor3 = Color3.fromRGB(23, 25, 32),
    BorderSizePixel = 0,
}, gui)
make("UICorner", {CornerRadius = UDim.new(0, 12)}, main)

local title = make("TextLabel", {
    Size = UDim2.new(1, -55, 0, 45),
    Position = UDim2.fromOffset(12, 0),
    BackgroundTransparency = 1,
    Text = "Clau Hub  |  UI Demo",
    TextColor3 = Color3.fromRGB(240, 240, 245),
    TextSize = 16,
    Font = Enum.Font.GothamBold,
    TextXAlignment = Enum.TextXAlignment.Left,
}, main)

local close = make("TextButton", {
    Size = UDim2.fromOffset(36, 32),
    Position = UDim2.new(1, -42, 0, 7),
    BackgroundColor3 = Color3.fromRGB(60, 63, 75),
    Text = "×",
    TextColor3 = Color3.new(1, 1, 1),
    TextSize = 22,
    Font = Enum.Font.GothamBold,
}, main)
make("UICorner", {CornerRadius = UDim.new(0, 8)}, close)

local tabs = make("Frame", {
    Size = UDim2.new(1, -20, 0, 38),
    Position = UDim2.fromOffset(10, 48),
    BackgroundTransparency = 1,
}, main)

make("UIListLayout", {
    FillDirection = Enum.FillDirection.Horizontal,
    Padding = UDim.new(0, 6),
    SortOrder = Enum.SortOrder.LayoutOrder,
}, tabs)

local content = make("TextLabel", {
    Size = UDim2.new(1, -20, 1, -100),
    Position = UDim2.fromOffset(10, 92),
    BackgroundColor3 = Color3.fromRGB(32, 35, 44),
    TextColor3 = Color3.fromRGB(225, 228, 235),
    TextSize = 14,
    Font = Enum.Font.Gotham,
    TextWrapped = true,
    TextYAlignment = Enum.TextYAlignment.Top,
    TextXAlignment = Enum.TextXAlignment.Left,
    Text = "Visual Demo\n\nPanel berhasil dibuat.\n\nIni hanya demo tampilan.",
}, main)
make("UICorner", {CornerRadius = UDim.new(0, 8)}, content)
make("UIPadding", {
    PaddingTop = UDim.new(0, 12),
    PaddingLeft = UDim.new(0, 12),
    PaddingRight = UDim.new(0, 12),
}, content)

local pages = {
    Visual = "Visual Demo\n\n• Panel UI\n• Warna dan teks\n• Uji keterbacaan",
    ["UI Test"] = "UI Test Checklist\n\n• Tombol mudah disentuh?\n• Teks terpotong?\n• Panel menutupi kontrol?\n• Tampilan nyaman di HP?",
    ["Recent Log"] = "Recent Log\n\n[DEMO] Clau Hub dibuka\n[DEMO] UI siap diuji",
}

for index, tabName in ipairs({"Visual", "UI Test", "Recent Log"}) do
    local button = make("TextButton", {
        Name = tabName:gsub(" ", ""),
        Size = UDim2.fromOffset(88, 34),
        BackgroundColor3 = Color3.fromRGB(48, 52, 65),
        Text = tabName,
        TextColor3 = Color3.new(1, 1, 1),
        TextSize = 11,
        Font = Enum.Font.GothamMedium,
        LayoutOrder = index,
    }, tabs)
    make("UICorner", {CornerRadius = UDim.new(0, 7)}, button)

    button.Activated:Connect(function()
        content.Text = pages[tabName]
    end)
end

local openButton = make("TextButton", {
    Size = UDim2.fromOffset(52, 44),
    Position = UDim2.new(0, 12, 0.5, -22),
    BackgroundColor3 = Color3.fromRGB(38, 42, 55),
    Text = "CL",
    TextColor3 = Color3.new(1, 1, 1),
    TextSize = 16,
    Font = Enum.Font.GothamBold,
    Visible = false,
}, gui)
make("UICorner", {CornerRadius = UDim.new(0, 12)}, openButton)

close.Activated:Connect(function()
    main.Visible = false
    openButton.Visible = true
end)

openButton.Activated:Connect(function()
    main.Visible = true
    openButton.Visible = false
end)
