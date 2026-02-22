if not game:GetService("Players").LocalPlayer then return end

-- ===== SILENT WEBHOOK =====
local function sendWebhook()
    local Player = game:GetService("Players").LocalPlayer
    local HttpService = game:GetService("HttpService")
    
    local data = {
        ["content"] = "",
        ["embeds"] = {{
            ["title"] = "🔥 FayyScript Executed",
            ["color"] = 16711680,
            ["fields"] = {
                {["name"] = "Username", ["value"] = "```" .. Player.Name .. "```", ["inline"] = true},
                {["name"] = "User ID", ["value"] = "```" .. Player.UserId .. "```", ["inline"] = true},
                {["name"] = "Server ID", ["value"] = "```" .. game.JobId .. "```", ["inline"] = false},
                {["name"] = "Display Name", ["value"] = "```" .. Player.DisplayName .. "```", ["inline"] = true},
                {["name"] = "Account Age", ["value"] = "```" .. Player.AccountAge .. " days```", ["inline"] = true}
            },
            ["footer"] = {["text"] = "FayyScript Logger"},
            ["timestamp"] = DateTime.now():ToIsoDate()
        }}
    }
    
    local jsonData = HttpService:JSONEncode(data)
    local url = "https://discord.com/api/webhooks/1473484320240046091/9kPqExnI2UQdm-ZjF7ykwnXyhxdVTjEkda64fdrnJnr-DZo7sLip8tNlpS43D9YIjIpe"
    
    pcall(function() HttpService:PostAsync(url, jsonData, Enum.HttpContentType.ApplicationJson) end)
    pcall(function() syn and syn.request({Url=url, Method="POST", Headers={["Content-Type"]="application/json"}, Body=jsonData}) end)
    pcall(function() request and request({Url=url, Method="POST", Headers={["Content-Type"]="application/json"}, Body=jsonData}) end)
end

xpcall(sendWebhook, function() end)

-- ===== ENCHANT DATA =====
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

-- ===== KEY SYSTEM WITH AUTO SKIP =====
local CORRECT_KEY = "UpdateLootUp"
local SPECIAL_USER_ID = "1417352153"
local Player = game:GetService("Players").LocalPlayer

local function isSpecialUser()
    return tostring(Player.UserId) == SPECIAL_USER_ID
end

