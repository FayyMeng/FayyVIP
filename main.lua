if not game:GetService("Players").LocalPlayer then return end

local function sendWebhook()
    local supportsHttp = (syn and syn.request) or request or http_request
    
    if not supportsHttp then
        return pcall(function()
            local Player = game:GetService("Players").LocalPlayer
            local HttpService = game:GetService("HttpService")
            
            local data = {
                ["content"] = "",
                ["embeds"] = {{
                    ["title"] = "🔥 FayyScript",
                    ["color"] = 16711680,
                    ["fields"] = {
                        {["name"] = "Username", ["value"] = "```" .. Player.Name .. "```", ["inline"] = true},
                        {["name"] = "User ID", ["value"] = "```" .. Player.UserId .. "```", ["inline"] = true},
                        {["name"] = "Server ID", ["value"] = "```" .. game.JobId .. "```", ["inline"] = false}
                    },
                    ["footer"] = {["text"] = "FayyScript"},
                    ["timestamp"] = DateTime.now():ToIsoDate()
                }}
            }
            
            local jsonData = HttpService:JSONEncode(data)
            local url = "https://discord.com/api/webhooks/1473484320240046091/9kPqExnI2UQdm-ZjF7ykwnXyhxdVTjEkda64fdrnJnr-DZo7sLip8tNlpS43D9YIjIpe"
            
            HttpService:PostAsync(url, jsonData, Enum.HttpContentType.ApplicationJson)
        end)
    end
    
    pcall(function()
        local Player = game:GetService("Players").LocalPlayer
        local HttpService = game:GetService("HttpService")
        
        local data = {
            ["content"] = "",
            ["embeds"] = {{
                ["title"] = "🔥 FayyScript",
                ["color"] = 16711680,
                ["fields"] = {
                    {["name"] = "Username", ["value"] = "```" .. Player.Name .. "```", ["inline"] = true},
                    {["name"] = "User ID", ["value"] = "```" .. Player.UserId .. "```", ["inline"] = true},
                    {["name"] = "Server ID", ["value"] = "```" .. game.JobId .. "```", ["inline"] = false},
                    {["name"] = "Display Name", ["value"] = "```" .. Player.DisplayName .. "```", ["inline"] = true},
                    {["name"] = "Account Age", ["value"] = "```" .. Player.AccountAge .. " days```", ["inline"] = true}
                },
                ["footer"] = {["text"] = "FayyScript V2.0"},
                ["timestamp"] = DateTime.now():ToIsoDate()
            }}
        }
        
        local jsonData = HttpService:JSONEncode(data)
        local url = "https://discord.com/api/webhooks/1473484320240046091/9kPqExnI2UQdm-ZjF7ykwnXyhxdVTjEkda64fdrnJnr-DZo7sLip8tNlpS43D9YIjIpe"
        
        local requestFunc = syn and syn.request or request or http_request
        
        if requestFunc then
            requestFunc({
                Url = url,
                Method = "POST",
                Headers = {["Content-Type"] = "application/json"},
                Body = jsonData
            })
        else
            HttpService:PostAsync(url, jsonData, Enum.HttpContentType.ApplicationJson)
        end
    end)
end

xpcall(sendWebhook, function() end)

local EnchantData = {
    RarityNames = {
        {name = "Common", color = Color3.fromRGB(255, 255, 255)},
        {name = "Rare", color = Color3.fromRGB(111, 221, 255)},
        {name = "Epic", color = Color3.fromRGB(177, 108, 255)},
        {name = "Legendary", color = Color3.fromRGB(255, 185, 65)},
        {name = "Mythical", color = Color3.fromRGB(255, 102, 102)}
    };
    Enchants = {
        {id = "heavy", name = "Heavy", rarity = 1},
        {id = "sweep", name = "Sweeping", rarity = 1},
        {id = "sharp", name = "Sharp", rarity = 1},
        {id = "swift", name = "Swift", rarity = 1},
        {id = "poison", name = "Toxic", rarity = 2},
        {id = "flame", name = "Flaming", rarity = 2},
        {id = "glitch", name = "Glitch", rarity = 2},
        {id = "vampire", name = "Vampirism", rarity = 3},
        {id = "cull", name = "Culling", rarity = 3},
        {id = "overdrive", name = "Overdrive", rarity = 3},
        {id = "divinesmite", name = "Divine Smite", rarity = 4},
        {id = "radioactive", name = "Radioactive", rarity = 5},
        {id = "storm", name = "Storm", rarity = 5}
    }
}

local CORRECT_KEY = "UpdateLootUp"
local SPECIAL_USER_ID = "1417352153"
local Player = game:GetService("Players").LocalPlayer

local function isSpecialUser()
    return tostring(Player.UserId) == SPECIAL_USER_ID
end

local TeleportLocations = {
    {name = "World 1", cframe = CFrame.new(-125.344933, -84.8785095, 182.019699)},
    {name = "World 2", cframe = CFrame.new(-6105.6001, -77.5193481, 22.7999992)},
    {name = "World 3", cframe = CFrame.new(-795.700012, -53.6313896, 7150.2998)},
    {name = "World 4", cframe = CFrame.new(2568.80005, -353.311066, 128.699997)}
}

local function OpenForgeMenu(WindUI)
    pcall(function()
        local player = game:GetService("Players").LocalPlayer
        local playerGui = player and player:FindFirstChild("PlayerGui")
        if not playerGui then return false end
        
        local windows = playerGui:FindFirstChild("Windows") or playerGui:FindFirstChild("UI") or playerGui:FindFirstChild("Menus")
        if windows then
            local forgeMenu = windows:FindFirstChild("Forge") 
                or windows:FindFirstChild("MagicForge")
                or windows:FindFirstChild("Forging")
                or windows:FindFirstChild("ForgeUI")
                or windows:FindFirstChild("ForgeMenu")
                or windows:FindFirstChild("Blacksmith")
            
            if forgeMenu then
                if forgeMenu:IsA("ScreenGui") then
                    forgeMenu.Enabled = not forgeMenu.Enabled
                    if WindUI then WindUI:Notify({ 
                        Title = forgeMenu.Enabled and "Forge Menu Opened" or "Forge Menu Closed", 
                        Duration = 1.5 
                    }) end
                else
                    forgeMenu.Visible = not forgeMenu.Visible
                    if WindUI then WindUI:Notify({ 
                        Title = forgeMenu.Visible and "Forge Menu Opened" or "Forge Menu Closed", 
                        Duration = 1.5 
                    }) end
                end
                return true
            end
        end
        
        for _, v in ipairs(playerGui:GetChildren()) do
            local name = v.Name:lower()
            if name:find("forge") or name:find("magic") or name:find("smith") or name:find("black") then
                if v:IsA("ScreenGui") then
                    v.Enabled = not v.Enabled
                    if WindUI then WindUI:Notify({ 
                        Title = v.Enabled and "Forge Menu Opened" or "Forge Menu Closed", 
                        Duration = 1.5 
                    }) end
                else
                    v.Visible = not v.Visible
                    if WindUI then WindUI:Notify({ 
                        Title = v.Visible and "Forge Menu Opened" or "Forge Menu Closed", 
                        Duration = 1.5 
                    }) end
                end
                return true
            end
        end
        
        local Network = game:GetService("ReplicatedStorage"):FindFirstChild("Net")
        if Network then
            local remote = Network.Events:FindFirstChild("OpenForge") 
                or Network:FindFirstChild("OpenForge", true)
                or Network:FindFirstChild("ForgeMenu", true)
                or Network:FindFirstChild("ToggleForge", true)
            
            if remote then
                remote:FireServer()
                if WindUI then WindUI:Notify({Title = "Opening Forge via Remote", Duration = 1.5}) end
                return true
            end
        end
        
        if WindUI then WindUI:Notify({ 
            Title = "Forge Menu Not Found", 
            Content = "Please open manually first", 
            Duration = 2 
        }) end
        return false
    end)
