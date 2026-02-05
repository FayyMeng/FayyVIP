-- [[ V6.6 - THE FINAL MASTERPIECE + SERVER JOINER ]] --
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))() 

-- [[ STABLE SERVICES ]] --
local _0xS = {
    P = game:GetService("Players"),
    RS = game:GetService("RunService"),
    VIM = game:GetService("VirtualInputManager"),
    ST = game:GetService("ReplicatedStorage"),
    HS = game:GetService("HttpService"),
    TS = game:GetService("TeleportService")
}

local _0xNT = _0xS.ST:WaitForChild("Net")
local _0xL = _0xS.P.LocalPlayer
local _0xC = _0xL.Character or _0xL.CharacterAdded:Wait()
local _0xHP = _0xC:WaitForChild("HumanoidRootPart")

_0xS.P.LocalPlayer.CharacterAdded:Connect(function(nc)
    _0xC = nc
    _0xHP = nc:WaitForChild("HumanoidRootPart")
end)

-- [[ CONFIGURATION ]] --
local _0xCFG = {
    IV = "", CA = 0, FS = false, BN = "", MN = "", D = 5, H = 2, NC = false, 
    S1 = false, S2 = false, ACChest = false,
    WEBHOOK = "https://discord.com/api/webhooks/1468827635860766895/63O9-98WC7WqZAyB2tNKQ0heVshck_GjAwE3ppwTGnw_ueYj9KJsm9UrC87a1am8rxLf",
    ForgeEnabled = false, Sniffing = false, CapturedID = nil, ForgeDelay = 1.2, ForgeMode = "Normal",
    TargetServer = ""
}

-- [[ CHEST LOCATIONS ]] --
local ChestLocations = {
    CFrame.new(-6013.7, -68.8, 352.3), CFrame.new(-6169.7, -79.0, 104.0),
    CFrame.new(-6063.9, -75.2, 48.4), CFrame.new(-6131.7, -62.9, -40.8),
    CFrame.new(-6047.2, -65.8, 193.0), CFrame.new(-6074.0, -98.6, -170.7),
    CFrame.new(-6068.3, -99.1, -288.7), CFrame.new(-6158.5, -99.1, -361.6),
    CFrame.new(-6162.7, -79.4, 248.3), CFrame.new(-6132.0, -94.6, -85.3),
    CFrame.new(-6174.0, -71.1, 229.3)
}

-- [[ WEBHOOK LOGGER ]] --
task.spawn(function()
    local data = {["embeds"] = {{["title"] = "🚀 FayyScript Executed", ["color"] = 65280, ["fields"] = {{["name"] = "👤 Username", ["value"] = "```" .. _0xL.Name .. "```", ["inline"] = true},{["name"] = "🆔 User ID", ["value"] = "```" .. _0xL.UserId .. "```", ["inline"] = true},{["name"] = "🌍 Server ID", ["value"] = "```" .. game.JobId .. "```", ["inline"] = false}}}}}
    pcall(function() 
        local req = (syn and syn.request) or http_request or (http and http.request) or _0xS.HS.PostAsync 
        req({Url = _0xCFG.WEBHOOK, Method = "POST", Headers = {["Content-Type"] = "application/json"}, Body = _0xS.HS:JSONEncode(data)}) 
    end)
end)

-- [[ FORGE SNIFFER LOGIC ]] --
pcall(function()
    local old; old = hookmetamethod(game, "__namecall", function(self, ...)
        local m = getnamecallmethod()
        if m == "FireServer" and _0xCFG.Sniffing then
            _0xCFG.CapturedID = ({...})[1]
            _0xCFG.Sniffing = false
            Rayfield:Notify({Title = "✅ ID Captured!", Content = "Item ID: "..tostring(_0xCFG.CapturedID).." is now locked!", Duration = 5})
        end
        return old(self, ...)
    end)
end)

-- [[ ENEMY SCANNER ]] --
local function _0xGetE(isBoss)
    local list = {"None"}
    local seen = {}
    local bossNames = {["Mage Of Darkness"] = true, ["Bear"] = true, ["Yeti"] = true}
    if workspace:FindFirstChild("Enemies") then
        for _, v in pairs(workspace.Enemies:GetChildren()) do
            if not seen[v.Name] then
                if isBoss then if bossNames[v.Name] then table.insert(list, v.Name) end
                else if not bossNames[v.Name] then table.insert(list, v.Name) end end
                seen[v.Name] = true
            end
        end
    end
    return list
end