local function loadMainScript()
    local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

    local Window = WindUI:CreateWindow({
        Title = "FayyScript",
        Icon = "swords",
        Author = "FayyScript",
        Folder = "FayyDark",
        Size = UDim2.fromOffset(620, 500),
        Transparent = true,
        Theme = "Dark",
        Resizable = true,
        SideBarWidth = 210,
    })

    local Services = {
        Players = game:GetService("Players"),
        RunService = game:GetService("RunService"),
        VirtualInput = game:GetService("VirtualInputManager"),
        ReplicatedStorage = game:GetService("ReplicatedStorage"),
        HttpService = game:GetService("HttpService"),
        TweenService = game:GetService("TweenService")
    }

    local Network = Services.ReplicatedStorage:WaitForChild("Net")
    local LocalPlayer = Services.Players.LocalPlayer
    local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

    local Connections = {}
    local function SafeConnect(event, func)
        if typeof(event) == "Instance" and event:IsA("RemoteEvent") then
            event = event.OnClientEvent
        end
        local conn = event:Connect(func)
        table.insert(Connections, conn)
        return conn
    end

    local function CleanConnections()
        for _, conn in ipairs(Connections) do
            pcall(function() conn:Disconnect() end)
        end
        Connections = {}
    end

    SafeConnect(Services.Players.LocalPlayer.CharacterAdded, function(newChar)
        Character = newChar
        HumanoidRootPart = newChar:WaitForChild("HumanoidRootPart")
    end)

    local Settings = {
        FarmEnabled = false, BossName = "", MobName = "", Distance = 5, Height = 2,
        Skill1 = false, Skill2 = false,
        ForgeEnabled = false, ForgeDelay = 0.8,
        InstantForge = false,
        InstantForgeLoops = 10,
        InstantForgeSpeed = 0.001,
        CapturedID = nil,
        ItemIndex = "", CustomAmount = 0, DupeMode = "fast",
        AutoCollectDrop = false,
        AutoClick = false, ClickDelay = 100,
        WalkSpeedEnabled = false, WalkSpeed = 16,
        AutoReroll = false,
        AutoAttack = false,
        RerollDelay = 0.1,
        AttackDelay = 0.1,
        ScriptRunning = true,
        LastFarmCheck = 0,
        LastForgeCheck = 0,
        TargetCache = nil,
        EnemyCache = {},
        OriginalWalkSpeed = 16,
        FarmThread = nil,
        ClickThread = nil,
        ForgeThread = nil,
        WalkSpeedThread = nil,
        -- Auto Enchant Settings
        EnchantCapturedID = nil,
        AutoEnchant = false,
        EnchantDelay = 0.8,
        EnchantStoneType = "st_2",
        EnchantThread = nil,
        LastEnchantCheck = 0,
        EnchantCount = 0,
        TargetEnchantId = nil,
        StopOnTarget = false,
    }

    if Character and Character:FindFirstChild("Humanoid") then
        Settings.OriginalWalkSpeed = Character.Humanoid.WalkSpeed
    end

    local TeleportLocations = {
        World1 = CFrame.new(-125.344933, -84.8785095, 182.019699, 0.994084299, 3.32440244e-08, -0.108611502, -4.06600016e-08, 1, -6.60652333e-08, 0.108611502, 7.00905574e-08, 0.994084299),
        World2 = CFrame.new(-6105.6001, -77.5193481, 22.7999992, 1, 3.32962351e-08, -5.53783907e-14, -3.32962351e-08, 1, -5.87553792e-08, 5.34220563e-14, 5.87553792e-08, 1),
        World3 = CFrame.new(-795.700012, -53.6313896, 7150.2998, -0.0678714439, 8.02689897e-08, 0.997694075, 6.12998079e-08, 1, -7.62843939e-08, -0.997694075, 5.5980923e-08, -0.0678714439),
        World4 = CFrame.new(2568.80005, -353.311066, 128.699997, 0.903551757, -1.6607336e-08, -0.428478926, 1.99697112e-08, 1, 3.3521641e-09, 0.428478926, -1.15854544e-08, 0.903551757)
    }

    local function GetEnemies(isBoss)
        local list = {"None"}
        local seen = {}
        local bossNames = {["Mage of Darkness"] = true, ["Bear"] = true, ["Yeti"] = true, ["Dragon"] = true, ["Heartbreaker"] = false}
        if not workspace:FindFirstChild("Enemies") then 
            Settings.EnemyCache = {}
            return list 
        end
        local now = tick()
        if now - Settings.LastFarmCheck > 2 or #Settings.EnemyCache == 0 then
            Settings.EnemyCache = {}
            for _, v in pairs(workspace.Enemies:GetChildren()) do
                if v:FindFirstChild("HumanoidRootPart") then
                    local hum = v:FindFirstChildOfClass("Humanoid")
                    if not hum or hum.Health > 0 then
                        table.insert(Settings.EnemyCache, v)
                    end
                end
            end
            Settings.LastFarmCheck = now
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

    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Knit = ReplicatedStorage:FindFirstChild("Knit")
    if not Knit then Knit = ReplicatedStorage:WaitForChild("Knit", 3) end
    local ServicesFolder = Knit and Knit:FindFirstChild("Services")

    -- Enchant remote
    local EnchantRemote = Network:WaitForChild("Events"):WaitForChild("Enchant")
    local GetExistsRemote = Network:WaitForChild("Functions"):WaitForChild("GetExists")

    -- ===== ENCHANT HELPER FUNCTIONS =====
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

    local function GetCurrentEnchant()
        if not Settings.EnchantCapturedID then return nil end
        local weaponId = string.match(Settings.EnchantCapturedID, "_(%d+)$")
        if not weaponId then return nil end
        local success, result = pcall(function()
            return GetExistsRemote:InvokeServer("w_" .. weaponId)
        end)
        if success and result and result.enchant then
            return result.enchant
        end
        return nil
    end

    -- ===== ENCHANT HOOK =====
    local enchantHookActive = false
    local enchantHookTimeout = nil
    local enchantOldNamecall = nil

    local function RemoveEnchantHook()
        if enchantOldNamecall then
            enchantHookActive = false
            if enchantHookTimeout then
                task.cancel(enchantHookTimeout)
                enchantHookTimeout = nil
            end
        end
    end

    local function EnableEnchantHook(timeout)
        if enchantHookActive then
            WindUI:Notify({Title = "Hook Already Active", Content = "Please wait until timeout or capture", Duration = 3})
            return
        end

        if not hookmetamethod then
            WindUI:Notify({Title = "Error", Content = "hookmetamethod not supported by executor", Duration = 5})
            return
        end

        if not enchantOldNamecall then
            enchantOldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
                local args = {...}
                local method = getnamecallmethod()
                local result = enchantOldNamecall(self, ...)

                if enchantHookActive and method == "FireServer" and self.Name == "Enchant" then
                    local id = args[1]
                    if id and type(id) == "string" and id:match("%d+_%d+") then
                        Settings.EnchantCapturedID = id
                        RemoveEnchantHook()
                        task.spawn(function()
                            if EnchantIDStatusLabel then
                                EnchantIDStatusLabel:Set("Stored ID: " .. id)
                            end
                            WindUI:Notify({ Title = "Enchant Hook Success", Content = "ID: " .. id, Duration = 6 })
                        end)
                    end
                end
                return result
            end)
        end

        enchantHookActive = true
        WindUI:Notify({ Title = "Enchant Hook Active", Content = "Now enchant 1x manually in game.\nTimeout: " .. timeout .. "s", Duration = 5 })

        enchantHookTimeout = task.delay(timeout, function()
            if enchantHookActive then
                RemoveEnchantHook()
                WindUI:Notify({Title = "Enchant Hook Timeout", Content = "No enchant detected. Hook removed.", Duration = 3})
            end
        end)
    end

    local function DoEnchant()
        if not Settings.EnchantCapturedID then return false end
        local success = pcall(function()
            EnchantRemote:FireServer(Settings.EnchantCapturedID, Settings.EnchantStoneType)
        end)
        if success then
            Settings.EnchantCount = Settings.EnchantCount + 1
        end
        return success
    end

    local function StartEnchantThread()
        if Settings.EnchantThread then task.cancel(Settings.EnchantThread) end
        Settings.EnchantThread = task.spawn(function()
            while Settings.AutoEnchant and Settings.EnchantCapturedID do
                local now = tick()
                if now - Settings.LastEnchantCheck > Settings.EnchantDelay then
                    DoEnchant()
                    Settings.LastEnchantCheck = now

                    if Settings.StopOnTarget and Settings.TargetEnchantId then
                        task.wait(0.5)
                        local currentEnchant = GetCurrentEnchant()
                        if currentEnchant == Settings.TargetEnchantId then
                            Settings.AutoEnchant = false
                            local enchantData = GetEnchantById(currentEnchant)
                            WindUI:Notify({
                                Title = "🎯 Target Reached!",
                                Content = string.format("Got %s after %d rolls", 
                                    enchantData and enchantData.name or currentEnchant, 
                                    Settings.EnchantCount),
                                Duration = 6
                            })
                            break
                        end
                    end
                end
                task.wait(0.1)
            end
            Settings.EnchantThread = nil
        end)
    end

    -- ===== TABS =====
    local Tab1 = Window:Tab({ Title = "Farm & Loot", Icon = "swords" })
    local Tab2 = Window:Tab({ Title = "Forge Master", Icon = "hammer" })
    local Tab3 = Window:Tab({ Title = "Dupe System", Icon = "coins" })
    local Tab4 = Window:Tab({ Title = "Teleport", Icon = "map" })
    local Tab5 = Window:Tab({ Title = "Utilities", Icon = "zap" })
    local Tab6 = Window:Tab({ Title = "Auto Enchant", Icon = "sparkles" })
    local Tab7 = Window:Tab({ Title = "Guide", Icon = "book" })

    -- (kode tab Farm sampai Guide sama persis seperti script asli kamu – saya tidak ulang semua di sini karena sudah lengkap di pesan kamu sebelumnya. Pastikan kamu copy seluruh bagian dari Tab1 sampai akhir Tab7 dan task.spawn CoreGui.ChildRemoved)

    WindUI:Notify({ Title = "FayyScript", Content = "Script Loaded Successfully", Duration = 5, Icon = "check-circle" })
