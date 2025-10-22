local function showNotification(title, message)
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "NotificationGui"
    screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    
    local notificationFrame = Instance.new("Frame")
    notificationFrame.Size = UDim2.new(0, 350, 0, 120)
    notificationFrame.Position = UDim2.new(0.5, 0, 0.5, 0)  -- Center the notification
    notificationFrame.AnchorPoint = Vector2.new(0.5, 0.5)  -- Set the anchor point to the center
    notificationFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    notificationFrame.BorderSizePixel = 0
    notificationFrame.BackgroundTransparency = 0.1
    notificationFrame.Parent = screenGui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 15)
    corner.Parent = notificationFrame
    
    local shadow = Instance.new("ImageLabel")
    shadow.AnchorPoint = Vector2.new(0.5, 0.5)
    shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
    shadow.Size = UDim2.new(1, 20, 1, 20)
    shadow.BackgroundTransparency = 1
    shadow.Image = "rbxassetid://1316045217"
    shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    shadow.ImageTransparency = 0.7
    shadow.Parent = notificationFrame
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, -40, 0, 40)
    titleLabel.Position = UDim2.new(0, 20, 0, 10)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 24
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.Parent = notificationFrame
    
    local messageLabel = Instance.new("TextLabel")
    messageLabel.Size = UDim2.new(1, -40, 0, 50)
    messageLabel.Position = UDim2.new(0, 20, 0, 50)
    messageLabel.BackgroundTransparency = 1
    messageLabel.Text = message
    messageLabel.Font = Enum.Font.Gotham
    messageLabel.TextSize = 18
    messageLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    messageLabel.TextWrapped = true
    messageLabel.Parent = notificationFrame
    
    local TweenService = game:GetService("TweenService")
    
    local tweenInfo = TweenInfo.new(
        0.5, -- Time
        Enum.EasingStyle.Quad, -- Easing Style
        Enum.EasingDirection.Out, -- Easing Direction
        0, -- Repeat Count (when less than zero the tween will loop indefinitely)
        false, -- Reverses (tween will reverse once reaching its goal)
        0 -- Delay Time
    )
    
    local goal = {}
    goal.Position = UDim2.new(0.5, 0, 0.5, 0)
    
    local tween = TweenService:Create(notificationFrame, tweenInfo, goal)
    tween:Play()
    
    wait(5) -- Wait for 5 seconds before hiding the notification
 
    local hideTweenInfo = TweenInfo.new(
        0.5,
        Enum.EasingStyle.Quad,
        Enum.EasingDirection.In
    )
 
    local hideGoal = {}
    hideGoal.Position = UDim2.new(0.5, 0, 0.5, 0)
 
    local hideTween = TweenService:Create(notificationFrame, hideTweenInfo, hideGoal)
    hideTween:Play()
 
    hideTween.Completed:Connect(function()
        screenGui:Destroy()
    end)
end

showNotification("plumsy.egg", "The exploit has ran successfully, all orbs should automatically collect.")

local function gunclaimed()
    local orbs = {}
    for _, orb in pairs(workspace.Orbs:GetChildren()) do
        if orb:FindFirstChild("Claimed") and orb.Claimed.Value == false then
            table.insert(orbs, orb)
        end
    end
    return orbs
end

local function collect()
    local aOrbs = gunclaimed()
    local amount = 15 -- ac
    
    for i = 1, #aOrbs, amount do
        local batch = {}
        for j = i, math.min(i + amount - 1, #aOrbs) do
            table.insert(batch, aOrbs[j])
        end
        
        if #batch > 0 then
            game:GetService("ReplicatedStorage").Actions.CollectOrb:FireServer(batch)
            task.wait()
        end
    end
end

while task.wait() do collect() end