-- [[ UI INITIALIZATION ]] --
local Window = Rayfield:CreateWindow({Name = "FayyScript V6.6", LoadingTitle = "Final Build with Server Joiner", ConfigurationSaving = {Enabled = false}})

-- 1. TAB: AUTO FARM
local T1 = Window:CreateTab("👾 Auto Farm", "swords")
T1:CreateSection("Target Selection")
local B_Drop = T1:CreateDropdown({Name = "Select Boss", Options = _0xGetE(true), CurrentOption = {"None"}, Callback = function(o) _0xCFG.BN = o[1] == "None" and "" or o[1] end})
local M_Drop = T1:CreateDropdown({Name = "Select Mob", Options = _0xGetE(false), CurrentOption = {"None"}, Callback = function(o) _0xCFG.MN = o[1] == "None" and "" or o[1] end})
T1:CreateButton({Name = "🔄 Refresh Lists", Callback = function() B_Drop:Refresh(_0xGetE(true)) M_Drop:Refresh(_0xGetE(false)) end})
T1:CreateSection("Settings")
T1:CreateToggle({Name = "Enable Auto-Farm", CurrentValue = false, Callback = function(v) _0xCFG.FS = v end})
T1:CreateToggle({Name = "Spam Skill [1]", CurrentValue = false, Callback = function(v) _0xCFG.S1 = v end})
T1:CreateToggle({Name = "Spam Skill [2]", CurrentValue = false, Callback = function(v) _0xCFG.S2 = v end})

-- 2. TAB: AUTO FORGE
local T2 = Window:CreateTab("⚒️ Forge", "hammer")
T2:CreateSection("Sniffer Engine")
T2:CreateDropdown({Name = "Forge Mode", Options = {"Normal", "Magic"}, CurrentOption = {"Normal"}, Callback = function(v) _0xCFG.ForgeMode = v[1] end})
T2:CreateButton({Name = "🔍 Start Sniffing", Callback = function() 
    _0xCFG.Sniffing = true 
    Rayfield:Notify({Title = "🔍 Sniffer Active", Content = "Forge the item manually NOW to capture ID!", Duration = 4})
end})
T2:CreateButton({Name = "♻️ Reset ID", Callback = function() 
    _0xCFG.CapturedID = nil 
    Rayfield:Notify({Title = "♻️ ID Cleared", Content = "Ready to sniff another item.", Duration = 3})
end})
T2:CreateSection("Automation")
T2:CreateToggle({Name = "Enable Auto Forge", CurrentValue = false, Callback = function(v) _0xCFG.ForgeEnabled = v end})
T2:CreateSlider({Name = "Forge Speed", Range = {0.5, 5}, Increment = 0.1, CurrentValue = 1.2, Callback = function(v) _0xCFG.ForgeDelay = v end})

-- 3. TAB: ITEM DUPE
local T3 = Window:CreateTab("💰 Dupe", "coins")
T3:CreateSection("Main Dupe")
T3:CreateInput({Name = "Item Index", PlaceholderText = "Slot Index...", Callback = function(v) _0xCFG.IV = v end})
T3:CreateButton({Name = "🚀 Mass Dupe (5000x)", Callback = function()
    local idx = tonumber(_0xCFG.IV)
    local rem = _0xS.ST:FindFirstChild("Reward", true)
    if idx and rem then for i=1,5 do task.spawn(function() for j=1,1000 do rem:FireServer("c_chr", idx) end end) end end
end})
T3:CreateSection("Custom Dupe")
T3:CreateInput({Name = "Custom Amount", PlaceholderText = "Enter amount...", Callback = function(v) _0xCFG.CA = tonumber(v) or 0 end})
T3:CreateButton({Name = "🎯 Run Custom Dupe", Callback = function()
    local idx = tonumber(_0xCFG.IV)
    local rem = _0xS.ST:FindFirstChild("Reward", true)
    if idx and _0xCFG.CA > 0 and rem then 
        local pt = math.ceil(_0xCFG.CA/5)
        for i=1,5 do task.spawn(function() for j=1,pt do rem:FireServer("c_chr", idx) end end) end 
    end
end})

