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

print("the hub is loading | made by plumsy.dev")
loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
showNotification("plumsy.hub", "The hub is launching, check console (F9) for more information\n Infinite Yield has been launched")
wait(1)
print("DEBUG: BYFRON GOT BYFRON'ED")
wait(2)
print("DEBUG: CONTINUING THE HUB LAUNCH")
wait(1)

local supportedGames = {
    [13772394625] = {
        [1] = "Blade Ball",
        [2] = "BladeBall"
    }, 
    [142823291] = {
        [1] = "Murder Mystery 2",
        [2] = "MM2"
    },
    [6516141723] = {
        [1] = "Doors",
        [2] = "Doors"
    },
    [16331600459] = {
        [1] = "Blade Ball",
        [2] = "BladeBall"
    },
    [4924922222] = {
        [1] = "Brookhaven",
        [2] = "Brookhaven"
    },
    [98255877724007] = {
        [1] = "Be an Egg",
        [2] = "BeAnEgg"
    }
}

if supportedGames[game.PlaceId] then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/plumsydev/robloxscripts/main/"..supportedGames[game.PlaceId][2]..".lua"))()
else
    getgenv().UILibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/plumsydev/robloxscripts/refs/heads/main/uilib.lua"))()
    showNotification("plumsy.hub", "This game is not supported, launching basic hub.")
    local gameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
    local gameID = game.PlaceId
    print("Game ain't supported: " .. gameName .. " -> ".. gameID .. " | report that gameid to the hub owner to add it ! (dsc : plumsy.dev)")

    local MainUI = UILibrary.Load("plumsy.hub")
    local infoPage = MainUI.AddPage("Info")
    local movementPage = MainUI.AddPage("Movement")
    local visualsPage= MainUI.AddPage("Visual")
    infoPage.AddLabel("\n\n\n\n\n\n\n\n\nplumsy.hub does not have any\ngame-specific modules for this game...\n\nA basic menu will be loaded.\nIt may or may not work with this game.")
    
    getgenv().speedEnabled = false
    getgenv().jumpEnabled = false
    getgenv().flightEnabled = false
    getgenv().playerESP = false
    getgenv().customSpeed = 50
    getgenv().customJump = 50

    movementPage.AddToggle("Enable Custom Speed", false, function(Value)
        getgenv().speedEnabled = Value
    end)

    movementPage.AddSlider("Speed", {Min = 0, Max = 255, Def = 50}, function(Value)
        getgenv().customSpeed = Value
    end)

    movementPage.AddToggle("Enable Custom Jump Power", false, function(Value)
        getgenv().jumpEnabled = Value
    end)

    movementPage.AddSlider("Jump Power", {Min = 0, Max = 255, Def = 50}, function(Value)
        getgenv().customJump = Value
    end)

    local flightToggle = movementPage.AddToggle("Flight", false, function(Value)
        getgenv().flightEnabled = Value
    end)

    movementPage.AddButton("Teleport to player", function()
        local teleportUI = UILibrary.Load("Teleport to player")
        local playersPage = teleportUI.AddPage("Players")
        for i, v in pairs(game.Players:GetChildren()) do
            if v ~= game.Players.LocalPlayer then
                playersPage.AddButton(v.Name, function()
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame
                end)
            end
        end
    end)

    local playerESPToggle = visualsPage.AddToggle("Player ESP", false, function(Value)
        getgenv().playerESP = Value
        spawn(function()
            while wait() do
                for i, v in pairs(game.Players:GetPlayers()) do
                    if v.Name ~= game.Players.LocalPlayer.Name then
                        if v.Character then
                            for i2, v2 in pairs(v.Character:GetChildren()) do
                                if v2.ClassName == "Part" or v2.ClassName == "MeshPart" then
                                    if not v2:FindFirstChild("BoxHandleAdornment") then
                                        local box = Instance.new("BoxHandleAdornment")
                                        box.Parent = v2
                                        box.Adornee = v2
                                        box.Size = v2.Size
                                        box.ZIndex = 0
                                        box.Transparency = 0.5
                                        box.Visible = true
                                        box.AlwaysOnTop = true
                                        wait()
                                    elseif not getgenv().playerESP then
                                        v2:FindFirstChild("BoxHandleAdornment"):Destroy()
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end)
    end)

    function onJumpRequest()
        if getgenv().flightEnabled then
            local oldJP = game.Players.LocalPlayer.Character.Humanoid.JumpPower
            game.Players.LocalPlayer.Character.Humanoid.JumpPower = 30
            wait(0.05)
            game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
            wait(0.05)
            game.Players.LocalPlayer.Character.Humanoid.JumpPower = oldJP
        end
    end
    
    game:GetService("UserInputService").JumpRequest:connect(onJumpRequest)

    while wait(1) do
        if getgenv().speedEnabled then
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = getgenv().customSpeed
        else 
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
        end

        if getgenv().jumpEnabled and not getgenv().flightEnabled then
            game.Players.LocalPlayer.Character.Humanoid.JumpPower = getgenv().customJump
        elseif not getgenv().flightEnabled then
            game.Players.LocalPlayer.Character.Humanoid.JumpPower = 57
        end
    end

end





