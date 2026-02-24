local function createHorizontalKeyGUI()
    local ENCODED_KEY = {
       349,448,391,442,355,436,400,391,448,403
    }
    
    local function getValidKey()
        local key = ""
        for _, v in ipairs(ENCODED_KEY) do
            local ascii = (v - 100) / 3
            key = key .. string.char(ascii)
        end
        return key
    end

    local CONFIG = {
        CopyLink = "https://direct-link.net/3394206/Cskv8E28PbMY",
        MainScriptUrl = "https://raw.githubusercontent.com/FayyMeng/Star-Fishing/refs/heads/main/Star%20Fishing%20lua",
    }
    
    local VALID_KEY = getValidKey()
    local isMobile = game:GetService("UserInputService").TouchEnabled
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "FayyHorizontalGUI"
    ScreenGui.Parent = game:GetService("CoreGui")
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    local guiWidth = isMobile and 550 or 650
    local guiHeight = isMobile and 280 or 320
    
    local Container = Instance.new("Frame")
    Container.Size = UDim2.new(0, guiWidth, 0, guiHeight)
    Container.Position = UDim2.new(0.5, -guiWidth/2, 0.5, -guiHeight/2)
    Container.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Container.BackgroundTransparency = 0.05
    Container.BorderSizePixel = 0
    Container.ClipsDescendants = true
    Container.Parent = ScreenGui

    local ContainerGradient = Instance.new("UIGradient")
    ContainerGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(250, 250, 255)),
        ColorSequenceKeypoint.new(0.7, Color3.fromRGB(235, 240, 250)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(220, 225, 240))
    })
    ContainerGradient.Rotation = 135
    ContainerGradient.Parent = Container

    local Shadow = Instance.new("ImageLabel")
    Shadow.Size = UDim2.new(1, 20, 1, 20)
    Shadow.Position = UDim2.new(0, -10, 0, -10)
    Shadow.BackgroundTransparency = 1
    Shadow.Image = "rbxassetid://6014261993"
    Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    Shadow.ImageTransparency = 0.6
    Shadow.ScaleType = Enum.ScaleType.Slice
    Shadow.SliceCenter = Rect.new(10, 10, 10, 10)
    Shadow.Parent = Container

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, isMobile and 15 or 20)
    Corner.Parent = Container

    local LeftPanel = Instance.new("Frame")
    LeftPanel.Size = UDim2.new(0, isMobile and 80 or 100, 1, 0)
    LeftPanel.BackgroundColor3 = Color3.fromRGB(10, 20, 40)
    LeftPanel.BorderSizePixel = 0
    LeftPanel.Parent = Container

    local LeftPanelCorner = Instance.new("UICorner")
    LeftPanelCorner.CornerRadius = UDim.new(0, isMobile and 15 or 20)
    LeftPanelCorner.Parent = LeftPanel

    local LeftPanelGradient = Instance.new("UIGradient")
    LeftPanelGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(15, 25, 45)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(25, 35, 60))
    })
    LeftPanelGradient.Rotation = 180
    LeftPanelGradient.Parent = LeftPanel

    local LogoFrame = Instance.new("Frame")
    LogoFrame.Size = UDim2.new(0, isMobile and 50 or 60, 0, isMobile and 50 or 60)
    LogoFrame.Position = UDim2.new(0.5, isMobile and -25 or -30, 0, isMobile and 15 or 20)
    LogoFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    LogoFrame.BackgroundTransparency = 0.1
    LogoFrame.BorderSizePixel = 0
    LogoFrame.Parent = LeftPanel

    local LogoCorner = Instance.new("UICorner")
    LogoCorner.CornerRadius = UDim.new(0, isMobile and 25 or 30)
    LogoCorner.Parent = LogoFrame

    local LogoGradient = Instance.new("UIGradient")
    LogoGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(220, 225, 240)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
    })
    LogoGradient.Rotation = 45
    LogoGradient.Parent = LogoFrame

    local LogoText = Instance.new("TextLabel")
    LogoText.Size = UDim2.new(1, 0, 1, 0)
    LogoText.BackgroundTransparency = 1
    LogoText.Text = "🔑"
    LogoText.TextColor3 = Color3.fromRGB(20, 30, 50)
    LogoText.Font = Enum.Font.GothamBold
    LogoText.TextSize = isMobile and 28 or 35
    LogoText.Parent = LogoFrame

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, isMobile and 20 or 25)
    Title.Position = UDim2.new(0, 0, 0, isMobile and 75 or 85)
    Title.BackgroundTransparency = 1
    Title.Text = "FAYY"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = isMobile and 18 or 22
    Title.Parent = LeftPanel

    local Title2 = Instance.new("TextLabel")
    Title2.Size = UDim2.new(1, 0, 0, isMobile and 20 or 25)
    Title2.Position = UDim2.new(0, 0, 0, isMobile and 95 or 110)
    Title2.BackgroundTransparency = 1
    Title2.Text = "SCRIPT"
    Title2.TextColor3 = Color3.fromRGB(180, 200, 230)
    Title2.Font = Enum.Font.GothamBold
    Title2.TextSize = isMobile and 16 or 20
    Title2.Parent = LeftPanel

    local Version = Instance.new("TextLabel")
    Version.Size = UDim2.new(1, 0, 0, 15)
    Version.Position = UDim2.new(0, 0, 1, isMobile and -30 or -35)
    Version.BackgroundTransparency = 1
    Version.Text = "v2.0"
    Version.TextColor3 = Color3.fromRGB(150, 170, 200)
    Version.Font = Enum.Font.Gotham
    Version.TextSize = isMobile and 10 or 12
    Version.Parent = LeftPanel

    local Content = Instance.new("Frame")
    Content.Size = UDim2.new(1, isMobile and -90 or -110, 1, -30)
    Content.Position = UDim2.new(0, isMobile and 85 or 105, 0, 15)
    Content.BackgroundTransparency = 1
    Content.Parent = Container

    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Size = UDim2.new(0, isMobile and 30 or 35, 0, isMobile and 30 or 35)
    CloseBtn.Position = UDim2.new(1, isMobile and -35 or -45, 0, isMobile and -5 or -5)
    CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    CloseBtn.BackgroundTransparency = 0.2
    CloseBtn.Text = "✕"
    CloseBtn.TextColor3 = Color3.fromRGB(20, 30, 50)
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.TextSize = isMobile and 16 or 20
    CloseBtn.Parent = Content

    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(0, isMobile and 8 or 10)
    CloseCorner.Parent = CloseBtn

    CloseBtn.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)

    local Welcome = Instance.new("TextLabel")
    Welcome.Size = UDim2.new(1, 0, 0, isMobile and 25 or 30)
    Welcome.BackgroundTransparency = 1
    Welcome.Text = "Welcome Back,"
    Welcome.TextColor3 = Color3.fromRGB(80, 90, 110)
    Welcome.Font = Enum.Font.Gotham
    Welcome.TextSize = isMobile and 14 or 16
    Welcome.Parent = Content

    local UserName = Instance.new("TextLabel")
    UserName.Size = UDim2.new(1, 0, 0, isMobile and 30 or 35)
    UserName.Position = UDim2.new(0, 0, 0, isMobile and 20 or 25)
    UserName.BackgroundTransparency = 1
    UserName.Text = "Premium User"
    UserName.TextColor3 = Color3.fromRGB(30, 40, 60)
    UserName.Font = Enum.Font.GothamBold
    UserName.TextSize = isMobile and 20 or 24
    UserName.Parent = Content

    local HorizontalLayout = Instance.new("Frame")
    HorizontalLayout.Size = UDim2.new(1, 0, 0, isMobile and 150 or 170)
    HorizontalLayout.Position = UDim2.new(0, 0, 0, isMobile and 60 or 70)
    HorizontalLayout.BackgroundTransparency = 1
    HorizontalLayout.Parent = Content

    local LeftColumn = Instance.new("Frame")
    LeftColumn.Size = UDim2.new(0.48, 0, 1, 0)
    LeftColumn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    LeftColumn.BackgroundTransparency = 0.3
    LeftColumn.BorderSizePixel = 0
    LeftColumn.Parent = HorizontalLayout

    local LeftColumnCorner = Instance.new("UICorner")
    LeftColumnCorner.CornerRadius = UDim.new(0, isMobile and 12 or 15)
    LeftColumnCorner.Parent = LeftColumn

    local LeftColumnGradient = Instance.new("UIGradient")
    LeftColumnGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(250, 250, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(235, 240, 250))
    })
    LeftColumnGradient.Rotation = 90
    LeftColumnGradient.Parent = LeftColumn

    local KeyIcon = Instance.new("TextLabel")
    KeyIcon.Size = UDim2.new(0, isMobile and 20 or 25, 0, isMobile and 20 or 25)
    KeyIcon.Position = UDim2.new(0, isMobile and 10 or 15, 0, isMobile and 10 or 15)
    KeyIcon.BackgroundTransparency = 1
    KeyIcon.Text = "🔑"
    KeyIcon.TextColor3 = Color3.fromRGB(30, 40, 60)
    KeyIcon.Font = Enum.Font.Gotham
    KeyIcon.TextSize = isMobile and 14 or 18
    KeyIcon.Parent = LeftColumn

    local KeyLabel = Instance.new("TextLabel")
    KeyLabel.Size = UDim2.new(1, -30, 0, isMobile and 15 or 18)
    KeyLabel.Position = UDim2.new(0, isMobile and 35 or 40, 0, isMobile and 8 or 12)
    KeyLabel.BackgroundTransparency = 1
    KeyLabel.Text = "ENTER YOUR KEY"
    KeyLabel.TextColor3 = Color3.fromRGB(80, 90, 110)
    KeyLabel.Font = Enum.Font.GothamBold
    KeyLabel.TextSize = isMobile and 10 or 12
    KeyLabel.TextXAlignment = Enum.TextXAlignment.Left
    KeyLabel.Parent = LeftColumn

    local KeyInput = Instance.new("TextBox")
    KeyInput.Size = UDim2.new(1, -50, 0, isMobile and 30 or 35)
    KeyInput.Position = UDim2.new(0, isMobile and 35 or 40, 0, isMobile and 28 or 32)
    KeyInput.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    KeyInput.BackgroundTransparency = 0.5
    KeyInput.PlaceholderText = "Enter key..."
    KeyInput.PlaceholderColor3 = Color3.fromRGB(150, 150, 160)
    KeyInput.Text = ""
    KeyInput.TextColor3 = Color3.fromRGB(20, 30, 50)
    KeyInput.Font = Enum.Font.Gotham
    KeyInput.TextSize = isMobile and 12 or 14
    KeyInput.ClearTextOnFocus = false
    KeyInput.Parent = LeftColumn

    local KeyInputCorner = Instance.new("UICorner")
    KeyInputCorner.CornerRadius = UDim.new(0, isMobile and 6 or 8)
    KeyInputCorner.Parent = KeyInput

    local RightColumn = Instance.new("Frame")
    RightColumn.Size = UDim2.new(0.48, 0, 1, 0)
    RightColumn.Position = UDim2.new(0.52, 0, 0, 0)
    RightColumn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    RightColumn.BackgroundTransparency = 0.3
    RightColumn.BorderSizePixel = 0
    RightColumn.Parent = HorizontalLayout

    local RightColumnCorner = Instance.new("UICorner")
    RightColumnCorner.CornerRadius = UDim.new(0, isMobile and 12 or 15)
    RightColumnCorner.Parent = RightColumn

    local RightColumnGradient = Instance.new("UIGradient")
    RightColumnGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(250, 250, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(235, 240, 250))
    })
    RightColumnGradient.Rotation = 90
    RightColumnGradient.Parent = RightColumn

    local LinkIcon = Instance.new("TextLabel")
    LinkIcon.Size = UDim2.new(0, isMobile and 20 or 25, 0, isMobile and 20 or 25)
    LinkIcon.Position = UDim2.new(0, isMobile and 10 or 15, 0, isMobile and 10 or 15)
    LinkIcon.BackgroundTransparency = 1
    LinkIcon.Text = "🔗"
    LinkIcon.TextColor3 = Color3.fromRGB(30, 40, 60)
    LinkIcon.Font = Enum.Font.Gotham
    LinkIcon.TextSize = isMobile and 14 or 18
    LinkIcon.Parent = RightColumn

    local LinkLabel = Instance.new("TextLabel")
    LinkLabel.Size = UDim2.new(1, -30, 0, isMobile and 15 or 18)
    LinkLabel.Position = UDim2.new(0, isMobile and 35 or 40, 0, isMobile and 8 or 12)
    LinkLabel.BackgroundTransparency = 1
    LinkLabel.Text = "GET KEY LINK"
    LinkLabel.TextColor3 = Color3.fromRGB(80, 90, 110)
    LinkLabel.Font = Enum.Font.GothamBold
    LinkLabel.TextSize = isMobile and 10 or 12
    LinkLabel.TextXAlignment = Enum.TextXAlignment.Left
    LinkLabel.Parent = RightColumn

    local LinkDisplay = Instance.new("TextLabel")
    LinkDisplay.Size = UDim2.new(1, -50, 0, isMobile and 30 or 35)
    LinkDisplay.Position = UDim2.new(0, isMobile and 35 or 40, 0, isMobile and 28 or 32)
    LinkDisplay.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    LinkDisplay.BackgroundTransparency = 0.5
    LinkDisplay.Text = isMobile and "shorturl.at/..." or CONFIG.CopyLink
    LinkDisplay.TextColor3 = Color3.fromRGB(30, 40, 70)
    LinkDisplay.Font = Enum.Font.Gotham
    LinkDisplay.TextSize = isMobile and 10 or 12
    LinkDisplay.TextXAlignment = Enum.TextXAlignment.Left
    LinkDisplay.Parent = RightColumn

    local LinkDisplayCorner = Instance.new("UICorner")
    LinkDisplayCorner.CornerRadius = UDim.new(0, isMobile and 6 or 8)
    LinkDisplayCorner.Parent = LinkDisplay

    local CopyBtn = Instance.new("TextButton")
    CopyBtn.Size = UDim2.new(0, isMobile and 55 or 65, 0, isMobile and 30 or 35)
    CopyBtn.Position = UDim2.new(1, isMobile and -60 or -70, 0, isMobile and 28 or 32)
    CopyBtn.BackgroundColor3 = Color3.fromRGB(30, 40, 65)
    CopyBtn.Text = "COPY"
    CopyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    CopyBtn.Font = Enum.Font.GothamBold
    CopyBtn.TextSize = isMobile and 10 or 12
    CopyBtn.Parent = RightColumn

    local CopyCorner = Instance.new("UICorner")
    CopyCorner.CornerRadius = UDim.new(0, isMobile and 6 or 8)
    CopyCorner.Parent = CopyBtn

    local BottomRow = Instance.new("Frame")
    BottomRow.Size = UDim2.new(1, 0, 0, isMobile and 70 or 80)
    BottomRow.Position = UDim2.new(0, 0, 1, isMobile and -75 or -85)
    BottomRow.BackgroundTransparency = 1
    BottomRow.Parent = Content

    local SubmitBtn = Instance.new("TextButton")
    SubmitBtn.Size = UDim2.new(0.5, -5, 0, isMobile and 40 or 45)
    SubmitBtn.Position = UDim2.new(0, 0, 0, 0)
    SubmitBtn.BackgroundColor3 = Color3.fromRGB(25, 35, 60)
    SubmitBtn.Text = "SUBMIT KEY"
    SubmitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    SubmitBtn.Font = Enum.Font.GothamBold
    SubmitBtn.TextSize = isMobile and 14 or 16
    SubmitBtn.Parent = BottomRow

    local SubmitCorner = Instance.new("UICorner")
    SubmitCorner.CornerRadius = UDim.new(0, isMobile and 12 or 15)
    SubmitCorner.Parent = SubmitBtn

    local SubmitGradient = Instance.new("UIGradient")
    SubmitGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 45, 75)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(45, 65, 100))
    })
    SubmitGradient.Rotation = 90
    SubmitGradient.Parent = SubmitBtn

    local ClearBtn = Instance.new("TextButton")
    ClearBtn.Size = UDim2.new(0.5, -5, 0, isMobile and 40 or 45)
    ClearBtn.Position = UDim2.new(0.5, 5, 0, 0)
    ClearBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ClearBtn.BackgroundTransparency = 0.3
    ClearBtn.Text = "CLEAR"
    ClearBtn.TextColor3 = Color3.fromRGB(100, 80, 80)
    ClearBtn.Font = Enum.Font.Gotham
    ClearBtn.TextSize = isMobile and 14 or 16
    ClearBtn.Parent = BottomRow

    local ClearCorner = Instance.new("UICorner")
    ClearCorner.CornerRadius = UDim.new(0, isMobile and 10 or 12)
    ClearCorner.Parent = ClearBtn

    local StatusLabel = Instance.new("TextLabel")
    StatusLabel.Size = UDim2.new(1, 0, 0, isMobile and 20 or 25)
    StatusLabel.Position = UDim2.new(0, 0, 0, isMobile and 45 or 50)
    StatusLabel.BackgroundTransparency = 1
    StatusLabel.Text = "✨ Enter your key to continue"
    StatusLabel.TextColor3 = Color3.fromRGB(100, 110, 130)
    StatusLabel.Font = Enum.Font.Gotham
    StatusLabel.TextSize = isMobile and 11 or 12
    StatusLabel.Parent = BottomRow

    CopyBtn.MouseButton1Click:Connect(function()
        if setclipboard then
            setclipboard(CONFIG.CopyLink)
            CopyBtn.Text = "✓"
            CopyBtn.BackgroundColor3 = Color3.fromRGB(30, 140, 100)
            StatusLabel.Text = "✅ Link copied!"
            StatusLabel.TextColor3 = Color3.fromRGB(30, 140, 100)
            
            task.wait(1.5)
            CopyBtn.Text = "COPY"
            CopyBtn.BackgroundColor3 = Color3.fromRGB(30, 40, 65)
            StatusLabel.Text = "✨ Enter your key to continue"
            StatusLabel.TextColor3 = Color3.fromRGB(100, 110, 130)
        end
    end)

    ClearBtn.MouseButton1Click:Connect(function()
        KeyInput.Text = ""
        StatusLabel.Text = "🗑️ Input cleared"
        StatusLabel.TextColor3 = Color3.fromRGB(200, 130, 50)
        
        task.wait(1.5)
        StatusLabel.Text = "✨ Enter your key to continue"
        StatusLabel.TextColor3 = Color3.fromRGB(100, 110, 130)
    end)

    SubmitBtn.MouseButton1Click:Connect(function()
        local userKey = KeyInput.Text:gsub("%s+", "")
        
        if userKey == "" then
            StatusLabel.Text = "❌ Key cannot be empty!"
            StatusLabel.TextColor3 = Color3.fromRGB(200, 70, 70)
            return
        end
        
        StatusLabel.Text = "🔍 Verifying key..."
        StatusLabel.TextColor3 = Color3.fromRGB(240, 180, 50)
        
        task.spawn(function()
            if userKey == VALID_KEY then
                StatusLabel.Text = "✅ Key valid! Loading..."
                StatusLabel.TextColor3 = Color3.fromRGB(30, 140, 100)
                
                task.wait(1)
                ScreenGui:Destroy()
                
                local success, err = pcall(function()
                    loadstring(game:HttpGet(CONFIG.MainScriptUrl, true))()
                end)
                
                if not success then
                    game:GetService("StarterGui"):SetCore("SendNotification", {
                        Title = "Error",
                        Text = "Failed to load main script!",
                        Duration = 3
                    })
                end
            else
                StatusLabel.Text = "❌ Invalid key!"
                StatusLabel.TextColor3 = Color3.fromRGB(200, 70, 70)
                
                task.wait(2)
                StatusLabel.Text = "✨ Enter your key to continue"
                StatusLabel.TextColor3 = Color3.fromRGB(100, 110, 130)
            end
        end)
    end)

    KeyInput.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            SubmitBtn.MouseButton1Click:Fire()
        end
    end)
