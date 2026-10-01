--[[
    ====================================================
    AURA VISUALS (AV) - ULTIMATE CLIENT v3.5
    Professional Visual & Atmosphere Modification Suite
    ====================================================
]]

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

-- Очистка старого UI
if CoreGui:FindFirstChild("AV_VisualsCore") then 
    CoreGui.AV_VisualsCore:Destroy() 
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AV_VisualsCore"
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local ThemeAccent = Color3.fromRGB(138, 43, 226) -- Строгий фиолетовый
local SecondaryBg = Color3.fromRGB(12, 10, 18)
local DarkBg = Color3.fromRGB(7, 6, 11)

-- ==================== [ ПЛАВАЮЩАЯ КНОПКА ] ====================
local FloatBtn = Instance.new("TextButton")
FloatBtn.Size = UDim2.new(0, 48, 0, 48)
FloatBtn.Position = UDim2.new(0, 15, 0.4, 0)
FloatBtn.BackgroundColor3 = DarkBg
FloatBtn.Text = "AV"
FloatBtn.TextColor3 = ThemeAccent
FloatBtn.TextSize = 16
FloatBtn.Font = Enum.Font.Code
FloatBtn.Active = true
FloatBtn.Draggable = true
FloatBtn.Parent = ScreenGui

Instance.new("UICorner", FloatBtn).CornerRadius = UDim.new(0, 8)
local FloatStroke = Instance.new("UIStroke", FloatBtn)
FloatStroke.Color = ThemeAccent
FloatStroke.Thickness = 1.5

-- ==================== [ ГЛАВНОЕ ОКНО ] ====================
local MainWindow = Instance.new("Frame")
MainWindow.Size = UDim2.new(0, 520, 0, 360)
MainWindow.Position = UDim2.new(0.5, -260, 0.5, -180)
MainWindow.BackgroundColor3 = DarkBg
MainWindow.Visible = false
MainWindow.Parent = ScreenGui

Instance.new("UICorner", MainWindow).CornerRadius = UDim.new(0, 10)
local MainStroke = Instance.new("UIStroke", MainWindow)
MainStroke.Color = ThemeAccent
MainStroke.Thickness = 1.5

-- Шапка
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 36)
TopBar.BackgroundColor3 = SecondaryBg
TopBar.Parent = MainWindow
Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0, 10)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -20, 1, 0)
Title.Position = UDim2.new(0, 12, 0, 0)
Title.Text = "AURA VISUALS // CLIENT ENVIRONMENT"
Title.TextColor3 = Color3.fromRGB(200, 200, 210)
Title.TextSize = 11
Title.Font = Enum.Font.Code
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.BackgroundTransparency = 1
Title.Parent = TopBar

FloatBtn.MouseButton1Click:Connect(function()
    MainWindow.Visible = not MainWindow.Visible
end)

-- ==================== [ ВКЛАДКИ ] ====================
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 130, 1, -36)
Sidebar.Position = UDim2.new(0, 0, 0, 36)
Sidebar.BackgroundColor3 = SecondaryBg
Sidebar.Parent = MainWindow

local TabList = Instance.new("UIListLayout", Sidebar)
TabList.Padding = UDim.new(0, 4)
TabList.HorizontalAlignment = Enum.HorizontalAlignment.Center

local ContentArea = Instance.new("Frame")
ContentArea.Size = UDim2.new(1, -138, 1, -44)
ContentArea.Position = UDim2.new(0, 134, 0, 40)
ContentArea.BackgroundTransparency = 1
ContentArea.Parent = MainWindow