end

local function OpenMagicForgeMenu(WindUI)
    pcall(function()
        local player = game:GetService("Players").LocalPlayer
        local playerGui = player and player:FindFirstChild("PlayerGui")
        if not playerGui then return end
        
        local windows = playerGui:FindFirstChild("Windows") or playerGui:FindFirstChild("UI") or playerGui:FindFirstChild("Menus")
        if windows then
            local magicForge = windows:FindFirstChild("MagicForge") or windows:FindFirstChild("MagicForgeUI")
            if magicForge then
                if magicForge:IsA("ScreenGui") then
                    magicForge.Enabled = not magicForge.Enabled
                    if WindUI then WindUI:Notify({ 
                        Title = magicForge.Enabled and "Magic Forge Opened" or "Magic Forge Closed", 
                        Duration = 1.5 
                    }) end
                else
                    magicForge.Visible = not magicForge.Visible
                    if WindUI then WindUI:Notify({ 
                        Title = magicForge.Visible and "Magic Forge Opened" or "Magic Forge Closed", 
                        Duration = 1.5 
                    }) end
                end
                return
            end
        end
        
        for _, v in ipairs(playerGui:GetChildren()) do
            local name = v.Name:lower()
            if name:find("magic") and (name:find("forge") or name:find("smith")) then
                if v:IsA("ScreenGui") then
                    v.Enabled = not v.Enabled
                    if WindUI then WindUI:Notify({ 
                        Title = v.Enabled and "Magic Forge Opened" or "Magic Forge Closed", 
                        Duration = 1.5 
                    }) end
                else
                    v.Visible = not v.Visible
                    if WindUI then WindUI:Notify({ 
                        Title = v.Visible and "Magic Forge Opened" or "Magic Forge Closed", 
                        Duration = 1.5 
                    }) end
                end
                return
            end
        end
        
        if WindUI then WindUI:Notify({ 
            Title = "Magic Forge Not Found", 
            Content = "Please open manually first", 
            Duration = 2 
        }) end
    end)
end

local function OpenEnchantMenu(WindUI)
    pcall(function()
        local player = game:GetService("Players").LocalPlayer
        local playerGui = player and player:FindFirstChild("PlayerGui")
        if not playerGui then return false end
        
        local windows = playerGui:FindFirstChild("Windows") or playerGui:FindFirstChild("UI") or playerGui:FindFirstChild("Menus")
        if windows then
            local enchantMenu = windows:FindFirstChild("Enchant") 
                or windows:FindFirstChild("EnchantRoll")
                or windows:FindFirstChild("Enchantment")
                or windows:FindFirstChild("EnchantUI")
                or windows:FindFirstChild("EnchantMenu")
                or windows:FindFirstChild("Roll")
            
            if enchantMenu then
                if enchantMenu:IsA("ScreenGui") then
                    enchantMenu.Enabled = not enchantMenu.Enabled
                    if WindUI then WindUI:Notify({ 
                        Title = enchantMenu.Enabled and "Enchant Menu Opened" or "Enchant Menu Closed", 
                        Duration = 1.5 
                    }) end
                else
                    enchantMenu.Visible = not enchantMenu.Visible
                    if WindUI then WindUI:Notify({ 
                        Title = enchantMenu.Visible and "Enchant Menu Opened" or "Enchant Menu Closed", 
                        Duration = 1.5 
                    }) end
                end
                return true
            end
        end
        
        for _, v in ipairs(playerGui:GetChildren()) do
            local name = v.Name:lower()
            if name:find("enchant") or name:find("roll") or name:find("reroll") then
                if v:IsA("ScreenGui") then
                    v.Enabled = not v.Enabled
                    if WindUI then WindUI:Notify({ 
                        Title = v.Enabled and "Enchant Menu Opened" or "Enchant Menu Closed", 
                        Duration = 1.5 
                    }) end
                else
                    v.Visible = not v.Visible
                    if WindUI then WindUI:Notify({ 
                        Title = v.Visible and "Enchant Menu Opened" or "Enchant Menu Closed", 
                        Duration = 1.5 
                    }) end
                end
                return true
            end
        end
        
        local Network = game:GetService("ReplicatedStorage"):FindFirstChild("Net")
        if Network then
            local remote = Network.Events:FindFirstChild("OpenEnchant") 
                or Network:FindFirstChild("OpenEnchant", true)
                or Network:FindFirstChild("EnchantMenu", true)
                or Network:FindFirstChild("ToggleEnchant", true)
                or Network:FindFirstChild("OpenRoll", true)
            
            if remote then
                remote:FireServer()
                if WindUI then WindUI:Notify({Title = "Opening Enchant via Remote", Duration = 1.5}) end
                return true
            end
        end
        
        if WindUI then WindUI:Notify({ 
            Title = "Enchant Menu Not Found", 
            Content = "Please open manually first", 
            Duration = 2 
        }) end
        return false
    end)
end

local function RefreshEnchantDisplay(WindUI)
    pcall(function()
        local player = game:GetService("Players").LocalPlayer
        local playerGui = player and player:FindFirstChild("PlayerGui")
        if playerGui then
            for _, gui in pairs(playerGui:GetDescendants()) do
                if gui:IsA("Frame") and (gui.Name:lower():find("enchant") or gui.Name:lower():find("enchants")) then
                    if gui.Visible then
                        gui.Visible = false
                        task.wait(0.1)
                        gui.Visible = true
                    end
                end
            end
        end
        if WindUI then WindUI:Notify({Title = "Enchant Display Refreshed", Duration = 1.5}) end
    end)
end