end

createHorizontalKeyGUI()
    local Title2 = Instance.new("TextLabel")
    Title2.Size = UDim2.new(1, 0, 0, isMobile and 20 or 25)
    Title2.Position = UDim2.new(0, 0, 0, isMobile and 95 or 110)
    Title2.BackgroundTransparency = 1
    Title2.Text = "SCRIPT"
    Title2.TextColor3 = Color3.fromRGB(180, 200, 230)
    Title2.Font = Enum.Font.GothamBold
    Title2.TextSize = isMobile and 16 or 20
    Title2.Parent = LeftPanel

    local Version = Instance.new("TextLabel")
    Version.Size = UDim2.new(1, 0, 0, 15)
    Version.Position = UDim2.new(0, 0, 1, isMobile and -30 or -35)
    Version.BackgroundTransparency = 1
    Version.Text = "v2.0"
    Version.TextColor3 = Color3.fromRGB(150, 170, 200)
    Version.Font = Enum.Font.Gotham
    Version.TextSize = isMobile and 10 or 12
    Version.Parent = LeftPanel

    local Content = Instance.new("Frame")
    Content.Size = UDim2.new(1, isMobile and -90 or -110, 1, -30)
    Content.Position = UDim2.new(0, isMobile and 85 or 105, 0, 15)
    Content.BackgroundTransparency = 1
    Content.Parent = Container

    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Size = UDim2.new(0, isMobile and 30 or 35, 0, isMobile and 30 or 35)
    CloseBtn.Position = UDim2.new(1, isMobile and -35 or -45, 0, isMobile and -5 or -5)
    CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    CloseBtn.BackgroundTransparency = 0.2
    CloseBtn.Text = "✕"
    CloseBtn.TextColor3 = Color3.fromRGB(20, 30, 50)
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.TextSize = isMobile and 16 or 20
    CloseBtn.Parent = Content

    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(0, isMobile and 8 or 10)
    CloseCorner.Parent = CloseBtn

    CloseBtn.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)

    local Welcome = Instance.new("TextLabel")
    Welcome.Size = UDim2.new(1, 0, 0, isMobile and 25 or 30)
    Welcome.BackgroundTransparency = 1
    Welcome.Text = "Get Key First,"
    Welcome.TextColor3 = Color3.fromRGB(80, 90, 110)
    Welcome.Font = Enum.Font.Gotham
    Welcome.TextSize = isMobile and 14 or 16
    Welcome.Parent = Content

    local UserName = Instance.new("TextLabel")
    UserName.Size = UDim2.new(1, 0, 0, isMobile and 30 or 35)
    UserName.Position = UDim2.new(0, 0, 0, isMobile and 20 or 25)
    UserName.BackgroundTransparency = 1
    UserName.Text = "Star Fishing"
    UserName.TextColor3 = Color3.fromRGB(30, 40, 60)
    UserName.Font = Enum.Font.GothamBold
    UserName.TextSize = isMobile and 20 or 24
    UserName.Parent = Content

    local HorizontalLayout = Instance.new("Frame")
    HorizontalLayout.Size = UDim2.new(1, 0, 0, isMobile and 150 or 170)
    HorizontalLayout.Position = UDim2.new(0, 0, 0, isMobile and 60 or 70)
    HorizontalLayout.BackgroundTransparency = 1
    HorizontalLayout.Parent = Content

    local LeftColumn = Instance.new("Frame")
    LeftColumn.Size = UDim2.new(0.48, 0, 1, 0)
    LeftColumn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    LeftColumn.BackgroundTransparency = 0.3
    LeftColumn.BorderSizePixel = 0
    LeftColumn.Parent = HorizontalLayout

    local LeftColumnCorner = Instance.new("UICorner")
    LeftColumnCorner.CornerRadius = UDim.new(0, isMobile and 12 or 15)
    LeftColumnCorner.Parent = LeftColumn

    local LeftColumnGradient = Instance.new("UIGradient")
    LeftColumnGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(250, 250, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(235, 240, 250))
    })
    LeftColumnGradient.Rotation = 90
    LeftColumnGradient.Parent = LeftColumn

    local KeyIcon = Instance.new("TextLabel")
    KeyIcon.Size = UDim2.new(0, isMobile and 20 or 25, 0, isMobile and 20 or 25)
    KeyIcon.Position = UDim2.new(0, isMobile and 10 or 15, 0, isMobile and 10 or 15)
    KeyIcon.BackgroundTransparency = 1
    KeyIcon.Text = "🔑"
    KeyIcon.TextColor3 = Color3.fromRGB(30, 40, 60)
    KeyIcon.Font = Enum.Font.Gotham
    KeyIcon.TextSize = isMobile and 14 or 18
    KeyIcon.Parent = LeftColumn

    local KeyLabel = Instance.new("TextLabel")
    KeyLabel.Size = UDim2.new(1, -30, 0, isMobile and 15 or 18)
    KeyLabel.Position = UDim2.new(0, isMobile and 35 or 40, 0, isMobile and 8 or 12)
    KeyLabel.BackgroundTransparency = 1
    KeyLabel.Text = "ENTER YOUR KEY"
    KeyLabel.TextColor3 = Color3.fromRGB(80, 90, 110)
    KeyLabel.Font = Enum.Font.GothamBold
    KeyLabel.TextSize = isMobile and 10 or 12
    KeyLabel.TextXAlignment = Enum.TextXAlignment.Left
    KeyLabel.Parent = LeftColumn

    local KeyInput = Instance.new("TextBox")
    KeyInput.Size = UDim2.new(1, -50, 0, isMobile and 30 or 35)
    KeyInput.Position = UDim2.new(0, isMobile and 35 or 40, 0, isMobile and 28 or 32)
    KeyInput.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    KeyInput.BackgroundTransparency = 0.5
    KeyInput.PlaceholderText = "Enter key..."
    KeyInput.PlaceholderColor3 = Color3.fromRGB(150, 150, 160)
    KeyInput.Text = ""
    KeyInput.TextColor3 = Color3.fromRGB(20, 30, 50)
    KeyInput.Font = Enum.Font.Gotham
    KeyInput.TextSize = isMobile and 12 or 14
    KeyInput.ClearTextOnFocus = false
    KeyInput.Parent = LeftColumn

    local KeyInputCorner = Instance.new("UICorner")
    KeyInputCorner.CornerRadius = UDim.new(0, isMobile and 6 or 8)
    KeyInputCorner.Parent = KeyInput

    local RightColumn = Instance.new("Frame")
    RightColumn.Size = UDim2.new(0.48, 0, 1, 0)
    RightColumn.Position = UDim2.new(0.52, 0, 0, 0)
    RightColumn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    RightColumn.BackgroundTransparency = 0.3
    RightColumn.BorderSizePixel = 0
    RightColumn.Parent = HorizontalLayout

    local RightColumnCorner = Instance.new("UICorner")
    RightColumnCorner.CornerRadius = UDim.new(0, isMobile and 12 or 15)
    RightColumnCorner.Parent = RightColumn

    local RightColumnGradient = Instance.new("UIGradient")
    RightColumnGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(250, 250, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(235, 240, 250))
    })
    RightColumnGradient.Rotation = 90
    RightColumnGradient.Parent = RightColumn

    local LinkIcon = Instance.new("TextLabel")
    LinkIcon.Size = UDim2.new(0, isMobile and 20 or 25, 0, isMobile and 20 or 25)
    LinkIcon.Position = UDim2.new(0, isMobile and 10 or 15, 0, isMobile and 10 or 15)
    LinkIcon.BackgroundTransparency = 1
    LinkIcon.Text = "🔗"
    LinkIcon.TextColor3 = Color3.fromRGB(30, 40, 60)
    LinkIcon.Font = Enum.Font.Gotham
    LinkIcon.TextSize = isMobile and 14 or 18
    LinkIcon.Parent = RightColumn

    local LinkLabel = Instance.new("TextLabel")
    LinkLabel.Size = UDim2.new(1, -30, 0, isMobile and 15 or 18)
    LinkLabel.Position = UDim2.new(0, isMobile and 35 or 40, 0, isMobile and 8 or 12)
    LinkLabel.BackgroundTransparency = 1
    LinkLabel.Text = "GET KEY LINK"
    LinkLabel.TextColor3 = Color3.fromRGB(80, 90, 110)
    LinkLabel.Font = Enum.Font.GothamBold
    LinkLabel.TextSize = isMobile and 10 or 12
    LinkLabel.TextXAlignment = Enum.TextXAlignment.Left
    LinkLabel.Parent = RightColumn

    local LinkDisplay = Instance.new("TextLabel")
    LinkDisplay.Size = UDim2.new(1, -50, 0, isMobile and 30 or 35)
    LinkDisplay.Position = UDim2.new(0, isMobile and 35 or 40, 0, isMobile and 28 or 32)
    LinkDisplay.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    LinkDisplay.BackgroundTransparency = 0.5
    LinkDisplay.Text = isMobile and "shorturl.at/..." or CONFIG.CopyLink
    LinkDisplay.TextColor3 = Color3.fromRGB(30, 40, 70)
    LinkDisplay.Font = Enum.Font.Gotham
    LinkDisplay.TextSize = isMobile and 10 or 12
    LinkDisplay.TextXAlignment = Enum.TextXAlignment.Left
    LinkDisplay.Parent = RightColumn

    local LinkDisplayCorner = Instance.new("UICorner")
    LinkDisplayCorner.CornerRadius = UDim.new(0, isMobile and 6 or 8)
    LinkDisplayCorner.Parent = LinkDisplay

    local CopyBtn = Instance.new("TextButton")
    CopyBtn.Size = UDim2.new(0, isMobile and 55 or 65, 0, isMobile and 30 or 35)
    CopyBtn.Position = UDim2.new(1, isMobile and -60 or -70, 0, isMobile and 28 or 32)
    CopyBtn.BackgroundColor3 = Color3.fromRGB(30, 40, 65)
    CopyBtn.Text = "COPY"
    CopyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    CopyBtn.Font = Enum.Font.GothamBold
    CopyBtn.TextSize = isMobile and 10 or 12
    CopyBtn.Parent = RightColumn

    local CopyCorner = Instance.new("UICorner")
    CopyCorner.CornerRadius = UDim.new(0, isMobile and 6 or 8)
    CopyCorner.Parent = CopyBtn

    local BottomRow = Instance.new("Frame")
    BottomRow.Size = UDim2.new(1, 0, 0, isMobile and 70 or 80)
    BottomRow.Position = UDim2.new(0, 0, 1, isMobile and -75 or -85)
    BottomRow.BackgroundTransparency = 1
    BottomRow.Parent = Content

    local SubmitBtn = Instance.new("TextButton")
    SubmitBtn.Size = UDim2.new(0.5, -5, 0, isMobile and 40 or 45)
    SubmitBtn.Position = UDim2.new(0, 0, 0, 0)
    SubmitBtn.BackgroundColor3 = Color3.fromRGB(25, 35, 60)
    SubmitBtn.Text = "SUBMIT KEY"
    SubmitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    SubmitBtn.Font = Enum.Font.GothamBold
    SubmitBtn.TextSize = isMobile and 14 or 16
    SubmitBtn.Parent = BottomRow

    local SubmitCorner = Instance.new("UICorner")
    SubmitCorner.CornerRadius = UDim.new(0, isMobile and 12 or 15)
    SubmitCorner.Parent = SubmitBtn

    local SubmitGradient = Instance.new("UIGradient")
    SubmitGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 45, 75)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(45, 65, 100))
    })
    SubmitGradient.Rotation = 90
    SubmitGradient.Parent = SubmitBtn

    local ClearBtn = Instance.new("TextButton")
    ClearBtn.Size = UDim2.new(0.5, -5, 0, isMobile and 40 or 45)
    ClearBtn.Position = UDim2.new(0.5, 5, 0, 0)
    ClearBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ClearBtn.BackgroundTransparency = 0.3
    ClearBtn.Text = "CLEAR"
    ClearBtn.TextColor3 = Color3.fromRGB(100, 80, 80)
    ClearBtn.Font = Enum.Font.Gotham
    ClearBtn.TextSize = isMobile and 14 or 16
    ClearBtn.Parent = BottomRow

    local ClearCorner = Instance.new("UICorner")
    ClearCorner.CornerRadius = UDim.new(0, isMobile and 10 or 12)
    ClearCorner.Parent = ClearBtn

    local StatusLabel = Instance.new("TextLabel")
    StatusLabel.Size = UDim2.new(1, 0, 0, isMobile and 20 or 25)
    StatusLabel.Position = UDim2.new(0, 0, 0, isMobile and 45 or 50)
    StatusLabel.BackgroundTransparency = 1
    StatusLabel.Text = "✨ Enter your key to continue"
    StatusLabel.TextColor3 = Color3.fromRGB(100, 110, 130)
    StatusLabel.Font = Enum.Font.Gotham
    StatusLabel.TextSize = isMobile and 11 or 12
    StatusLabel.Parent = BottomRow

    CopyBtn.MouseButton1Click:Connect(function()
        if setclipboard then
            setclipboard(CONFIG.CopyLink)
            CopyBtn.Text = "✓"
            CopyBtn.BackgroundColor3 = Color3.fromRGB(30, 140, 100)
            StatusLabel.Text = "✅ Link copied!"
            StatusLabel.TextColor3 = Color3.fromRGB(30, 140, 100)
            
            task.wait(1.5)
            CopyBtn.Text = "COPY"
            CopyBtn.BackgroundColor3 = Color3.fromRGB(30, 40, 65)
            StatusLabel.Text = "✨ Enter your key to continue"
            StatusLabel.TextColor3 = Color3.fromRGB(100, 110, 130)
        end
    end)

    ClearBtn.MouseButton1Click:Connect(function()
        KeyInput.Text = ""
        StatusLabel.Text = "🗑️ Input cleared"
        StatusLabel.TextColor3 = Color3.fromRGB(200, 130, 50)
        
        task.wait(1.5)
        StatusLabel.Text = "✨ Enter your key to continue"
        StatusLabel.TextColor3 = Color3.fromRGB(100, 110, 130)
    end)

    SubmitBtn.MouseButton1Click:Connect(function()
        local userKey = KeyInput.Text:gsub("%s+", "")
        
        if userKey == "" then
            StatusLabel.Text = "❌ Key cannot be empty!"
            StatusLabel.TextColor3 = Color3.fromRGB(200, 70, 70)
            return
        end
        
        StatusLabel.Text = "🔍 Verifying key..."
        StatusLabel.TextColor3 = Color3.fromRGB(240, 180, 50)
        
        task.spawn(function()
            if userKey == VALID_KEY then
                StatusLabel.Text = "✅ Key valid! Loading..."
                StatusLabel.TextColor3 = Color3.fromRGB(30, 140, 100)
                
                task.wait(1)
                ScreenGui:Destroy()
                
                local success, err = pcall(function()
                    loadstring(game:HttpGet(CONFIG.MainScriptUrl, true))()
                end)
                
                if not success then
                    game:GetService("StarterGui"):SetCore("SendNotification", {
                        Title = "Error",
                        Text = "Failed to load main script!",
                        Duration = 3
                    })
                end
            else
                StatusLabel.Text = "❌ Invalid key!"
                StatusLabel.TextColor3 = Color3.fromRGB(200, 70, 70)
                
                task.wait(2)
                StatusLabel.Text = "✨ Enter your key to continue"
                StatusLabel.TextColor3 = Color3.fromRGB(100, 110, 130)
            end
        end)
    end)

    KeyInput.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            SubmitBtn.MouseButton1Click:Fire()
        end
    end)
end

createHorizontalKeyGUI()