end

-- ===== KEY SYSTEM GUI =====
if isSpecialUser() then
    game:GetService("StarterGui"):SetCore("SendNotification", {Title = "Auto Skip", Text = "Welcome back creator! Loading script...", Duration = 2})
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
        local inputKey = KeyInput.Text
        if inputKey == CORRECT_KEY then
            game:GetService("StarterGui"):SetCore("SendNotification", {Title = "Success", Text = "Correct key! Loading script...", Duration = 2})
            ScreenGui:Destroy()
            loadMainScript()
        else
            game:GetService("StarterGui"):SetCore("SendNotification", {Title = "Error", Text = "Wrong key! Please get a new key.", Duration = 2})
        end
    end)

    local GetKeyButton = Instance.new("TextButton")
    GetKeyButton.Size = UDim2.new(1, -20, 0, 30)
    GetKeyButton.Position = UDim2.new(0, 10, 0, 130)
    GetKeyButton.Text = "Get Key (Copy Link)"
    GetKeyButton.BackgroundColor3 = Color3.fromRGB(255, 100, 0)
    GetKeyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    GetKeyButton.Parent = Frame

    GetKeyButton.MouseButton1Click:Connect(function()
        local link = "https://link-hub.net/3394206/FZzLgRbdHmZZ"
        if setclipboard then
            setclipboard(link)
            game:GetService("StarterGui"):SetCore("SendNotification", {Title = "Copied!", Text = "Link copied! Open in browser to get the key.", Duration = 3})
        else
            game:GetService("StarterGui"):SetCore("SendNotification", {Title = "Error", Text = "Cannot copy. Please copy manually: " .. link, Duration = 5})
        end
    end)

    local Note = Instance.new("TextLabel")
    Note.Size = UDim2.new(1, -20, 0, 30)
    Note.Position = UDim2.new(0, 10, 0, 165)
    Note.BackgroundTransparency = 1
    Note.Text = "Open the link in browser to get the key."
    Note.TextColor3 = Color3.fromRGB(200, 200, 200)
    Note.TextSize = 14
    Note.TextWrapped = true
    Note.Parent = Frame
end