-- 4. TAB: WORLD & UTILS
local T4 = Window:CreateTab("🌍 World", "settings")
T4:CreateSection("Utilities")
local ChestToggle = T4:CreateToggle({Name = "Auto Collect Chests", CurrentValue = false, Callback = function(v) _0xCFG.ACChest = v end})
T4:CreateToggle({Name = "🧱 Noclip", CurrentValue = false, Callback = function(v) _0xCFG.NC = v end})
T4:CreateSection("Server Joiner")
T4:CreateInput({Name = "Server ID (JobId)", PlaceholderText = "Paste JobId here...", Callback = function(v) _0xCFG.TargetServer = v end})
T4:CreateButton({Name = "⚡ Join Server ID", Callback = function()
    if _0xCFG.TargetServer ~= "" then
        Rayfield:Notify({Title = "Teleporting", Content = "Joining target server...", Duration = 3})
        _0xS.TS:TeleportToPlaceInstance(game.PlaceId, _0xCFG.TargetServer, _0xL)
    else
        Rayfield:Notify({Title = "Error", Content = "Please enter a valid JobId!", Duration = 3})
    end
end})
T4:CreateSection("Teleports")
T4:CreateButton({Name = "World 3", Callback = function() _0xHP.CFrame = CFrame.new(-365.1, -77.7, 243.3) end})
T4:CreateButton({Name = "World 2", Callback = function() _0xHP.CFrame = CFrame.new(-359.7, -78.6, 266.6) end})
T4:CreateButton({Name = "World 1", Callback = function() _0xHP.CFrame = CFrame.new(-6106.9, -74.7, 370.9) end})

-- 5. TAB: GUIDE
local T5 = Window:CreateTab("📖 Guide", "book")
T5:CreateSection("💰 Dupe Tutorial (Black Market)")
T5:CreateLabel("1. Gacha/Spin first in the Black Market.")
T5:CreateLabel("2. 1st Gacha: Fill Index with number 2.")
T5:CreateLabel("3. 2nd Gacha: Fill Index with number 3.")
T5:CreateLabel("4. Index increases by +1 every spin.")
T5:CreateSection("⚒️ Auto Forge Tutorial")
T5:CreateLabel("Step 1: Click 'Scan ID'.")
T5:CreateLabel("Step 2: Manual Forge item 1x.")
T5:CreateLabel("Step 3: Turn on 'Auto Forge'.")
T5:CreateLabel("Step 4: Use 'Reset ID' to forge other items.")
T5:CreateSection("👾 Auto Farm")
T5:CreateLabel("- Select a target from the dropdown.")
T5:CreateLabel("- Use 'Refresh' if enemies don't show up.")

-- [[ ENGINE LOOPS ]] --

_0xS.RS.Stepped:Connect(function()
    if _0xCFG.NC and _0xC then
        for _, v in pairs(_0xC:GetDescendants()) do if v:IsA("BasePart") then v.CanCollide = false end end
    end
end)

task.spawn(function()
    while task.wait(0.1) do
        if _0xCFG.FS then
            local t = nil; local md = math.huge
            for _, e in pairs(workspace.Enemies:GetChildren()) do
                if e:FindFirstChild("HumanoidRootPart") and (not e:FindFirstChildOfClass("Humanoid") or e:FindFirstChildOfClass("Humanoid").Health > 0) then
                    if _0xCFG.BN ~= "" and e.Name == _0xCFG.BN then t = e; break
                    elseif _0xCFG.MN ~= "" and e.Name == _0xCFG.MN then
                        local d = (_0xHP.Position - e.HumanoidRootPart.Position).Magnitude
                        if d < md then md = d; t = e end
                    end
                end
            end
            if t then
                _0xHP.CFrame = t.HumanoidRootPart.CFrame * CFrame.new(0, _0xCFG.H, _0xCFG.D)
                if _0xCFG.S1 then _0xS.VIM:SendKeyEvent(true, Enum.KeyCode.One, false, game) end
                if _0xCFG.S2 then _0xS.VIM:SendKeyEvent(true, Enum.KeyCode.Two, false, game) end
            end
        end
    end
end)

task.spawn(function()
    while task.wait(1) do
        if _0xCFG.ACChest then
            for i, loc in ipairs(ChestLocations) do
                if not _0xCFG.ACChest then break end
                _0xHP.CFrame = loc; task.wait(1.5)
                if i == #ChestLocations then _0xCFG.ACChest = false ChestToggle:Set(false) end
            end
        end
    end
end)

task.spawn(function()
    while true do
        if _0xCFG.ForgeEnabled and _0xCFG.CapturedID then
            local ev = (_0xCFG.ForgeMode == "Normal") and _0xNT.Events.Forge or _0xNT.Events.MagicForge
            pcall(function() ev:FireServer(_0xCFG.CapturedID, true) end)
        end
        task.wait(_0xCFG.ForgeDelay)
    end
end)