local function CreateTab(name)
    local Page = Instance.new("ScrollingFrame")
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.BackgroundTransparency = 1
    Page.Visible = false
    Page.ScrollBarThickness = 2
    Page.CanvasSize = UDim2.new(0, 0, 0, 800)
    Page.Parent = ContentArea
    Instance.new("UIListLayout", Page).Padding = UDim.new(0, 6)

    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(0, 118, 0, 30)
    Btn.BackgroundColor3 = DarkBg
    Btn.Text = name
    Btn.TextColor3 = Color3.fromRGB(150, 150, 160)
    Btn.Font = Enum.Font.Code
    Btn.TextSize = 11
    Btn.Parent = Sidebar
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)

    Btn.MouseButton1Click:Connect(function()
        for _, p in pairs(ContentArea:GetChildren()) do p.Visible = false end
        Page.Visible = true
        for _, b in pairs(Sidebar:GetChildren()) do 
            if b:IsA("TextButton") then b.TextColor3 = Color3.fromRGB(150, 150, 160) end
        end
        Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    end)
    return Page
end

local TabWorld = CreateTab("WORLD")
local TabCosmetics = CreateTab("COSMETICS")
local TabPlayer = CreateTab("PLAYER")
TabWorld.Visible = true

-- Конструктор тумблеров
local function AddToggle(parent, text, callback)
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, -10, 0, 34)
    Frame.BackgroundColor3 = SecondaryBg
    Frame.Parent = parent
    Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 6)

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -45, 1, 0)
    Label.Position = UDim2.new(0, 10, 0, 0)
    Label.Text = text
    Label.TextColor3 = Color3.fromRGB(210, 210, 220)
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.BackgroundTransparency = 1
    Label.Font = Enum.Font.Code
    Label.TextSize = 11
    Label.Parent = Frame

    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(0, 28, 0, 16)
    Btn.Position = UDim2.new(1, -36, 0.5, -8)
    Btn.BackgroundColor3 = Color3.fromRGB(25, 22, 35)
    Btn.Text = ""
    Btn.Parent = Frame
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(1, 0)

    local Circle = Instance.new("Frame")
    Circle.Size = UDim2.new(0, 12, 0, 12)
    Circle.Position = UDim2.new(0, 2, 0.5, -6)
    Circle.BackgroundColor3 = Color3.fromRGB(120, 120, 130)
    Circle.Parent = Btn
    Instance.new("UICorner", Circle).CornerRadius = UDim.new(1, 0)

    local state = false
    Btn.MouseButton1Click:Connect(function()
        state = not state
        TweenService:Create(Btn, TweenInfo.new(0.15), {BackgroundColor3 = state and ThemeAccent or Color3.fromRGB(25, 22, 35)}):Play()
        Circle:TweenPosition(state and UDim2.new(1, -14, 0.5, -6) or UDim2.new(0, 2, 0.5, -6), "Out", "Quad", 0.15, true)
        callback(state)
    end)
end

-- ==================== [ ФУНКЦИИ: WORLD (НЕБО И КОСМОС) ] ====================

AddToggle(TabWorld, "Galaxy Sky (Галактика)", function(v)
    if v then
        Lighting.ClockTime = 0
        local sky = Instance.new("Sky", Lighting)
        sky.Name = "AV_Sky"
        sky.SkyboxBk = "rbxassetid://159454299"
        sky.SkyboxDn = "rbxassetid://159454296"
        sky.SkyboxFt = "rbxassetid://159454293"
        sky.SkyboxLf = "rbxassetid://159454286"
        sky.SkyboxRt = "rbxassetid://159454300"
        sky.SkyboxUp = "rbxassetid://159454288"
    else
        if Lighting:FindFirstChild("AV_Sky") then Lighting.AV_Sky:Destroy() end
        Lighting.ClockTime = 14
    end
end)

