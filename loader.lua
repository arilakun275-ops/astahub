--====================================
-- ASTA TP FARM CHECKPOINT
-- ON / OFF + CLICK TP
-- SCROLLABLE + DRAGGABLE UI
-- DELAY CUSTOM
-- FINAL VERSION
--====================================

-- SERVICES
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer

-- STATE
local farming = false

-- CHECKPOINT DATA
local checkpoints = {
    Vector3.new(-175.0, 92.9, -725.8),
    Vector3.new(-483.9, 136.0, -715.9),
    Vector3.new(-559.1, 276.0, -284.6),
    Vector3.new(-648.9, 339.9, 104.9),
    Vector3.new(-240.5, 398.8, 145.8),
    Vector3.new(137.8, 600.0, 375.5),
    Vector3.new(-187.2, 848.0, 368.9),
    Vector3.new(-758.3, 772.4, 401.2),
    Vector3.new(-1646.5, 864.0, 316.7),
    Vector3.new(-1654.8, 952.5, -15.0),
    Vector3.new(-1468.9, 992.0, -57.9),
    Vector3.new(-1471.8, 992.0, -397.3),
    Vector3.new(-1358.2, 1064.0, -317.2),
    Vector3.new(1.8, 1509.3, -244.4),
    Vector3.new(-114.8, 1872.7, -272.8),
    Vector3.new(-674.5, 1892.0, -274.5),
    Vector3.new(-1233.5, 1920.2, -271.1),
    Vector3.new(-1681.7, 2038.7, -261.0),
    Vector3.new(-2245.9, 2041.2, -258.9), -- CP19
    Vector3.new(-1909.9, 2056.9, 51.1),   -- CP20
    Vector3.new(-1671.9, 2056.0, 89.5),
    Vector3.new(-1330.1, 2106.0, 97.0),
    Vector3.new(-727.2, 2253.4, 103.1),
    Vector3.new(-568.1, 2252.2, 87.5),    -- CP24
    Vector3.new(-136.2, 2782.6, -98.0)    -- CP25 (SUBMIT)
}

-- DELAY FUNCTION
local function getDelay(index)
    if index == 19 or index == 20 or index == 24 or index == 25 then
        return 3.5
    else
        return 2.5
    end
end

-- TELEPORT FUNCTION
local function tpTo(pos)
    local char = player.Character or player.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")
    hrp.CFrame = CFrame.new(pos)
end

-- AUTO FARM LOOP
task.spawn(function()
    while task.wait() do
        if farming then
            for i, pos in ipairs(checkpoints) do
                if not farming then break end
                tpTo(pos)
                task.wait(getDelay(i))
            end
        end
    end
end)

--====================================
-- UI
--====================================

local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "AstaTPFarm"

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 260, 0, 360)
main.Position = UDim2.new(0.05, 0, 0.2, 0)
main.BackgroundColor3 = Color3.fromRGB(30,30,30)
main.Active = true
main.Draggable = true

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1,0,0,40)
title.BackgroundColor3 = Color3.fromRGB(20,20,20)
title.Text = "ASTA TP FARM"
title.TextColor3 = Color3.new(1,1,1)
title.TextScaled = true

local toggle = Instance.new("TextButton", main)
toggle.Size = UDim2.new(1,-20,0,35)
toggle.Position = UDim2.new(0,10,0,45)
toggle.Text = "FARM : OFF"
toggle.BackgroundColor3 = Color3.fromRGB(120,0,0)
toggle.TextColor3 = Color3.new(1,1,1)

toggle.MouseButton1Click:Connect(function()
    farming = not farming
    toggle.Text = farming and "FARM : ON" or "FARM : OFF"
    toggle.BackgroundColor3 = farming and Color3.fromRGB(0,120,0) or Color3.fromRGB(120,0,0)
end)

-- SCROLL FRAME
local scroll = Instance.new("ScrollingFrame", main)
scroll.Position = UDim2.new(0,10,0,90)
scroll.Size = UDim2.new(1,-20,1,-100)
scroll.CanvasSize = UDim2.new(0,0,0,#checkpoints*35)
scroll.ScrollBarImageTransparency = 0.2
scroll.BackgroundTransparency = 1

-- CHECKPOINT BUTTONS
for i, pos in ipairs(checkpoints) do
    local btn = Instance.new("TextButton", scroll)
    btn.Size = UDim2.new(1,0,0,30)
    btn.Position = UDim2.new(0,0,0,(i-1)*35)
    btn.Text = (i == 25 and "CP "..i.." (SUBMIT)") or ("CP "..i)
    btn.BackgroundColor3 = Color3.fromRGB(45,45,45)
    btn.TextColor3 = Color3.new(1,1,1)

    btn.MouseButton1Click:Connect(function()
        tpTo(pos)
    end)
end