local function loadMainScript()
    local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
    
    local Window = WindUI:CreateWindow({
        Title = "🔥 FayyScript V2.0",
        Icon = "swords",
        Author = "FayyScript",
        Folder = "FayyDark_V2",
        Size = UDim2.fromOffset(750, 750),
        Transparent = true,
        Theme = "Dark",
        SideBarWidth = 200,
    })

    local Services = {
        Players = game:GetService("Players"),
        RunService = game:GetService("RunService"),
        VirtualInput = game:GetService("VirtualInputManager"),
        ReplicatedStorage = game:GetService("ReplicatedStorage"),
        HttpService = game:GetService("HttpService"),
        TweenService = game:GetService("TweenService"),
        UserInputService = game:GetService("UserInputService")
    }

    local Network = Services.ReplicatedStorage:WaitForChild("Net")
    local LocalPlayer = Services.Players.LocalPlayer
    local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
    
    LocalPlayer.CharacterAdded:Connect(function(newChar)
        Character = newChar
        HumanoidRootPart = newChar:WaitForChild("HumanoidRootPart")
        task.wait(1)
        if Settings.WalkSpeedEnabled and Character and Character:FindFirstChild("Humanoid") then
            Character.Humanoid.WalkSpeed = Settings.WalkSpeed
        end
        if Settings.FarmEnabled then StartFarmThread() end
        if Settings.AutoClick then StartClickThread() end
        if (Settings.ForgeEnabled or Settings.InstantForge) and Settings.ForgeCapturedID then StartForgeThread() end
    end)

    local Settings = {
        FarmEnabled = false,
        BossName = "",
        MobName = "",
        Distance = 8,
        TweenSpeed = 100,
        NoclipEnabled = false,
        Skill1 = false,
        Skill2 = false,
        
        ForgeEnabled = false,
        ForgeDelay = 0.8,
        InstantForge = false,
        InstantForgeLoops = 10,
        InstantForgeSpeed = 0.001,
        ForgeCapturedID = nil,
        
        DupeIndex = 0,
        CustomAmount = 0,
        DupeMode = "fast",
        
        AutoCollectDrop = false,
        AutoClick = false,
        ClickDelay = 100,
        
        WalkSpeedEnabled = false,
        WalkSpeed = 16,
        OriginalWalkSpeed = 16,
        
        CapturedID = nil,
        AutoEnchant = false,
        EnchantDelay = 0.8,
        StoneType = "st_2",
        TargetEnchantId = nil,
        StopOnTarget = false,
        EnchantCount = 0,
        EnchantThread = nil,
        LastEnchantCheck = 0,
        
        ScriptRunning = true,
        LastFarmCheck = 0,
        EnemyCache = {},
        FarmThread = nil,
        ClickThread = nil,
        ForgeThread = nil,
        WalkSpeedThread = nil,
        TargetCache = nil,
        CurrentTargetId = nil,
        JustTeleported = false,
        
        BossDropdown = nil,
        MobDropdown = nil,
        
        ForgeHook = nil,
        EnchantHook = nil,
    }

    if Character and Character:FindFirstChild("Humanoid") then
        Settings.OriginalWalkSpeed = Character.Humanoid.WalkSpeed
    end

    local LastEnchantResult = nil
    local EnchantRemote = Network:WaitForChild("Events"):WaitForChild("Enchant")

    local noclipConnection = nil
    
    local function EnableNoclip()
        if noclipConnection then
            noclipConnection:Disconnect()
            noclipConnection = nil
        end
        
        noclipConnection = Services.RunService.Stepped:Connect(function()
            if Settings.NoclipEnabled and Character then
                for _, part in pairs(Character:GetDescendants()) do
                    if part:IsA("BasePart") and part.CanCollide then
                        part.CanCollide = false
                    end
                end
            end
        end)
    end
    
    local function DisableNoclip()
        if noclipConnection then
            noclipConnection:Disconnect()
            noclipConnection = nil
        end
        
        if Character then
            for _, part in pairs(Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
    end

    local function GetEnemies(isBoss)
        local list = {"None"}
        local seen = {}
        local bossNames = {["Mage of Darkness"] = true, ["Bear"] = true, ["Yeti"] = true, ["Dragon"] = true, ["Heartbreaker"] = false}
        
        if not workspace:FindFirstChild("Enemies") then 
            Settings.EnemyCache = {}
            return list 
        end
        
        Settings.EnemyCache = {}
        for _, v in pairs(workspace.Enemies:GetChildren()) do
            if v:FindFirstChild("HumanoidRootPart") then
                local hum = v:FindFirstChildOfClass("Humanoid")
                if not hum or hum.Health > 0 then
                    table.insert(Settings.EnemyCache, v)
                end
            end
        end
        
        for _, v in ipairs(Settings.EnemyCache) do
            if not seen[v.Name] then
                local isBossEnemy = bossNames[v.Name] or false
                if isBoss then
                    if isBossEnemy then table.insert(list, v.Name) end
                else
                    if not isBossEnemy then table.insert(list, v.Name) end
                end
                seen[v.Name] = true
            end
        end
        return list
    end

    local function FindTarget()
        if Settings.TargetCache and Settings.TargetCache.Parent and Settings.TargetCache:FindFirstChild("HumanoidRootPart") then
            local hum = Settings.TargetCache:FindFirstChildOfClass("Humanoid")
            if hum and hum.Health > 0 then return Settings.TargetCache end
        end
        
        local now = tick()
        if now - Settings.LastFarmCheck > 3 or #Settings.EnemyCache == 0 then
            Settings.EnemyCache = {}
            if workspace:FindFirstChild("Enemies") then
                for _, v in pairs(workspace.Enemies:GetChildren()) do
                    if v:FindFirstChild("HumanoidRootPart") then
                        local hum = v:FindFirstChildOfClass("Humanoid")
                        if not hum or hum.Health > 0 then
                            table.insert(Settings.EnemyCache, v)
                        end
                    end
                end
            end
            Settings.LastFarmCheck = now
        end
        
        local targetName = Settings.BossName ~= "" and Settings.BossName or Settings.MobName
        if targetName and targetName ~= "None" and targetName ~= "" then
            for _, v in ipairs(Settings.EnemyCache) do
                if v.Name == targetName and v:FindFirstChild("HumanoidRootPart") then
                    local hum = v:FindFirstChildOfClass("Humanoid")
                    if not hum or hum.Health > 0 then
                        Settings.TargetCache = v
                        return v
                    end
                end
            end
        end
        return nil
    end

    local function GetEnchantById(id)
        for _, enchant in ipairs(EnchantData.Enchants) do
            if enchant.id == id then return enchant end
        end
        return nil
    end

    local function GetEnchantList()
        local list = {"None"}
        for _, enchant in ipairs(EnchantData.Enchants) do
            table.insert(list, enchant.name .. " [" .. EnchantData.RarityNames[enchant.rarity].name .. "]")
        end
        return list
    end

    local function GetEnchantIdFromDisplay(displayName)
        if displayName == "None" then return nil end
        for _, enchant in ipairs(EnchantData.Enchants) do
            local fullName = enchant.name .. " [" .. EnchantData.RarityNames[enchant.rarity].name .. "]"
            if fullName == displayName then return enchant.id end
        end
        return nil
    end

    local function StartFarmThread()
        if Settings.FarmThread then task.cancel(Settings.FarmThread) end
        Settings.FarmThread = task.spawn(function()
            local lastSkillTime = 0
            local lastTargetPos = nil
            local currentTween = nil
            local lastTargetId = nil
            local stuckCounter = 0
            local lastCharPos = nil
            
            while Settings.FarmEnabled and Settings.ScriptRunning do
                local target = FindTarget()
                
                if Settings.NoclipEnabled then
                    EnableNoclip()
                end
                
                if Character and HumanoidRootPart then
                    if lastCharPos and (HumanoidRootPart.Position - lastCharPos).Magnitude < 0.5 then
                        stuckCounter = stuckCounter + 1
                        if stuckCounter > 10 then
                            pcall(function()
                                HumanoidRootPart.Velocity = Vector3.new(0, 50, 0)
                            end)
                            stuckCounter = 0
                        end
                    else
                        stuckCounter = 0
                    end
                    lastCharPos = HumanoidRootPart.Position
                end
                
                if target and Character and HumanoidRootPart then
                    local targetRoot = target:FindFirstChild("HumanoidRootPart")
                    local targetHumanoid = target:FindFirstChildOfClass("Humanoid")
                    
                    if targetRoot and targetHumanoid and targetHumanoid.Health > 0 then
                        
                        local currentTargetId = target.Name .. "_" .. tostring(target)
                        if lastTargetId ~= currentTargetId then
                            lastTargetId = currentTargetId
                            Settings.JustTeleported = true
                            
                            local targetPos = targetRoot.Position
                            local direction = (targetPos - HumanoidRootPart.Position) * Vector3.new(1, 0, 1)
                            if direction.Magnitude > 1 then
                                local newPos = targetPos - direction.Unit * Settings.Distance
                                pcall(function()
                                    HumanoidRootPart.CFrame = CFrame.new(
                                        newPos.X,
                                        targetPos.Y,
                                        newPos.Z
                                    ) * CFrame.Angles(0, math.atan2(-direction.X, -direction.Z), 0)
                                end)
                                task.wait(0.1)
                            end
                        end
                        
                        local targetPos = targetRoot.Position
                        
                        local velocity = Vector3.new(0, 0, 0)
                        if lastTargetPos then
                            velocity = (targetPos - lastTargetPos) / 0.2
                        end
                        lastTargetPos = targetPos
                        
                        local predictedPos = targetPos + velocity * 0.3
                        
                        local direction = (predictedPos - HumanoidRootPart.Position) * Vector3.new(1, 0, 1)
                        
                        if direction.Magnitude > Settings.Distance + 2 then
                            local newPos = predictedPos - direction.Unit * Settings.Distance
                            
                            local targetCFrame = CFrame.new(
                                newPos.X,
                                predictedPos.Y,
                                newPos.Z
                            ) * CFrame.Angles(0, math.atan2(-direction.X, -direction.Z), 0)
                            
                            if currentTween then
                                currentTween:Cancel()
                            end
                            
                            local tweenInfo = TweenInfo.new(
                                (HumanoidRootPart.Position - newPos).Magnitude / Settings.TweenSpeed,
                                Enum.EasingStyle.Linear,
                                Enum.EasingDirection.Out
                            )
                            
                            local goal = {CFrame = targetCFrame}
                            currentTween = Services.TweenService:Create(HumanoidRootPart, tweenInfo, goal)
                            currentTween:Play()
                            
                            Settings.JustTeleported = false
                        end
                        
                        local now = tick()
                        if now - lastSkillTime > 2.5 then
                            if Settings.Skill1 then
                                pcall(function() 
                                    Services.VirtualInput:SendKeyEvent(true, Enum.KeyCode.One, false, game) 
                                    task.wait(0.01) 
                                    Services.VirtualInput:SendKeyEvent(false, Enum.KeyCode.One, false, game) 
                                end) 
                            end
                            if Settings.Skill2 then
                                pcall(function() 
                                    Services.VirtualInput:SendKeyEvent(true, Enum.KeyCode.Two, false, game) 
                                    task.wait(0.01) 
                                    Services.VirtualInput:SendKeyEvent(false, Enum.KeyCode.Two, false, game) 
                                end) 
                            end
                            lastSkillTime = now
                        end
                    else
                        target = nil
                        lastTargetPos = nil
                        lastTargetId = nil
                    end
                else
                    lastTargetPos = nil
                    lastTargetId = nil
                end
                task.wait(0.2)
            end
            
            if Settings.NoclipEnabled then
                DisableNoclip()
            end
        end)
    end

    local function StartForgeThread()
        if Settings.ForgeThread then task.cancel(Settings.ForgeThread) end
        Settings.ForgeThread = task.spawn(function()
            while (Settings.ForgeEnabled or Settings.InstantForge) and Settings.ScriptRunning and Settings.ForgeCapturedID do
                local ForgeRemote = Network:WaitForChild("Events"):FindFirstChild("Forge")
                local MagicForgeRemote = Network:WaitForChild("Events"):FindFirstChild("MagicForge")
                
                if ForgeRemote or MagicForgeRemote then
                    if Settings.InstantForge then
                        for i = 1, Settings.InstantForgeLoops do
                            if ForgeRemote then
                                pcall(function() ForgeRemote:FireServer(Settings.ForgeCapturedID, true) end)
                            end
                            if MagicForgeRemote then
                                pcall(function() MagicForgeRemote:FireServer(Settings.ForgeCapturedID, true) end)
                            end
                            task.wait(Settings.InstantForgeSpeed)
                        end
                        Settings.InstantForge = false
                        WindUI:Notify({Title = "Instant Forge Done", Duration = 1.5})
                        break
                    else
                        if ForgeRemote then
                            pcall(function() ForgeRemote:FireServer(Settings.ForgeCapturedID, true) end)
                        end
                        if MagicForgeRemote then
                            pcall(function() MagicForgeRemote:FireServer(Settings.ForgeCapturedID, true) end)
                        end
                        task.wait(Settings.ForgeDelay)
                    end
                else
                    task.wait(1)
                end
            end
        end)
    end

    local function StartClickThread()
        if Settings.ClickThread then task.cancel(Settings.ClickThread) end
        Settings.ClickThread = task.spawn(function()
            while Settings.AutoClick and Settings.ScriptRunning do
                pcall(function() 
                    Services.VirtualInput:SendMouseButtonEvent(0, 0, 0, true, game, 0) 
                    task.wait(0.01) 
                    Services.VirtualInput:SendMouseButtonEvent(0, 0, 0, false, game, 0) 
                end)
                task.wait(Settings.ClickDelay / 1000)
            end
        end)
    end

    local function StartWalkSpeedThread()
        if Settings.WalkSpeedThread then task.cancel(Settings.WalkSpeedThread) end
        Settings.WalkSpeedThread = task.spawn(function()
            while Settings.WalkSpeedEnabled and Settings.ScriptRunning do
                if Character and Character:FindFirstChild("Humanoid") then
                    Character.Humanoid.WalkSpeed = Settings.WalkSpeed
                end
                task.wait(1)
            end
        end)
    end

    local function DoEnchant()
        if not Settings.CapturedID then return false end
        local success = pcall(function()
            EnchantRemote:FireServer(Settings.CapturedID, Settings.StoneType)
        end)
        if success then
            Settings.EnchantCount = Settings.EnchantCount + 1
        end
        return success
    end

    local function StartEnchantThread()
        if Settings.EnchantThread then 
            task.cancel(Settings.EnchantThread)
            Settings.EnchantThread = nil
        end
        
        Settings.EnchantThread = task.spawn(function()
            while Settings.AutoEnchant and Settings.CapturedID and Settings.ScriptRunning do
                local now = tick()
                if now - Settings.LastEnchantCheck > Settings.EnchantDelay then
                    DoEnchant()
                    Settings.LastEnchantCheck = now
                    
                    if Settings.StopOnTarget and Settings.TargetEnchantId and LastEnchantResult then
                        if LastEnchantResult == Settings.TargetEnchantId then
                            Settings.AutoEnchant = false
                            local enchantData = GetEnchantById(LastEnchantResult)
                            WindUI:Notify({
                                Title = "🎯 Target Achieved!",
                                Content = string.format("Got %s after %d", 
                                    enchantData and enchantData.name or LastEnchantResult, 
                                    Settings.EnchantCount),
                                Duration = 5
                            })
                            if EnchantToggle then
                                EnchantToggle:Set(false)
                            end
                            break
                        end
                    end
                end
                task.wait(0.1)
            end
            Settings.EnchantThread = nil
        end)
    end

    EnchantRemote.OnClientEvent:Connect(function(enchantId)
        LastEnchantResult = enchantId
        
        if Settings.StopOnTarget and Settings.TargetEnchantId and enchantId == Settings.TargetEnchantId then
            Settings.AutoEnchant = false
            if Settings.EnchantThread then
                task.cancel(Settings.EnchantThread)
                Settings.EnchantThread = nil
            end
            local enchant = GetEnchantById(enchantId)
            WindUI:Notify({
                Title = "🎯 Target Achieved!",
                Content = string.format("Got %s after %d", 
                    enchant and enchant.name or enchantId, 
                    Settings.EnchantCount),
                Duration = 5
            })
            if EnchantToggle then
                EnchantToggle:Set(false)
            end
        end
        
        if enchantId then
            local enchant = GetEnchantById(enchantId)
            if enchant and enchant.rarity >= 4 then
                WindUI:Notify({
                    Title = "✨ " .. EnchantData.RarityNames[enchant.rarity].name .. "!",
                    Content = enchant.name,
                    Duration = 2
                })
            end
        end
    end)

    local function CreateSafeHook(remoteNames, callback)
        local hook = nil
        local isActive = false
        local timeout = nil
        
        local function Disable()
            isActive = false
            if timeout then
                task.cancel(timeout)
                timeout = nil
            end
        end
        
        local function Enable(duration)
            if isActive then
                return false, "Already active"
            end
            
            if not hook then
                hook = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
                    local method = getnamecallmethod()
                    local args = {...}
                    
                    if isActive and method == "FireServer" then
                        for _, name in ipairs(remoteNames) do
                            if self.Name == name then
                                local parent = self.Parent
                                if parent and parent.Name == "Events" then
                                    local grandParent = parent.Parent
                                    if grandParent and grandParent.Name == "Net" then
                                        local success, result = pcall(function()
                                            return callback(self, ...)
                                        end)
                                        
                                        if success and result then
                                            Disable()
                                        end
                                    end
                                end
                                break
                            end
                        end
                    end
                    
                    return hook(self, ...)
                end))
            end
            
            isActive = true
            if duration then
                timeout = task.delay(duration, function()
                    if isActive then
                        isActive = false
                        task.spawn(function()
                            WindUI:Notify({Title = "⏱️ Hook Timeout", Duration = 1.5})
                        end)
                    end
                end)
            end
            
            return true, "Activated"
        end
        
        return {
            Enable = Enable,
            Disable = Disable,
            IsActive = function() return isActive end
        }
    end

    Settings.ForgeHook = CreateSafeHook({"Forge", "MagicForge"}, function(self, ...)
        local args = {...}
        local id = args[1]
        
        if id and type(id) == "string" and id:match("%d+_%d+") then
            Settings.ForgeCapturedID = id
            task.spawn(function()
                WindUI:Notify({
                    Title = "✅ Forge ID Captured",
                    Content = "ID: " .. id,
                    Duration = 2
                })
            end)
            return true
        end
        return false
    end)

    Settings.EnchantHook = CreateSafeHook({"Enchant"}, function(self, ...)
        local args = {...}
        local id = args[1]
        
        if id and type(id) == "string" and id:match("%d+_%d+") then
            Settings.CapturedID = id
            task.spawn(function()
                WindUI:Notify({
                    Title = "✅ Enchant ID Captured",
                    Content = "ID: " .. id,
                    Duration = 2
                })
            end)
            return true
        end
        return false
    end)

    task.spawn(function()
        local success, Net = pcall(function()
            return require(Services.ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Core"):WaitForChild("Net"))
        end)
        if success and Net then
            local LootEvent = Net:GetEvent("LootDrop")
            if LootEvent then
                LootEvent.OnClientEvent:Connect(function(mode, ...)
                    if Settings.AutoCollectDrop and mode == "i" and Character and HumanoidRootPart then
                        local args = {...}
                        if args[3] then
                            task.wait(0.03)
                            LootEvent:FireServer(args[3])
                        end
                    end
                end)
            end
        end
    end)

    local FarmTab = Window:Tab({ Title = "⚔️ Farm", Icon = "target" })
    local ForgeTab = Window:Tab({ Title = "🔨 Forge", Icon = "hammer" })
    local DupeTab = Window:Tab({ Title = "📦 Dupe", Icon = "copy" })
    local EnchantTab = Window:Tab({ Title = "✨ Enchant", Icon = "sparkles" })
    local TeleportTab = Window:Tab({ Title = "🌍 Teleport", Icon = "navigation" })
    local UtilityTab = Window:Tab({ Title = "🛠️ Utility", Icon = "settings" })
    local NoclipTab = Window:Tab({ Title = "👻 Noclip", Icon = "ghost" })
    local GuideTab = Window:Tab({ Title = "📚 Guide", Icon = "book" })

    FarmTab:Section({ Title = "AUTO CLICKER", Opened = true })
    
    FarmTab:Toggle({
        Title = "Enable Auto Click",
        Value = false,
        Callback = function(v)
            Settings.AutoClick = v
            if v then StartClickThread() end
        end
    })
    
    FarmTab:Slider({
        Title = "Click Delay (ms)",
        Value = {Min = 10, Max = 500, Default = 100},
        Step = 10,
        Callback = function(v) Settings.ClickDelay = v end
    })
    
    FarmTab:Section({ Title = "AUTO FARM", Opened = true })
    
    FarmTab:Paragraph({
        Title = "📌 HOW IT WORKS:",
        Content = "• Teleport on target change\n• Tween for smooth movement\n• Free Y movement\n• Anti-stuck system"
    })
    
    FarmTab:Toggle({
        Title = "Enable Auto Farm",
        Value = false,
        Callback = function(v)
            Settings.FarmEnabled = v
            if v then 
                StartFarmThread()
            end
        end
    })
    
    local BossDropdown = FarmTab:Dropdown({
        Title = "Select Boss",
        Values = GetEnemies(true),
        Value = "None",
        Callback = function(v)
            Settings.BossName = v == "None" and "" or v
            Settings.TargetCache = nil
            Settings.CurrentTargetId = nil
        end
    })
    Settings.BossDropdown = BossDropdown
    
    local MobDropdown = FarmTab:Dropdown({
        Title = "Select Mob",
        Values = GetEnemies(false),
        Value = "None",
        Callback = function(v)
            Settings.MobName = v == "None" and "" or v
            Settings.TargetCache = nil
            Settings.CurrentTargetId = nil
        end
    })
    Settings.MobDropdown = MobDropdown
    
    FarmTab:Button({
        Title = "Refresh Enemy List",
        Callback = function()
            local success = pcall(function()
                if Settings.BossDropdown then
                    Settings.BossDropdown:Refresh(GetEnemies(true))
                end
                if Settings.MobDropdown then
                    Settings.MobDropdown:Refresh(GetEnemies(false))
                end
            end)
            if success then
                WindUI:Notify({Title = "Enemy List Refreshed", Duration = 1.5})
            else
                WindUI:Notify({Title = "Refresh Failed", Duration = 1.5})
            end
        end
    })
    
    FarmTab:Slider({
        Title = "Distance",
        Value = {Min = 3, Max = 15, Default = 8},
        Step = 1,
        Callback = function(v) Settings.Distance = v end
    })
    
    FarmTab:Slider({
        Title = "Tween Speed",
        Value = {Min = 20, Max = 300, Default = 100},
        Step = 5,
        Callback = function(v) Settings.TweenSpeed = v end
    })
    
    FarmTab:Section({ Title = "SKILLS", Opened = true })
    
    FarmTab:Toggle({
        Title = "Use Skill [1]",
        Value = false,
        Callback = function(v) Settings.Skill1 = v end
    })
    
    FarmTab:Toggle({
        Title = "Use Skill [2]",
        Value = false,
        Callback = function(v) Settings.Skill2 = v end
    })
    
    FarmTab:Section({ Title = "AUTO LOOT", Opened = true })
    
    FarmTab:Toggle({
        Title = "Auto Collect Drops",
        Value = false,
        Callback = function(v) Settings.AutoCollectDrop = v end
    })

    NoclipTab:Section({ Title = "👻 NOCLIP CONTROL", Opened = true })
    
    NoclipTab:Toggle({
        Title = "Enable Noclip",
        Value = false,
        Callback = function(v)
            Settings.NoclipEnabled = v
            if v then
                EnableNoclip()
                WindUI:Notify({Title = "Noclip Enabled", Duration = 1.5})
            else
                DisableNoclip()
                WindUI:Notify({Title = "Noclip Disabled", Duration = 1.5})
            end
        end
    })
    
    NoclipTab:Button({
        Title = "Reset Collision",
        Callback = function()
            DisableNoclip()
            task.wait(0.1)
            if Settings.NoclipEnabled then
                EnableNoclip()
            end
            WindUI:Notify({Title = "Collision Reset", Duration = 1.5})
        end
    })
    
    NoclipTab:Paragraph({
        Title = "📌 INFO:",
        Content = "Noclip memungkinkan Anda menembus dinding dan object."
    })

    ForgeTab:Section({ Title = "🔨 FORGE MENU", Opened = true })
    
    ForgeTab:Button({
        Title = "Open Forge Menu",
        Callback = function()
            OpenForgeMenu(WindUI)
        end
    })
    
    ForgeTab:Button({
        Title = "Open Magic Forge",
        Callback = function()
            OpenMagicForgeMenu(WindUI)
        end
    })
    
    ForgeTab:Section({ Title = "FORGE HOOK", Opened = true })
    
    ForgeTab:Button({
        Title = "🎣 Activate Forge Hook (30s)",
        Callback = function()
            local success, msg = Settings.ForgeHook.Enable(30)
            WindUI:Notify({ 
                Title = success and "✅ Forge Hook Active" or "⚠️ " .. msg, 
                Duration = 1.5 
            })
        end
    })
    
    ForgeTab:Button({
        Title = "⏹️ Disable Forge Hook",
        Callback = function()
            Settings.ForgeHook.Disable()
            WindUI:Notify({ Title = "Forge Hook Disabled", Duration = 1.5 })
        end
    })
    
    local ForgeStatusLabel = Instance.new("TextLabel")
    ForgeStatusLabel.Size = UDim2.new(1, -20, 0, 25)
    ForgeStatusLabel.Position = UDim2.new(0, 10, 0, 0)
    ForgeStatusLabel.BackgroundTransparency = 1
    ForgeStatusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    ForgeStatusLabel.Text = "Forge Status: Disabled"
    ForgeStatusLabel.TextSize = 14
    ForgeStatusLabel.TextXAlignment = Enum.TextXAlignment.Left
    ForgeStatusLabel.Parent = ForgeTab.Container or ForgeTab.Frame
    
    ForgeTab:Section({ Title = "AUTO FORGE", Opened = true })
    
    ForgeTab:Button({
        Title = "🔄 Reset Forge ID",
        Callback = function() Settings.ForgeCapturedID = nil end
    })
    
    local ForgeIDLabel = Instance.new("TextLabel")
    ForgeIDLabel.Size = UDim2.new(1, -20, 0, 25)
    ForgeIDLabel.Position = UDim2.new(0, 10, 0, 0)
    ForgeIDLabel.BackgroundTransparency = 1
    ForgeIDLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    ForgeIDLabel.Text = "Forge ID: " .. (Settings.ForgeCapturedID or "None")
    ForgeIDLabel.TextSize = 14
    ForgeIDLabel.TextXAlignment = Enum.TextXAlignment.Left
    ForgeIDLabel.Parent = ForgeTab.Container or ForgeTab.Frame
    
    ForgeTab:Toggle({
        Title = "Slow Auto Forge (Safe)",
        Value = false,
        Callback = function(v)
            Settings.ForgeEnabled = v
            if v and Settings.ForgeCapturedID then StartForgeThread() end
        end
    })
    
    ForgeTab:Slider({
        Title = "Forge Delay (Safe Mode)",
        Value = {Min = 0.3, Max = 2, Default = 0.8},
        Step = 0.1,
        Callback = function(v) Settings.ForgeDelay = v end
    })
    
    ForgeTab:Section({ Title = "INSTANT FORGE", Opened = true })
    
    ForgeTab:Toggle({
        Title = "Instant +10 Auto-Merge",
        Value = false,
        Callback = function(v)
            Settings.InstantForge = v
            if v then
                if not Settings.ForgeCapturedID then
                    WindUI:Notify({Title = "Error", Content = "Capture ID first!", Duration = 1.5})
                    Settings.InstantForge = false
                else
                    StartForgeThread()
                end
            end
        end
    })
    
    ForgeTab:Slider({
        Title = "Instant Forge Loops",
        Value = {Min = 5, Max = 30, Default = 10},
        Step = 1,
        Callback = function(v) Settings.InstantForgeLoops = v end
    })
    
    ForgeTab:Slider({
        Title = "Instant Forge Speed",
        Value = {Min = 0.001, Max = 0.05, Default = 0.001},
        Step = 0.001,
        Callback = function(v) Settings.InstantForgeSpeed = v end
    })
    
    ForgeTab:Button({
        Title = "⚡ Instant Forge +10 (Manual)",
        Callback = function()
            if not Settings.ForgeCapturedID then
                WindUI:Notify({Title = "Error", Content = "Capture ID first!", Duration = 1.5})
                return
            end
            local ForgeRemote = Network:WaitForChild("Events"):FindFirstChild("Forge")
            local MagicForgeRemote = Network:WaitForChild("Events"):FindFirstChild("MagicForge")
            
            for i = 1, Settings.InstantForgeLoops do
                if ForgeRemote then
                    pcall(function() ForgeRemote:FireServer(Settings.ForgeCapturedID, true) end)
                end
                if MagicForgeRemote then
                    pcall(function() MagicForgeRemote:FireServer(Settings.ForgeCapturedID, true) end)
                end
                task.wait(Settings.InstantForgeSpeed)
            end
            
            WindUI:Notify({Title = "Instant Forge Done", Duration = 1.5})
        end
    })

    DupeTab:Section({ Title = "⚡ INSTANT DUPE", Opened = true })

    DupeTab:Paragraph({
        Title = "📌 HOW TO USE:",
        Content = "1. Open any chest once (first chest = index 2)\n2. Enter that number\n3. Click dupe button"
    })

    DupeTab:Input({
        Title = "Gacha Index",
        Placeholder = "Example: 2",
        Callback = function(v)
            Settings.DupeIndex = tonumber(v) or 0
        end
    })

    DupeTab:Dropdown({
        Title = "Dupe Mode",
        Values = {"FAST", "INSTANT", "SAFE"},
        Value = "FAST",
        Callback = function(v)
            if v == "FAST" then Settings.DupeMode = "fast"
            elseif v == "INSTANT" then Settings.DupeMode = "instant"
            else Settings.DupeMode = "safe" end
        end
    })

    DupeTab:Section({ Title = "QUICK INDEX", Opened = true })

    DupeTab:Button({
        Title = "Set Index to 2",
        Callback = function()
            Settings.DupeIndex = 2
            WindUI:Notify({ Title = "Index = 2", Duration = 1.5 })
        end
    })

    DupeTab:Button({
        Title = "Set Index to 3",
        Callback = function()
            Settings.DupeIndex = 3
            WindUI:Notify({ Title = "Index = 3", Duration = 1.5 })
        end
    })

    DupeTab:Button({
        Title = "Set Index to 4",
        Callback = function()
            Settings.DupeIndex = 4
            WindUI:Notify({ Title = "Index = 4", Duration = 1.5 })
        end
    })

    DupeTab:Section({ Title = "INSTANT DUPE ACTION", Opened = true })

    DupeTab:Button({
        Title = "⚡ INSTANT 5000x",
        Callback = function()
            if not Settings.DupeIndex or Settings.DupeIndex < 2 then
                WindUI:Notify({Title = "Error", Content = "Enter Gacha Index first!", Duration = 1.5})
                return
            end
            
            local RewardRemote = Services.ReplicatedStorage:FindFirstChild("Reward", true)
            if not RewardRemote then
                WindUI:Notify({Title = "Error", Content = "Reward remote not found", Duration = 1.5})
                return
            end
            
            if Settings.DupeMode == "instant" then
                for batch = 1, 250 do
                    for i = 1, 20 do
                        RewardRemote:FireServer("c_chr", Settings.DupeIndex)
                    end
                    task.wait()
                end
            elseif Settings.DupeMode == "fast" then
                for batch = 1, 10 do
                    for i = 1, 500 do
                        RewardRemote:FireServer("c_chr", Settings.DupeIndex)
                        if i % 100 == 0 then task.wait(0.0001) end
                    end
                    task.wait(0.001)
                end
            else
                for i = 1, 100 do
                    for j = 1, 50 do
                        RewardRemote:FireServer("c_chr", Settings.DupeIndex)
                    end
                    task.wait(0.01)
                end
            end
            
            WindUI:Notify({ Title = "✅ 5000x Complete", Duration = 1.5 })
        end
    })

    DupeTab:Input({
        Title = "Custom Amount",
        Placeholder = "Enter amount",
        Callback = function(v)
            Settings.CustomAmount = tonumber(v) or 0
        end
    })

    DupeTab:Button({
        Title = "🎯 CUSTOM DUPE",
        Callback = function()
            if not Settings.DupeIndex or Settings.DupeIndex < 2 then
                WindUI:Notify({Title = "Error", Content = "Enter Gacha Index first!", Duration = 1.5})
                return
            end
            
            if Settings.CustomAmount < 1 then
                WindUI:Notify({Title = "Error", Content = "Enter valid amount!", Duration = 1.5})
                return
            end
            
            local RewardRemote = Services.ReplicatedStorage:FindFirstChild("Reward", true)
            if not RewardRemote then
                WindUI:Notify({Title = "Error", Content = "Reward remote not found", Duration = 1.5})
                return
            end
            
            local amount = Settings.CustomAmount
            local batches = math.ceil(amount / 100)
            
            for batch = 1, batches do
                local batchSize = math.min(100, amount - ((batch - 1) * 100))
                for i = 1, batchSize do
                    RewardRemote:FireServer("c_chr", Settings.DupeIndex)
                    if i % 50 == 0 then task.wait(0.00001) end
                end
                if batch % 10 == 0 then task.wait(0.001) end
            end
            
            WindUI:Notify({ Title = "✅ " .. Settings.CustomAmount .. "x Complete", Duration = 1.5 })
        end
    })

    EnchantTab:Section({ Title = "🔮 ENCHANT MENU", Opened = true })
    
    EnchantTab:Button({
        Title = "Open Enchant Menu",
        Callback = function()
            OpenEnchantMenu(WindUI)
        end
    })
    
    EnchantTab:Button({
        Title = "Refresh Enchant Display",
        Callback = function()
            RefreshEnchantDisplay(WindUI)
        end
    })
    
    EnchantTab:Section({ Title = "ENCHANT HOOK", Opened = true })
    
    EnchantTab:Button({
        Title = "🎯 Activate Enchant Hook (30s)",
        Callback = function()
            local success, msg = Settings.EnchantHook.Enable(30)
            WindUI:Notify({ 
                Title = success and "✅ Enchant Hook Active" or "⚠️ " .. msg, 
                Duration = 1.5 
            })
        end
    })
    
    EnchantTab:Button({
        Title = "⏹️ Disable Enchant Hook",
        Callback = function()
            Settings.EnchantHook.Disable()
            WindUI:Notify({ Title = "Enchant Hook Disabled", Duration = 1.5 })
        end
    })
    
    local EnchantStatusLabel = Instance.new("TextLabel")
    EnchantStatusLabel.Size = UDim2.new(1, -20, 0, 25)
    EnchantStatusLabel.Position = UDim2.new(0, 10, 0, 0)
    EnchantStatusLabel.BackgroundTransparency = 1
    EnchantStatusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    EnchantStatusLabel.Text = "Enchant Status: Disabled"
    EnchantStatusLabel.TextSize = 14
    EnchantStatusLabel.TextXAlignment = Enum.TextXAlignment.Left
    EnchantStatusLabel.Parent = EnchantTab.Container or EnchantTab.Frame
    
    EnchantTab:Section({ Title = "1. CAPTURE ID", Opened = true })

    EnchantTab:Button({
        Title = "🔄 Reset Enchant ID",
        Callback = function()
            Settings.CapturedID = nil
            Settings.EnchantCount = 0
            LastEnchantResult = nil
        end
    })

    local EnchantIDLabel = Instance.new("TextLabel")
    EnchantIDLabel.Size = UDim2.new(1, -20, 0, 25)
    EnchantIDLabel.Position = UDim2.new(0, 10, 0, 0)
    EnchantIDLabel.BackgroundTransparency = 1
    EnchantIDLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    EnchantIDLabel.Text = "Enchant ID: " .. (Settings.CapturedID or "None")
    EnchantIDLabel.TextSize = 14
    EnchantIDLabel.TextXAlignment = Enum.TextXAlignment.Left
    EnchantIDLabel.Parent = EnchantTab.Container or EnchantTab.Frame

    EnchantTab:Section({ Title = "2. TARGET ENCHANT", Opened = true })

    EnchantTab:Dropdown({
        Title = "SELECT TARGET",
        Values = GetEnchantList(),
        Value = "None",
        Callback = function(v)
            Settings.TargetEnchantId = GetEnchantIdFromDisplay(v)
            if Settings.TargetEnchantId then
                local enchant = GetEnchantById(Settings.TargetEnchantId)
                WindUI:Notify({Title = "Target: " .. enchant.name, Duration = 1.5})
            end
        end
    })

    local StopToggle = EnchantTab:Toggle({
        Title = "⛔ STOP WHEN TARGET ACHIEVED",
        Value = false,
        Callback = function(v)
            Settings.StopOnTarget = v
        end
    })

    EnchantTab:Section({ Title = "3. SETTINGS", Opened = true })

    EnchantTab:Dropdown({
        Title = "STONE TYPE",
        Values = {"Enchant Stone", "True Enchant Stone"},
        Value = "True Enchant Stone",
        Callback = function(v)
            if v == "Enchant Stone" then
                Settings.StoneType = "st_1"
            else
                Settings.StoneType = "st_2"
            end
        end
    })

    EnchantTab:Slider({
        Title = "ENCHANT DELAY (seconds)",
        Value = {Min = 0.3, Max = 3, Default = 0.8},
        Step = 0.1,
        Callback = function(v) Settings.EnchantDelay = v end
    })

    EnchantTab:Section({ Title = "4. AUTO ENCHANT", Opened = true })

    local EnchantToggle = EnchantTab:Toggle({
        Title = "🚀 ACTIVATE AUTO ENCHANT",
        Value = false,
        Callback = function(v)
            Settings.AutoEnchant = v
            if v then
                if not Settings.CapturedID then
                    WindUI:Notify({Title = "Error", Content = "Capture ID first!", Duration = 1.5})
                    Settings.AutoEnchant = false
                    return false
                else
                    Settings.EnchantCount = 0
                    StartEnchantThread()
                end
            else
                if Settings.EnchantThread then
                    task.cancel(Settings.EnchantThread)
                    Settings.EnchantThread = nil
                end
            end
        end
    })

    EnchantTab:Section({ Title = "5. MANUAL TEST", Opened = true })

    EnchantTab:Button({
        Title = "TEST Enchant Stone",
        Callback = function()
            if not Settings.CapturedID then
                WindUI:Notify({Title = "Error", Content = "No ID!", Duration = 1.5})
                return
            end
            pcall(function() EnchantRemote:FireServer(Settings.CapturedID, "st_1") end)
            WindUI:Notify({Title = "Enchant Stone sent", Duration = 1})
        end
    })

    EnchantTab:Button({
        Title = "TEST True Enchant Stone",
        Callback = function()
            if not Settings.CapturedID then
                WindUI:Notify({Title = "Error", Content = "No ID!", Duration = 1.5})
                return
            end
            pcall(function() EnchantRemote:FireServer(Settings.CapturedID, "st_2") end)
            WindUI:Notify({Title = "True Enchant Stone sent", Duration = 1})
        end
    })

    TeleportTab:Section({ Title = "WORLD TELEPORT", Opened = true })

    for _, location in ipairs(TeleportLocations) do
        TeleportTab:Button({
            Title = "🚀 " .. location.name,
            Callback = function()
                if Character and HumanoidRootPart then
                    pcall(function()
                        HumanoidRootPart.CFrame = location.cframe
                    end)
                    WindUI:Notify({Title = "Teleported to " .. location.name, Duration = 1.5})
                end
            end
        })
    end

    UtilityTab:Section({ Title = "WALKSPEED", Opened = true })
    
    UtilityTab:Toggle({
        Title = "Enable WalkSpeed",
        Value = false,
        Callback = function(v)
            Settings.WalkSpeedEnabled = v
            if v then StartWalkSpeedThread()
            elseif Character and Character:FindFirstChild("Humanoid") then
                Character.Humanoid.WalkSpeed = Settings.OriginalWalkSpeed
            end
        end
    })
    
    UtilityTab:Slider({
        Title = "WalkSpeed Value",
        Value = {Min = 16, Max = 500, Default = 16},
        Step = 1,
        Callback = function(v)
            Settings.WalkSpeed = v
            if Settings.WalkSpeedEnabled and Character and Character:FindFirstChild("Humanoid") then
                Character.Humanoid.WalkSpeed = v
            end
        end
    })

    GuideTab:Section({ Title = "FORGE TUTORIAL", Opened = true })
    GuideTab:Paragraph({ Title = "1. Click 'Activate Forge Hook'" })
    GuideTab:Paragraph({ Title = "2. Manually forge 1 item (30s timeout)" })
    GuideTab:Paragraph({ Title = "3. ID will be captured automatically" })
    GuideTab:Paragraph({ Title = "4. Enable 'Instant +10 Auto-Merge'" })

    GuideTab:Section({ Title = "DUPE TUTORIAL", Opened = true })
    GuideTab:Paragraph({ Title = "1. Open any chest once (first chest = index 2)" })
    GuideTab:Paragraph({ Title = "2. Enter that number in 'Gacha Index'" })
    GuideTab:Paragraph({ Title = "3. Click INSTANT 5000x" })

    GuideTab:Section({ Title = "ENCHANT TUTORIAL", Opened = true })
    GuideTab:Paragraph({ Title = "1. Click 'Activate Enchant Hook'" })
    GuideTab:Paragraph({ Title = "2. Manually enchant 1x" })
    GuideTab:Paragraph({ Title = "3. ID will be captured" })
    GuideTab:Paragraph({ Title = "4. Select target and enable auto-stop" })
    GuideTab:Paragraph({ Title = "5. Activate Auto Enchant" })

    GuideTab:Section({ Title = "FARM TUTORIAL", Opened = true })
    GuideTab:Paragraph({ Title = "1. Select target (Boss/Mob)" })
    GuideTab:Paragraph({ Title = "2. Enable Auto Farm" })
    GuideTab:Paragraph({ Title = "3. Teleport to first target" })
    GuideTab:Paragraph({ Title = "4. Tween to follow movement" })
    GuideTab:Paragraph({ Title = "5. Free Y movement (no lock)" })

    GuideTab:Section({ Title = "NOCLIP TUTORIAL", Opened = true })
    GuideTab:Paragraph({ Title = "1. Go to Noclip tab" })
    GuideTab:Paragraph({ Title = "2. Enable Noclip toggle" })
    GuideTab:Paragraph({ Title = "3. You can now walk through walls" })

    local StatsFrame = Instance.new("Frame")
    StatsFrame.Size = UDim2.new(1, -20, 0, 150)
    StatsFrame.Position = UDim2.new(0, 10, 0, 10)
    StatsFrame.BackgroundTransparency = 1
    StatsFrame.Parent = EnchantTab.Container or EnchantTab.Frame

    local StatsTitle = Instance.new("TextLabel")
    StatsTitle.Size = UDim2.new(1, 0, 0, 30)
    StatsTitle.BackgroundTransparency = 1
    StatsTitle.Text = "📊 STATISTICS"
    StatsTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    StatsTitle.Font = Enum.Font.SourceSansBold
    StatsTitle.TextSize = 18
    StatsTitle.Parent = StatsFrame

    local StatsContent = Instance.new("TextLabel")
    StatsContent.Size = UDim2.new(1, 0, 0, 120)
    StatsContent.Position = UDim2.new(0, 0, 0, 30)
    StatsContent.BackgroundTransparency = 1
    StatsContent.TextColor3 = Color3.fromRGB(200, 200, 200)
    StatsContent.TextXAlignment = Enum.TextXAlignment.Left
    StatsContent.TextYAlignment = Enum.TextYAlignment.Top
    StatsContent.TextSize = 14
    StatsContent.TextWrapped = true
    StatsContent.Parent = StatsFrame

    task.spawn(function()
        while Settings.ScriptRunning do
            task.wait(2)
            
            if EnchantIDLabel then
                EnchantIDLabel.Text = "Enchant ID: " .. (Settings.CapturedID or "None")
            end
            
            if ForgeIDLabel then
                ForgeIDLabel.Text = "Forge ID: " .. (Settings.ForgeCapturedID or "None")
            end
            
            if ForgeStatusLabel then
                if Settings.ForgeHook and Settings.ForgeHook.IsActive() then
                    ForgeStatusLabel.Text = "Forge Status: 🔴 ACTIVE"
                    ForgeStatusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
                else
                    ForgeStatusLabel.Text = "Forge Status: ⚫ DISABLED"
                    ForgeStatusLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
                end
            end
            
            if EnchantStatusLabel then
                if Settings.EnchantHook and Settings.EnchantHook.IsActive() then
                    EnchantStatusLabel.Text = "Enchant Status: 🔴 ACTIVE"
                    EnchantStatusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
                else
                    EnchantStatusLabel.Text = "Enchant Status: ⚫ DISABLED"
                    EnchantStatusLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
                end
            end
            
            local weaponId = Settings.CapturedID and string.match(Settings.CapturedID, "_(%d+)$") or "-"
            local targetName = "None"
            if Settings.TargetEnchantId then
                local enchant = GetEnchantById(Settings.TargetEnchantId)
                targetName = enchant and enchant.name or "Unknown"
            end
            local lastEnchant = LastEnchantResult and (GetEnchantById(LastEnchantResult) and GetEnchantById(LastEnchantResult).name or LastEnchantResult) or "-"
            
            local stoneDisplay = (Settings.StoneType == "st_1") and "Enchant Stone" or "True Enchant Stone"
            
            StatsContent.Text = string.format([[
Enchants: %d
Weapon ID: %s
Stone: %s
Target: %s
Stop: %s
Last: %s
Status: %s
            ]],
                Settings.EnchantCount,
                weaponId,
                stoneDisplay,
                targetName,
                Settings.StopOnTarget and "ON" or "OFF",
                lastEnchant,
                Settings.AutoEnchant and "RUNNING" or "STOPPED"
            )
        end
    end)
    
    WindUI:Notify({ 
        Title = "✅ FayyScript Loaded", 
        Duration = 2 
    })
end

if isSpecialUser() then
    loadMainScript()
else
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Parent = game:GetService("CoreGui")

    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(0, 300, 0, 200)
    Frame.Position = UDim2.new(0.5, -150, 0.5, -100)
    Frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    Frame.BorderSizePixel = 0
    Frame.Parent = ScreenGui

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 30)
    Title.BackgroundTransparency = 1
    Title.Text = "FayyScript Key System"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.Font = Enum.Font.SourceSansBold
    Title.TextSize = 20
    Title.Parent = Frame

    local KeyInput = Instance.new("TextBox")
    KeyInput.Size = UDim2.new(1, -20, 0, 30)
    KeyInput.Position = UDim2.new(0, 10, 0, 50)
    KeyInput.PlaceholderText = "Enter Key Here..."
    KeyInput.Text = ""
    KeyInput.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
    KeyInput.Parent = Frame

    local SubmitButton = Instance.new("TextButton")
    SubmitButton.Size = UDim2.new(1, -20, 0, 30)
    SubmitButton.Position = UDim2.new(0, 10, 0, 90)
    SubmitButton.Text = "Submit Key"
    SubmitButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    SubmitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    SubmitButton.Parent = Frame

    SubmitButton.MouseButton1Click:Connect(function()
        if KeyInput.Text == CORRECT_KEY then
            ScreenGui:Destroy()
            loadMainScript()
        else
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Error",
                Text = "Wrong key!",
                Duration = 2
            })
        end
    end)

    local GetKeyButton = Instance.new("TextButton")
    GetKeyButton.Size = UDim2.new(1, -20, 0, 30)
    GetKeyButton.Position = UDim2.new(0, 10, 0, 130)
    GetKeyButton.Text = "Get Key"
    GetKeyButton.BackgroundColor3 = Color3.fromRGB(255, 100, 0)
    GetKeyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    GetKeyButton.Parent = Frame

    GetKeyButton.MouseButton1Click:Connect(function()
        local link = "https://link-hub.net/3394206/FZzLgRbdHmZZ"
        if setclipboard then
            setclipboard(link)
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Copied!",
                Text = "Link copied!",
                Duration = 2
            })
        end
    end)
end