AddToggle(TabWorld, "TON 618 Black Hole (Черная дыра)", function(v)
    if v then
        local bh = Instance.new("Part", workspace)
        bh.Name = "AV_TON618"
        bh.Shape = Enum.PartType.Ball
        bh.Size = Vector3.new(600, 600, 600)
        bh.Position = Vector3.new(0, 800, 0) -- Высоко в небе, чтобы точно было видно
        bh.Anchored = true
        bh.CanCollide = false
        bh.Material = Enum.Material.Neon
        bh.Color = Color3.fromRGB(0, 0, 0)

        -- Кольцо аккреции (светящийся диск)
        local ring = Instance.new("Part", bh)
        ring.Size = Vector3.new(700, 10, 700)
        ring.Position = bh.Position
        ring.Anchored = true
        ring.CanCollide = false
        ring.Material = Enum.Material.Neon
        ring.Color = ThemeAccent
        Instance.new("SpecialMesh", ring).MeshType = Enum.MeshType.Cylinder
    else
        if workspace:FindFirstChild("AV_TON618") then workspace.AV_TON618:Destroy() end
    end
end)

AddToggle(TabWorld, "Cosmic Dust Particles (Космическая пыль)", function(v)
    if v then
        local emitter = Instance.new("ParticleEmitter", workspace.Terrain)
        emitter.Name = "AV_Dust"
        emitter.Texture = "rbxassetid://258128463"
        emitter.Rate = 80
        emitter.Speed = NumberRange.new(5, 15)
        emitter.Size = NumberSequence.new(0.5)
        emitter.Lifetime = NumberRange.new(5, 10)
    else
        if workspace.Terrain:FindFirstChild("AV_Dust") then workspace.Terrain.AV_Dust:Destroy() end
    end
end)

-- ==================== [ ФУНКЦИИ: COSMETICS ] ====================

AddToggle(TabCosmetics, "Floating Halo (Нимб)", function(v)
    local char = LocalPlayer.Character
    if not char then return end
    if v then
        local halo = Instance.new("Part", char)
        halo.Name = "AV_Halo"
        halo.Size = Vector3.new(1.2, 0.15, 1.2)
        halo.CanCollide = false
        halo.Material = Enum.Material.Neon
        halo.Color = ThemeAccent
        Instance.new("SpecialMesh", halo).MeshType = Enum.MeshType.FileMesh
        halo.MeshId = "rbxassetid://10688009" -- Тор (Кольцо)
        
        local weld = Instance.new("Weld", halo)
        weld.Part0 = halo
        weld.Part1 = char.Head
        weld.C0 = CFrame.new(0, 1.2, 0)
    else
        if char:FindFirstChild("AV_Halo") then char.AV_Halo:Destroy() end
    end
end)

-- ==================== [ ФУНКЦИИ: PLAYER (РАБОЧЕЕ ИСПРАВЛЕНИЕ) ] ====================

local noclipConnection = nil
AddToggle(TabPlayer, "Noclip (Сквозь стены)", function(v)
    if v then
        noclipConnection = RunService.Stepped:Connect(function()
            local char = LocalPlayer.Character
            if char then
                for _, part in pairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then part.CanCollide = false end
                end
            end
        end)
    else
        if noclipConnection then 
            noclipConnection:Disconnect() 
            noclipConnection = nil
        end
        local char = LocalPlayer.Character
        if char then
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = true end
            end
        end
    end
end)

local rainbowConnection = nil
AddToggle(TabPlayer, "Rainbow Body (Цветное тело)", function(v)
    if v then
        rainbowConnection = RunService.RenderStepped:Connect(function()
            local char = LocalPlayer.Character
            if char then
                local hue = tick() % 5 / 5
                local col = Color3.fromHSV(hue, 1, 1)
                for _, part in pairs(char:GetChildren()) do
                    if part:IsA("BasePart") then part.Color = col end
                end
            end
        end)
    else
        if rainbowConnection then
            rainbowConnection:Disconnect()
            rainbowConnection = nil
            local char = LocalPlayer.Character
            if char then
                for _, part in pairs(char:GetChildren()) do
                    if part:IsA("BasePart") then part.Color = Color3.fromRGB(163, 162, 165) end
                end
            end
        end
    end
end)

print("Aura Visuals v3.5 Loaded Successfully.")