-- Extorius Hub - Rate My Avatar

--  File Saving, Saved Images

SavedImages = {9699712742}
if not isfolder("Extorius Hub RMA") then
    makefolder("Extorius Hub RMA")
end
if not isfile("Extorius Hub RMA/saved_imgs.txt") then
    writefile("Extorius Hub RMA/saved_imgs.txt", game:GetService("HttpService"):JSONEncode(SavedImages))
end
if not isfile("Extorius Hub RMA/saved_animation.txt") then
    delfile("Extorius Hub RMA/saved_animation.txt", game:GetService("HttpService"):JSONEncode(SavedImages))
end

SavedImages = game:GetService("HttpService"):JSONDecode(readfile("Extorius Hub RMA/saved_imgs.txt"))

--  Start of Character Stuff
if not game:IsLoaded() then
    game.Loaded:Wait()
end
repeat
    task.wait()
until game:GetService("Players")

local LocalPlayer = game:GetService("Players").LocalPlayer
loadstring(game:HttpGet("https://pastebin.com/raw/tUUGAeaH", true))()
local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Rayfield/main/source"))()

local function returnHRP()
    if not LocalPlayer.Character then
        return
    end
    if not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        return
    else
        return LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    end
end
local function returnHUM()
    if not LocalPlayer.Character then
        return
    end
    if not LocalPlayer.Character:FindFirstChild("Humanoid") then
        return
    else
        return LocalPlayer.Character:FindFirstChild("Humanoid")
    end
end
repeat
    task.wait()
until returnHRP() and returnHUM()
local HrpTable = {
    Velocity = returnHRP().Velocity,
    Transparency = returnHRP().Transparency,
    Rotation = returnHRP().Rotation,
    Size = returnHRP().Size,
    Orientation = returnHRP().Orientation,
    Anchored = returnHRP().Anchored
}
local HumTable = {
    Health = returnHUM().Health,
    HealthDisplayDistance = returnHUM().HealthDisplayDistance,
    HealthDisplayType = returnHUM().HealthDisplayType,
    HipHeight = returnHUM().HipHeight,
    Jump = returnHUM().Jump,
    JumpPower = returnHUM().JumpPower,
    MaxHealth = returnHUM().MaxHealth,
    Name = returnHUM().Name,
    NameDisplayDistance = returnHUM().NameDisplayDistance,
    NameOcclusion = returnHUM().NameOcclusion,
    PlatformStand = returnHUM().PlatformStand,
    SeatPart = returnHUM().SeatPart,
    Sit = returnHUM().Sit,
    TargetPoint = returnHUM().TargetPoint,
    WalkSpeed = returnHUM().WalkSpeed,
    WalkToPart = returnHUM().WalkToPart,
    WalkToPoint = returnHUM().WalkToPoint
}
local WorkspaceTable = {
    DistributedGameTime = workspace.DistributedGameTime,
    FallenPartsDestroyHeight = workspace.FallenPartsDestroyHeight,
    Gravity = workspace.Gravity
}

local function spoofHRP()
    for i, v in pairs(HrpTable) do
        spoof(returnHRP(), tostring(i), returnHRP():GetAttribute(v))
    end

    return true
end
local function spoofHUM()
    for i, v in pairs(HumTable) do
        spoof(returnHRP(), tostring(i), returnHUM():GetAttribute(v))
    end

    return true
end
local function spoofWorkspace()
    for i, v in pairs(WorkspaceTable) do
        spoof(workspace, tostring(i), returnHUM():GetAttribute(v))
    end

    return true
end

local function Gravity(x)
    spoofWorkspace()
    workspace.Gravity = x
    spoofWorkspace()
end
local function WalkSpeed(x)
    spoofHUM()
    returnHUM().WalkSpeed = x
    spoofHUM()

    return true
end
local function JumpPower(x)
    spoofHUM()
    returnHUM().JumpPower = x
    spoofHUM()

    return true
end

local function TpTo(CFrame, Refresh)
    if Refresh then
        returnHUM().Health = 0
        LocalPlayer.CharacterAdded:Wait()
        repeat
            task.wait()
        until returnHRP() and returnHUM()
        spoofHRP()
        spoofHUM()
    else
        spoofHRP()
    end

    returnHRP().CFrame = CFrame

    return true
end
local function TweenTo(CFrame, Speed)
    returnto = workspace.Gravity
    Gravity(0)

    local goal = {}
    goal.CFrame = CFrame
    local TweenService = game:GetService("TweenService")
    local tweenInfo =
        TweenInfo.new(
        (CFrame.Position - returnHRP().Position).Magnitude / Speed,
        Enum.EasingStyle.Linear,
        Enum.EasingDirection.In,
        0,
        false
    )
    Tween = TweenService:Create(returnHRP(), tweenInfo, goal)
    Tween:Play()
    Tween.Completed:Wait()
    Gravity(returnto)

    return true
end

local function ReplaceHUM()
    spoofHUM()
    n = syn and syn.crypt.random(32) or crypt.generatebytes(32)
    humanoid1 = returnHUM()
    character = humanoid1.Parent

    humanoid1.Name = n

    humanoid2 = humanoid1:Clone()
    humanoid1:Destroy()
    humanoid2.Parent = character
    humanoid2.Name = "Humanoid"

    workspace.CurrentCamera.CameraSubject = character
    humanoid2.DisplayDistanceType = "None"
    spoofHUM()

    return humanoid2
end
local function Netless()
    for _, v in ipairs(returnHUM().Parent:GetDescendants()) do
        if v:IsA("BasePart") and v ~= returnHRP() then
            spoof(v, "Velocity", Vector3.new(0, 0, 0))
            game:GetService("RunService").Heartbeat:Connect(
                function()
                    v.Velocity = Vector3.new(-30, 0, 0)
                end
            )
        end
    end
    return true
end

local function KillPlr(target)
    if not target.Character then
        Rayfield:Notify("Warning", "Player does not have a character.")
        return
    end
    if not target.Character:FindFirstChild("HumanoidRootPart") then
        Rayfield:Notify("Warning", "Player does not have a root part.")
        return
    end
    targetchar = target.Character
    targethrp = targetchar:WaitForChild("HumanoidRootPart")

    ReplaceHUM()
    returnHUM():UnequipTools()

    local foundTool = LocalPlayer.Backpack:FindFirstChildOfClass("Tool")
    if not foundTool then
        Rayfield:Notify("Warning", "No tools in backpack.")
        return
    end
    foundTool.Parent = returnHRP().Parent
    foundTool.Parent = returnHRP()

    GoBack_Sword = returnHRP().CFrame

    firetouchinterest(targethrp, foundTool.Handle, 0)
    firetouchinterest(targethrp, foundTool.Handle, 1)
    returnHRP().CFrame =
        CFrame.new(0, game:GetService("Workspace").FallenPartsDestroyHeight + 4.5, 0) *
        CFrame.Angles(math.rad(190), 0, 0)
    task.wait(.2)
    returnHRP().Parent:Remove()

    LocalPlayer.CharacterAdded:Wait()
    repeat
        task.wait()
    until returnHRP()
    returnHRP().CFrame = GoBack_Sword
end

local function VoidPlr(target)
    if not target.Character then
        Rayfield:Notify("Warning", "Player does not have a character.")
        return
    end
    if not target.Character:FindFirstChild("HumanoidRootPart") then
        Rayfield:Notify("Warning", "Player does not have a root part.")
        return
    end
    targetchar = target.Character
    targethrp = targetchar:WaitForChild("HumanoidRootPart")

    ReplaceHUM()
    returnHUM():UnequipTools()

    local foundTool = LocalPlayer.Backpack:FindFirstChildOfClass("Tool")
    if not foundTool then
        Rayfield:Notify("Warning", "No tools in backpack.")
        return
    end
    foundTool.Parent = returnHRP().Parent
    foundTool.Parent = returnHRP()

    GoBack_Sword = returnHRP().CFrame

    returnHRP().CFrame = CFrame.new(100000, 1000000, 300000)
    firetouchinterest(targethrp, foundTool.Handle, 0)
    firetouchinterest(targethrp, foundTool.Handle, 1)
    task.wait(.2)
    returnHRP().Parent:Remove()

    LocalPlayer.CharacterAdded:Wait()
    repeat
        task.wait()
    until returnHRP()
    returnHRP().CFrame = GoBack_Sword
end

local function GrabPlr(target)
    if not target.Character then
        Rayfield:Notify("Warning", "Player does not have a character.")
        return
    end
    if not target.Character:FindFirstChild("HumanoidRootPart") then
        Rayfield:Notify("Warning", "Player does not have a root part.")
        return
    end
    targetchar = target.Character
    targethrp = targetchar:WaitForChild("HumanoidRootPart")

    ReplaceHUM()
    returnHUM():UnequipTools()

    local foundTool = LocalPlayer.Backpack:FindFirstChildOfClass("Tool")
    if not foundTool then
        Rayfield:Notify("Warning", "No tools in backpack.")
        return
    end
    foundTool.Parent = returnHRP().Parent
    foundTool.Parent = returnHRP()

    GoBack_Sword = returnHRP().CFrame

    firetouchinterest(targethrp, foundTool.Handle, 0)
    firetouchinterest(targethrp, foundTool.Handle, 1)

    LocalPlayer.CharacterAdded:Wait()
    repeat
        task.wait()
    until returnHRP()
    returnHRP().CFrame = GoBack_Sword
end

local function BringPlr(target)
    if not target.Character then
        Rayfield:Notify("Warning", "Player does not have a character.")
        return
    end
    if not target.Character:FindFirstChild("HumanoidRootPart") then
        Rayfield:Notify("Warning", "Player does not have a root part.")
        return
    end
    targetchar = target.Character
    targethrp = targetchar:WaitForChild("HumanoidRootPart")

    ReplaceHUM()
    returnHUM():UnequipTools()

    local foundTool = LocalPlayer.Backpack:FindFirstChildOfClass("Tool")
    if not foundTool then
        Rayfield:Notify("Warning", "No tools in backpack.")
        return
    end
    foundTool.Parent = returnHRP().Parent
    foundTool.Parent = returnHRP()

    GoBack_Sword = returnHRP().CFrame

    firetouchinterest(targethrp, foundTool.Handle, 0)
    firetouchinterest(targethrp, foundTool.Handle, 1)
    task.wait(.4)
    returnHRP().Parent:Remove()

    LocalPlayer.CharacterAdded:Wait()
    repeat
        task.wait()
    until returnHRP()
    returnHRP().CFrame = GoBack_Sword
end

local function GiveTool(target)
    if not target.Character then
        Rayfield:Notify("Warning", "Player does not have a character.")
        return
    end
    if not target.Character:FindFirstChild("HumanoidRootPart") then
        Rayfield:Notify("Warning", "Player does not have a root part.")
        return
    end
    targetchar = target.Character
    targethrp = targetchar:WaitForChild("HumanoidRootPart")

    ReplaceHUM()
    returnHUM():UnequipTools()

    local foundTool = LocalPlayer.Backpack:FindFirstChildOfClass("Tool")
    if not foundTool then
        Rayfield:Notify("Warning", "No tools in backpack.")
        return
    end
    foundTool.Parent = returnHRP().Parent
    foundTool.Parent = returnHRP()

    GoBack_Sword = returnHRP().CFrame

    firetouchinterest(targethrp, foundTool.Handle, 0)
    firetouchinterest(targethrp, foundTool.Handle, 1)
    foundTool.Parent = workspace
    returnHRP().Parent:Remove()

    LocalPlayer.CharacterAdded:Wait()
    repeat
        task.wait()
    until returnHRP()
    returnHRP().CFrame = GoBack_Sword
end

--  Start of Booth Stuff

local CurrentImage = "..."
local CurrentText = "..."

local CurrentAnimation = "Astolfo Laugh"
local Speed_Animations = .05
local Gif_AstolfoLaugh = {
    "rbxassetid://11383396425",
    "rbxassetid://11383396330",
    "rbxassetid://11383396206",
    "rbxassetid://11383396011",
    "rbxassetid://11383395857",
    "rbxassetid://11383395731",
    "rbxassetid://11383395629",
    "rbxassetid://11383395550",
    "rbxassetid://11383395392",
    "rbxassetid://11383395257",
    "rbxassetid://11383395149",
    "rbxassetid://11383395053",
    "rbxassetid://11383394976",
    "rbxassetid://11383394870",
    "rbxassetid://11383394716",
    "rbxassetid://11383394505",
    "rbxassetid://11383394240",
    "rbxassetid://11383394065",
    "rbxassetid://11383393921",
    "rbxassetid://11383393781",
    "rbxassetid://11383393649",
    "rbxassetid://11383393523",
    "rbxassetid://11383393414",
    "rbxassetid://11383393326",
    "rbxassetid://11383393201",
    "rbxassetid://11383393101",
    "rbxassetid://11383393025",
    "rbxassetid://11383392945",
    "rbxassetid://11383392848",
    "rbxassetid://11383392720",
    "rbxassetid://11383392602",
    "rbxassetid://11383392459",
    "rbxassetid://11383392312",
    "rbxassetid://11383392189",
    "rbxassetid://11383392053",
    "rbxassetid://11383391916",
    "rbxassetid://11383391757",
    "rbxassetid://11383391573",
    "rbxassetid://11383391345",
    "rbxassetid://11383391165",
    "rbxassetid://11383391035",
    "rbxassetid://11383390912",
    "rbxassetid://11383390811",
    "rbxassetid://11383390702",
    "rbxassetid://11383390544",
    "rbxassetid://11383390378",
    "rbxassetid://11383390246",
    "rbxassetid://11383390103",
    "rbxassetid://11383389982",
    "rbxassetid://11383389653",
    "rbxassetid://11383389356",
    "rbxassetid://11383389115",
    "rbxassetid://11383388978",
    "rbxassetid://11383388836",
    "rbxassetid://11383388651"
}
local Gif_AstolfoRoll = {
    "rbxassetid://11383578487",
    "rbxassetid://11383578360",
    "rbxassetid://11383578193",
    "rbxassetid://11383577994",
    "rbxassetid://11383577873",
    "rbxassetid://11383577735",
    "rbxassetid://11383577565",
    "rbxassetid://11383577417",
    "rbxassetid://11383577255",
    "rbxassetid://11383577135",
    "rbxassetid://11383577008",
    "rbxassetid://11383576874",
    "rbxassetid://11383576758",
    "rbxassetid://11383576563",
    "rbxassetid://11383576392",
    "rbxassetid://11383576248",
    "rbxassetid://11383576092",
    "rbxassetid://11383575957",
    "rbxassetid://11383575788",
    "rbxassetid://11383575576",
    "rbxassetid://11383575367",
    "rbxassetid://11383575198",
    "rbxassetid://11383575087",
    "rbxassetid://11383574988",
    "rbxassetid://11383574870",
    "rbxassetid://11383574740",
    "rbxassetid://11383574581",
    "rbxassetid://11383574471",
    "rbxassetid://11383574313",
    "rbxassetid://11383574187",
    "rbxassetid://11383574033",
    "rbxassetid://11383573885",
    "rbxassetid://11383573725",
    "rbxassetid://11383573567",
    "rbxassetid://11383573425",
    "rbxassetid://11383573293",
    "rbxassetid://11383573181",
    "rbxassetid://11383573031",
    "rbxassetid://11383572819",
    "rbxassetid://11383572619",
    "rbxassetid://11383572468",
    "rbxassetid://11383572319",
    "rbxassetid://11383572128",
    "rbxassetid://11383571968",
    "rbxassetid://11383571817",
    "rbxassetid://11383571686",
    "rbxassetid://11383571581",
    "rbxassetid://11383571405",
    "rbxassetid://11383571259",
    "rbxassetid://11383571050",
    "rbxassetid://11383570914",
    "rbxassetid://11383570759",
    "rbxassetid://11383570572",
    "rbxassetid://11383570466",
    "rbxassetid://11383570329",
    "rbxassetid://11383570206",
    "rbxassetid://11383570099",
    "rbxassetid://11383570007",
    "rbxassetid://11383569897",
    "rbxassetid://11383569787",
    "rbxassetid://11383569677",
    "rbxassetid://11383569449",
    "rbxassetid://11383569295",
    "rbxassetid://11383569142",
    "rbxassetid://11383568979",
    "rbxassetid://11383568800",
    "rbxassetid://11383568673",
    "rbxassetid://11383568522",
    "rbxassetid://11383578968",
    "rbxassetid://11383568303",
    "rbxassetid://11383568197",
    "rbxassetid://11383568076",
    "rbxassetid://11383567930",
    "rbxassetid://11383567781",
    "rbxassetid://11383567561",
    "rbxassetid://11383567368",
    "rbxassetid://11383567186",
    "rbxassetid://11383567071",
    "rbxassetid://11383566957",
    "rbxassetid://11383566771",
    "rbxassetid://11383566691",
    "rbxassetid://11383566569",
    "rbxassetid://11383566457"
}

local Gif_AstolfoExplains = {
    "rbxassetid://11385736162",
    "rbxassetid://11385735591",
    "rbxassetid://11385735324",
    "rbxassetid://11385735044",
    "rbxassetid://11385734768",
    "rbxassetid://11385734561",
    "rbxassetid://11385734351",
    "rbxassetid://11385734154",
    "rbxassetid://11385733963",
    "rbxassetid://11385733846",
    "rbxassetid://11385733687",
    "rbxassetid://11385733433",
    "rbxassetid://11385733242",
    "rbxassetid://11385733036",
    "rbxassetid://11385732823",
    "rbxassetid://11385732669",
    "rbxassetid://11385732512",
    "rbxassetid://11385732291",
    "rbxassetid://11385732151",
    "rbxassetid://11385731801",
    "rbxassetid://11385731582",
    "rbxassetid://11385731243",
    "rbxassetid://11385731033",
    "rbxassetid://11385730878",
    "rbxassetid://11385730687",
    "rbxassetid://11385730444",
    "rbxassetid://11385730124",
    "rbxassetid://11385729921",
    "rbxassetid://11385729803",
    "rbxassetid://11385729623",
    "rbxassetid://11385729469",
    "rbxassetid://11385729265",
    "rbxassetid://11385729073",
    "rbxassetid://11385728891",
    "rbxassetid://11385728787",
    "rbxassetid://11385728664",
    "rbxassetid://11385728501",
    "rbxassetid://11385728308",
    "rbxassetid://11385728173",
    "rbxassetid://11385727960"
}

local namecall
namecall =
    hookmetamethod(
    game,
    "__namecall",
    function(calledon, ...)
        local method = getnamecallmethod()
        local args = {...}
        local args2 = args[2]
        if method == "FireServer" and calledon.Name == "CustomiseBooth" then
            CurrentImage = args2["ImageId"]
            CurrentText = args2["DescriptionText"]
        end
        if method == "FireServer" and calledon.Name == "RequestRespawn" then
            if not Disabled_Blacklist then
                return namecall(calledon, ...)
            end
        else
            return namecall(calledon, ...)
        end
    end
)

local function UpdateBooth(text, image)
    game:GetService("ReplicatedStorage").CustomiseBooth:FireServer(
        table.unpack(
            {
                [1] = "Update",
                [2] = {
                    ["DescriptionText"] = text,
                    ["ImageId"] = image
                }
            }
        )
    )
end

local function ReturnBooth()
    FoundBooth = nil
    oldimage = CurrentImage
    oldtext = CurrentText

    ranstring = "Finding Booth\n\n" .. tostring(math.random(100, 999))
    UpdateBooth(ranstring)
    task.wait(.3)
    for _, v in ipairs(workspace:GetChildren()) do
        if v.Name == "Booth" then
            if v.Banner.SurfaceGui.Frame.Description.Text == ranstring then
                FoundBooth = v
            end
        end
    end

    UpdateBooth(oldtext, oldimage)
    return FoundBooth
end

local function SnipeBooth(Notify)
    ReturnBooth()
    if not FoundBooth then
        SnipedBooth = nil
        for _, v in ipairs(workspace:GetChildren()) do
            if not SnipedBooth then
                if v.Name == "Booth" then
                    if v.Banner.SurfaceGui.Frame.Description.Text == "Click here to rent this booth" then
                        returnHRP().CFrame = v.Banner.CFrame
                        task.wait(.2)
                        fireclickdetector(v.Banner.ClickDetector)

                        FoundBooth = v
                        SnipedBooth = v
                    end
                end
            end
        end

        if SnipedBooth then
            return SnipedBooth
        else
            if Notify then
                Rayfield:Notify("Warning", "There are currently no available booths.")
            end
        end
    else
        Rayfield:Notify("Warning", "You already have a booth.")
        return "Has Booth"
    end
end

--  Start of Knight Stuff

local function ReturnKnight()
    local Team_Knight = game:GetService("Teams")["Knight"]
    if LocalPlayer.Team == Team_Knight then
        return true
    else
        return false
    end
end

local function SnipeKnight(ClaimedNotify)
    if not ReturnKnight() then
        local target = game:GetService("Workspace"):WaitForChild("JewelleryStand")
        if target.Transparency ~= 1 then
            GoBack_Knight = returnHRP().CFrame
            repeat
                task.wait()
                returnHRP().CFrame = target.CFrame
            until target.ProximityPrompt
            task.wait(.5)
            fireproximityprompt(target.ProximityPrompt)
            task.wait(.1)
            returnHRP().CFrame = GoBack_Knight
        else
            if ClaimedNotify == true then
                Rayfield:Notify("Warning", "Knight is already claimed.")
                return "Knight Claimed"
            end
        end
    else
        Rayfield:Notify("Warning", "You are already Knight.")
        return "Has Knight"
    end
end

--  Start of UI Stuff
local Window =
    Rayfield:CreateWindow(
    {
        Name = "Extirus Hub | RMA",
        LoadingTitle = "Extorius Hub",
        LoadingSubtitle = "by Extorius Scripts",
        KeySystem = false,
        KeySettings = {
            Title = "Extorius Hub",
            Subtitle = "Key System",
            Note = "Link for the key is copied to your clipboard.",
            Key = ""
        }
    }
)

local Tab = Window:CreateTab("Booth")
local Section = Tab:CreateSection("Snipe")

Tab:CreateButton(
    {
        Name = "Available Booths",
        Callback = function()
            AvailableBooths = 0
            for _, v in ipairs(workspace:GetChildren()) do
                if not SnipedBooth then
                    if v.Name == "Booth" then
                        if v.Banner.SurfaceGui.Frame.Description.Text == "Click here to rent this booth" then
                            AvailableBooths = AvailableBooths + 1
                        end
                    end
                end
            end

            Rayfield:Notify(
                "Available Booths",
                "There are currently " .. AvailableBooths .. " booths available in your server."
            )
        end
    }
)
Tab:CreateButton(
    {
        Name = "Snipe Booth",
        Callback = function()
            SnipeBooth(true)
        end
    }
)
Tab:CreateToggle(
    {
        Name = "Auto Snipe Booth",
        CurrentValue = false,
        Callback = function(Value)
            Auto_SnipeBooth = Value
            while Auto_SnipeBooth do
                task.wait()
                SnipeBooth_func = SnipeBooth(false)
                if SnipeBooth_func == "Has Booth" then
                    break
                end
            end
        end
    }
)

local Section = Tab:CreateSection("Customise")
Tab:CreateInput(
    {
        Name = "Booth Text",
        PlaceholderText = CurrentText,
        RemoveTextAfterFocusLost = false,
        Callback = function(Text)
            UpdateBooth(Text, CurrentImage)
        end
    }
)
Tab:CreateInput(
    {
        Name = "Booth Image",
        PlaceholderText = CurrentImage,
        RemoveTextAfterFocusLost = false,
        Callback = function(Text)
            if Text == "" or Text == nil or string.match(Text, "%D") then
                Rayfield:Notify("Warning", "Invalid input, can only include numbers.")
            else
                UpdateBooth(CurrentText, tonumber(Text))
            end
        end
    }
)
Tab:CreateInput(
    {
        Name = "Bypass Text",
        PlaceholderText = CurrentImage,
        RemoveTextAfterFocusLost = false,
        Callback = function(Text)
            if 16 >= string.len(Text) then
                for v in Text:gmatch "." do
                    GoBack_Bypass = CurrentText
                    wait(string.len(Text) / 8)
                    UpdateBooth(v, tonumber(CurrentImage))
                    wait(.5)

                    UpdateBooth(".\n\n\n\n\n\n\n" .. math.random(1000, 9999), tonumber(CurrentImage))
                    UpdateBooth(".\n\n\n\n\n\n\n" .. math.random(1000, 9999), tonumber(CurrentImage))
                    CurrentText = GoBack_Bypass
                    UpdateBooth(CurrentText, tonumber(CurrentImage))
                end
            else
                Rayfield:Notify(
                    "Warning",
                    "Your text is " .. tostring(string.len(Text) - 16) .. " characters too long."
                )
            end
        end
    }
)

Tab:CreateButton(
    {
        Name = "Save Current Image",
        Callback = function()
            table.insert(SavedImages, CurrentImage)
            writefile("Extorius Hub RMA/saved_imgs.txt", game:GetService("HttpService"):JSONEncode(SavedImages))
        end
    }
)

Tab:CreateButton(
    {
        Name = "Update Saved Images",
        Callback = function()
            local queue_on_teleport = syn and syn.queue_on_teleport or queue_on_teleport
            if (queue_on_teleport) then
                queue_on_teleport(
                    'loadstring(game.HttpGet(game, "https://raw.githubusercontent.com/DefinitelyWill/untitled-rma-gui/main/source.lua"))()'
                )
            end

            TeleportService = game:GetService("TeleportService")
            TeleportService.TeleportToPlaceInstance(TeleportService, game.PlaceId, game.JobId)
        end
    }
)

ClearAttempts_Imgs = 0
Tab:CreateButton(
    {
        Name = "Clear Saved Images",
        Callback = function()
            ClearAttempts_Imgs = ClearAttempts_Imgs + 1
            if ClearAttempts_Imgs == 1 then
                Rayfield:Notify(
                    "Warning",
                    "Are you sure you would like to clear your saved images? Press button again to confirm."
                )
            else
                SavedImages = {9699712742}
                writefile("Extorius Hub RMA/saved_imgs.txt", game:GetService("HttpService"):JSONEncode(SavedImages))
                Rayfield:Notify("Success", "Cleared saved images.")
                task.wait(5)
                ClearAttempts_Imgs = 0
            end
        end
    }
)
Tab:CreateDropdown(
    {
        Name = "Saved Images",
        Options = SavedImages,
        CurrentOption = tostring(SavedImages[1]),
        Callback = function(Option)
            UpdateBooth(CurrentText, tonumber(Option))
        end
    }
)

local Section = Tab:CreateSection("Booth Misc.")
Tab:CreateButton(
    {
        Name = "Teleport to Booth",
        Callback = function()
            ReturnBooth()
            if FoundBooth then
                returnHRP().CFrame = ReturnBooth().Banner.CFrame
            else
                Rayfield:Notify("Warning", "You do not currently own a booth.")
            end
        end
    }
)

local Section = Tab:CreateSection("Booth Animations")
Tab:CreateDropdown(
    {
        Name = "Animations",
        Options = {"Astolfo Laugh", "Astolfo Roll", "Astolfo Explains"},
        CurrentOption = "Astolfo Laugh",
        Callback = function(Option)
            CurrentAnimation = Option
        end
    }
)
Tab:CreateToggle(
    {
        Name = "Animate",
        CurrentValue = false,
        Callback = function(Value)
            Auto_AnimateBooth = Value
            while Auto_AnimateBooth do
                task.wait()
                if CurrentAnimation == "Astolfo Laugh" then
                    for _, v in pairs(Gif_AstolfoLaugh) do
                        if Auto_AnimateBooth then
                            GoBack_Animate = CurrentText
                            v = string.gsub(v, "rbxassetid://", "")
                            UpdateBooth(GoBack_Animate, tonumber(v))
                            task.wait(Speed_Animations)
                        end
                    end
                elseif CurrentAnimation == "Astolfo Roll" then
                    for _, v in pairs(Gif_AstolfoRoll) do
                        if Auto_AnimateBooth then
                            GoBack_Animate = CurrentText
                            v = string.gsub(v, "rbxassetid://", "")
                            UpdateBooth(GoBack_Animate, tonumber(v))
                            task.wait(Speed_Animations)
                        end
                    end
                elseif CurrentAnimation == "Astolfo Explains" then
                    for _, v in pairs(Gif_AstolfoExplains) do
                        if Auto_AnimateBooth then
                            GoBack_Animate = CurrentText
                            v = string.gsub(v, "rbxassetid://", "")
                            UpdateBooth(GoBack_Animate, tonumber(v))
                            task.wait(Speed_Animations)
                        end
                    end
                end
            end
        end
    }
)
Tab:CreateSlider(
    {
        Name = "Animation Speed",
        Range = {0, .1},
        Increment = .01,
        Suffix = "",
        CurrentValue = .05,
        Callback = function(Value)
            Speed_Animations = Value
        end
    }
)
Tab:CreateButton(
    {
        Name = "Load Animations",
        Callback = function()
            GoBack_LoadImgs = CurrentImage
            for i = 1, 2 do
                task.wait()
                for _, v in pairs(Gif_AstolfoLaugh) do
                    GoBack_Animate = CurrentText
                    v = string.gsub(v, "rbxassetid://", "")
                    UpdateBooth(GoBack_Animate, tonumber(v))
                end
                for _, v in pairs(Gif_AstolfoRoll) do
                    GoBack_Animate = CurrentText
                    v = string.gsub(v, "rbxassetid://", "")
                    UpdateBooth(GoBack_Animate, tonumber(v))
                end
                for _, v in pairs(Gif_AstolfoExplains) do
                    GoBack_Animate = CurrentText
                    v = string.gsub(v, "rbxassetid://", "")
                    UpdateBooth(GoBack_Animate, tonumber(v))
                end
            end

            task.wait(.1)
            UpdateBooth(GoBack_Animate, GoBack_LoadImgs)
        end
    }
)

local Tab = Window:CreateTab("Signs")
local Section = Tab:CreateSection("Equip")

Tab:CreateButton(
    {
        Name = "Equip Image Sign",
        Callback = function()
            returnHUM():UnequipTools()
            game:GetService("ReplicatedStorage").RequestGamepassTool:FireServer(17291427)
            LocalPlayer.Backpack:WaitForChild("Image Sign").Parent = returnHRP().Parent
        end
    }
)
Tab:CreateButton(
    {
        Name = "Equip Text Sign",
        Callback = function()
            returnHUM():UnequipTools()
            game:GetService("ReplicatedStorage").RequestGamepassTool:FireServer(17291420)
            LocalPlayer.Backpack:WaitForChild("Text Sign").Parent = returnHRP().Parent
        end
    }
)
Tab:CreateToggle(
    {
        Name = "Auto Equip Image Sign",
        CurrentValue = false,
        Callback = function(Value)
            Auto_EquipImageSign = Value
            while Auto_EquipImageSign do
                task.wait()
                game:GetService("ReplicatedStorage").RequestGamepassTool:FireServer(17291427)
            end
        end
    }
)
Tab:CreateToggle(
    {
        Name = "Auto Equip Text Sign",
        CurrentValue = false,
        Callback = function(Value)
            Auto_EquipTextSign = Value
            while Auto_EquipImageSign do
                task.wait()
                game:GetService("ReplicatedStorage").RequestGamepassTool:FireServer(17291420)
            end
        end
    }
)
local Section = Tab:CreateSection("Saved Images")
Tab:CreateDropdown(
    {
        Name = "Saved Images",
        Options = SavedImages,
        CurrentOption = tostring(SavedImages[1]),
        Callback = function(Option)
            game:GetService("ReplicatedStorage").UpdateSign:FireServer(
                table.unpack(
                    {
                        [1] = "Decal",
                        [2] = "rbxassetid://" .. tostring(Option)
                    }
                )
            )
        end
    }
)
local Section = Tab:CreateSection("Image Sign Animations")
Tab:CreateDropdown(
    {
        Name = "Animations",
        Options = {"Astolfo Laugh", "Astolfo Roll", "Astolfo Explains"},
        CurrentOption = "Astolfo Laugh",
        Callback = function(Option)
            CurrentAnimation = Option
        end
    }
)
Tab:CreateToggle(
    {
        Name = "Animate",
        CurrentValue = false,
        Callback = function(Value)
            Auto_AnimateSign = Value
            while Auto_AnimateSign do
                task.wait()
                if CurrentAnimation == "Astolfo Laugh" then
                    for _, v in pairs(Gif_AstolfoLaugh) do
                        if Auto_AnimateSign then
                            game:GetService("ReplicatedStorage").UpdateSign:FireServer(
                                table.unpack(
                                    {
                                        [1] = "Decal",
                                        [2] = v
                                    }
                                )
                            )
                            task.wait(Speed_Animations)
                        end
                    end
                elseif CurrentAnimation == "Astolfo Roll" then
                    for _, v in pairs(Gif_AstolfoRoll) do
                        if Auto_AnimateSign then
                            game:GetService("ReplicatedStorage").UpdateSign:FireServer(
                                table.unpack(
                                    {
                                        [1] = "Decal",
                                        [2] = v
                                    }
                                )
                            )
                            task.wait(Speed_Animations)
                        end
                    end
                elseif CurrentAnimation == "Astolfo Explains" then
                    for _, v in pairs(Gif_AstolfoExplains) do
                        if Auto_AnimateSign then
                            game:GetService("ReplicatedStorage").UpdateSign:FireServer(
                                table.unpack(
                                    {
                                        [1] = "Decal",
                                        [2] = v
                                    }
                                )
                            )
                            task.wait(Speed_Animations)
                        end
                    end
                end
            end
        end
    }
)
Tab:CreateSlider(
    {
        Name = "Animation Speed",
        Range = {0, .1},
        Increment = .01,
        Suffix = "",
        CurrentValue = .05,
        Callback = function(Value)
            Speed_Animations = Value
        end
    }
)

local Tab = Window:CreateTab("Knight")
local Section = Tab:CreateSection("Snipe")

Tab:CreateButton(
    {
        Name = "Snipe Knight",
        Callback = function()
            SnipeKnight(true)
        end
    }
)
Tab:CreateToggle(
    {
        Name = "Auto Snipe Knight",
        CurrentValue = false,
        Callback = function(Value)
            Auto_SnipeKnight = Value
            while Auto_SnipeKnight do
                task.wait()
                SnipeKnight_func = SnipeKnight(false)
                if SnipeKnight_func == "Has Knight" then
                    break
                end
            end
        end
    }
)
AutoAttempts_ClaimKnight = 0
Tab:CreateButton(
    {
        Name = "Server Hop Snipe",
        Callback = function()
            AutoAttempts_ClaimKnight = AutoAttempts_ClaimKnight + 1
            if AutoAttempts_ClaimKnight == 1 then
                Rayfield:Notify(
                    "Warning",
                    "Are you sure you would like to server hop snipe knight? Press button again to confirm."
                )
            else
                local queue_on_teleport = syn and syn.queue_on_teleport or queue_on_teleport
                if (queue_on_teleport) then
                    queue_on_teleport(
                        'loadstring(game.HttpGet(game, "https://raw.githubusercontent.com/DefinitelyWill/untitled-rma-gui/main/auto%20claim%20knight.lua"))()'
                    )
                end

                TeleportService = game:GetService("TeleportService")
                TeleportService.TeleportToPlaceInstance(TeleportService, game.PlaceId, game.JobId)
                task.wait(5)
                AutoAttempts_ClaimKnight = 0
            end
        end
    }
)

local Section = Tab:CreateSection("Knight Misc.")
Tab:CreateButton(
    {
        Name = "Remove Kick",
        Callback = function()
            LocalPlayer.PlayerGui.ManagerGui.ServerSettingFrame.KillButton.Visible = false
        end
    }
)
Tab:CreateButton(
    {
        Name = "Remove Knight",
        Callback = function()
            local queue_on_teleport = syn and syn.queue_on_teleport or queue_on_teleport
            if (queue_on_teleport) then
                queue_on_teleport(
                    'loadstring(game.HttpGet(game, "https://raw.githubusercontent.com/DefinitelyWill/untitled-rma-gui/main/source.lua"))()'
                )
            end

            TeleportService = game:GetService("TeleportService")
            TeleportService.TeleportToPlaceInstance(TeleportService, game.PlaceId, game.JobId)
        end
    }
)

local Section = Tab:CreateSection("Sword")
Tab:CreateButton(
    {
        Name = "Give Sword",
        Callback = function()
            game:GetService("ReplicatedStorage"):WaitForChild("RequestTool"):FireServer("ClassicSword")
        end
    }
)
Tab:CreateToggle(
    {
        Name = "Auto Give Sword",
        CurrentValue = false,
        Callback = function(Value)
            Auto_GiveSword = Value
            while Auto_GiveSword do
                task.wait()
                game:GetService("ReplicatedStorage"):WaitForChild("RequestTool"):FireServer("ClassicSword")
            end
        end
    }
)

local Tab = Window:CreateTab("Tools")
Tab:CreateInput(
    {
        Name = "Give Tool",
        PlaceholderText = "Player Name",
        RemoveTextAfterFocusLost = true,
        Callback = function(Text)
            Text = string.lower(Text)
            for _, v in ipairs(game:GetService("Players"):GetPlayers()) do
                if string.lower(v.DisplayName):match(Text) or string.lower(v.Name):match(Text) then
                    Plr_Tool = v
                end
            end

            if Plr_Tool then
                if Plr_Tool ~= LocalPlayer then
                    GiveTool(Plr_Tool)
                else
                    Rayfield:Notify("Warning", "You cannot select yourself.")
                end
            else
                Rayfield:Notify("Warning", "Could not find any players matching that.")
            end

            Plr_Tool = nil
        end
    }
)
Tab:CreateInput(
    {
        Name = "Kill",
        PlaceholderText = "Player Name",
        RemoveTextAfterFocusLost = true,
        Callback = function(Text)
            Text = string.lower(Text)
            for _, v in ipairs(game:GetService("Players"):GetPlayers()) do
                if string.lower(v.DisplayName):match(Text) or string.lower(v.Name):match(Text) then
                    Plr_Tool = v
                end
            end

            if Plr_Tool then
                if Plr_Tool ~= LocalPlayer then
                    KillPlr(Plr_Tool)
                else
                    Rayfield:Notify("Warning", "You cannot select yourself.")
                end
            else
                Rayfield:Notify("Warning", "Could not find any players matching that.")
            end

            Plr_Tool = nil
        end
    }
)
Tab:CreateInput(
    {
        Name = "Bring",
        PlaceholderText = "Player Name",
        RemoveTextAfterFocusLost = true,
        Callback = function(Text)
            Text = string.lower(Text)
            for _, v in ipairs(game:GetService("Players"):GetPlayers()) do
                if string.lower(v.DisplayName):match(Text) or string.lower(v.Name):match(Text) then
                    Plr_Tool = v
                end
            end

            if Plr_Tool then
                if Plr_Tool ~= LocalPlayer then
                    BringPlr(Plr_Tool)
                else
                    Rayfield:Notify("Warning", "You cannot select yourself.")
                end
            else
                Rayfield:Notify("Warning", "Could not find any players matching that.")
            end

            Plr_Tool = nil
        end
    }
)
Tab:CreateInput(
    {
        Name = "Grab",
        PlaceholderText = "Player Name",
        RemoveTextAfterFocusLost = true,
        Callback = function(Text)
            Text = string.lower(Text)
            for _, v in ipairs(game:GetService("Players"):GetPlayers()) do
                if string.lower(v.DisplayName):match(Text) or string.lower(v.Name):match(Text) then
                    Plr_Tool = v
                end
            end

            if Plr_Tool then
                if Plr_Tool ~= LocalPlayer then
                    GrabPlr(Plr_Tool)
                else
                    Rayfield:Notify("Warning", "You cannot select yourself.")
                end
            else
                Rayfield:Notify("Warning", "Could not find any players matching that.")
            end

            Plr_Tool = nil
        end
    }
)
Tab:CreateInput(
    {
        Name = "Void",
        PlaceholderText = "Player Name",
        RemoveTextAfterFocusLost = true,
        Callback = function(Text)
            Text = string.lower(Text)
            for _, v in ipairs(game:GetService("Players"):GetPlayers()) do
                if string.lower(v.DisplayName):match(Text) or string.lower(v.Name):match(Text) then
                    Plr_Tool = v
                end
            end

            if Plr_Tool then
                if Plr_Tool ~= LocalPlayer then
                    VoidPlr(Plr_Tool)
                else
                    Rayfield:Notify("Warning", "You cannot select yourself.")
                end
            else
                Rayfield:Notify("Warning", "Could not find any players matching that.")
            end

            Plr_Tool = nil
        end
    }
)

local Tab = Window:CreateTab("Rate")
Tab:CreateDropdown(
    {
        Name = "Stars",
        Options = {"1", "2", "3", "4", "5"},
        CurrentOption = "5",
        Callback = function(Option)
            Option = tonumber(Option)
            Integer_RateStars = Option
        end
    }
)
Tab:CreateInput(
    {
        Name = "Rate Player",
        PlaceholderText = "Player Name",
        RemoveTextAfterFocusLost = true,
        Callback = function(Text)
            Text = string.lower(Text)
            for _, v in ipairs(game:GetService("Players"):GetPlayers()) do
                if string.lower(v.DisplayName):match(Text) or string.lower(v.Name):match(Text) then
                    Plr_Rate = v
                end
            end

            if Plr_Rate then
                if Plr_Rate ~= LocalPlayer then
                    game:GetService("ReplicatedStorage").PostRating:FireServer(
                        table.unpack(
                            {
                                [1] = Plr_Rate,
                                [2] = Integer_RateStars
                            }
                        )
                    )
                else
                    Rayfield:Notify("Warning", "You cannot select yourself.")
                end
            else
                Rayfield:Notify("Warning", "Could not find any players matching that.")
            end

            Plr_Rate = nil
        end
    }
)
Tab:CreateButton(
    {
        Name = "Rate All",
        Callback = function()
            for _, v in ipairs(game:GetService("Players"):GetPlayers()) do
                game:GetService("ReplicatedStorage").PostRating:FireServer(
                    table.unpack(
                        {
                            [1] = v,
                            [2] = Integer_RateStars
                        }
                    )
                )
            end
        end
    }
)
Tab:CreateToggle(
    {
        Name = "Auto Rate All",
        CurrentValue = false,
        Callback = function(Value)
            Auto_RateAll = Value
            while Auto_RateAll do
                task.wait()
                for _, v in ipairs(game:GetService("Players"):GetPlayers()) do
                    task.wait()
                    game:GetService("ReplicatedStorage").PostRating:FireServer(
                        table.unpack(
                            {
                                [1] = v,
                                [2] = Integer_RateStars
                            }
                        )
                    )
                end
            end
        end
    }
)

local Tab = Window:CreateTab("Blacklist")
Tab:CreateToggle(
    {
        Name = "Anti Blacklist",
        CurrentValue = false,
        Callback = function(Value)
            Auto_AntiBlacklist = Value
            Disabled_Blacklist = Value
            while Auto_AntiBlacklist do
                task.wait()
                for _, v in ipairs(workspace:GetChildren()) do
                    if v.Name:match("Barrier") then
                        v.BrickColor = BrickColor.new(1020)
                    end
                end
            end
            if Value == false then
                task.wait(.1)
                for _, v in ipairs(workspace:GetChildren()) do
                    if v.Name:match("Barrier") then
                        v.BrickColor = BrickColor.new(327)
                    end
                end
            end
        end
    }
)
Tab:CreateToggle(
    {
        Name = "Blacklist Others",
        CurrentValue = false,
        Callback = function(Value)
            if Value == true then
                Blacklist_Others = "AddBlacklist"
                Rayfield:Notify("Success", "Added blacklist for others.")
            else
                Blacklist_Others = "RemoveBlacklist"
                Rayfield:Notify("Success", "Removed blacklist for others.")
            end

            for _, v in ipairs(game:GetService("Players"):GetPlayers()) do
                if v ~= LocalPlayer then
                    game:GetService("ReplicatedStorage").CustomiseBooth:FireServer(
                        table.unpack(
                            {
                                [1] = Blacklist_Others,
                                [2] = v.Name
                            }
                        )
                    )
                end
            end
        end
    }
)
Tab:CreateToggle(
    {
        Name = "Blacklist Flicker",
        CurrentValue = false,
        Callback = function(Value)
            Auto_BlacklistFlicker = Value
            if Value == true then
                Rayfield:Notify("Success", "Added blacklist flicker for others.")
            else
                Rayfield:Notify("Success", "Removed blacklist for others.")
                task.wait(.2)

                for _, v in ipairs(game:GetService("Players"):GetPlayers()) do
                    if v ~= LocalPlayer then
                        game:GetService("ReplicatedStorage").CustomiseBooth:FireServer(
                            table.unpack(
                                {
                                    [1] = "RemoveBlacklist",
                                    [2] = v.Name
                                }
                            )
                        )
                    end
                end
            end

            Table_Blacklist = {"AddBlacklist", "RemoveBlacklist"}
            while Auto_BlacklistFlicker do
                for _, v in ipairs(game:GetService("Players"):GetPlayers()) do
                    if v ~= LocalPlayer then
                        task.wait()
                        game:GetService("ReplicatedStorage").CustomiseBooth:FireServer(
                            table.unpack(
                                {
                                    [1] = Table_Blacklist[math.random(1, 2)],
                                    [2] = v.Name
                                }
                            )
                        )
                    end
                end
            end
        end
    }
)
Tab:CreateInput(
    {
        Name = "Blacklist",
        PlaceholderText = "Player Name",
        RemoveTextAfterFocusLost = true,
        Callback = function(Text)
            Text = string.lower(Text)
            for _, v in ipairs(game:GetService("Players"):GetPlayers()) do
                if string.lower(v.DisplayName):match(Text) or string.lower(v.Name):match(Text) then
                    Plr_Blacklist = v
                end
            end

            if Plr_Blacklist then
                if Plr_Blacklist ~= LocalPlayer then
                    game:GetService("ReplicatedStorage").CustomiseBooth:FireServer(
                        table.unpack(
                            {
                                [1] = "AddBlacklist",
                                [2] = Plr_Blacklist.Name
                            }
                        )
                    )

                    Rayfield:Notify("Success", "Added blacklist to " .. Plr.DisplayName)
                else
                    Rayfield:Notify("Warning", "You cannot select yourself.")
                end
            else
                Rayfield:Notify("Warning", "Could not find any players matching that.")
            end

            Plr_Blacklist = nil
        end
    }
)
Tab:CreateInput(
    {
        Name = "Unblacklist",
        PlaceholderText = "Player Name",
        RemoveTextAfterFocusLost = true,
        Callback = function(Text)
            Text = string.lower(Text)
            for _, v in ipairs(game:GetService("Players"):GetPlayers()) do
                if string.lower(v.DisplayName):match(Text) or string.lower(v.Name):match(Text) then
                    Plr_Blacklist = v
                end
            end

            if Plr_Blacklist then
                if Plr_Blacklist ~= LocalPlayer then
                    game:GetService("ReplicatedStorage").CustomiseBooth:FireServer(
                        table.unpack(
                            {
                                [1] = "RemoveBlacklist",
                                [2] = Plr_Blacklist.Name
                            }
                        )
                    )

                    Rayfield:Notify("Success", "Removed blacklist to " .. Plr.DisplayName)
                else
                    Rayfield:Notify("Warning", "You cannot select yourself.")
                end
            else
                Rayfield:Notify("Warning", "Could not find any players matching that.")
            end

            Plr_Blacklist = nil
        end
    }
)

local Tab = Window:CreateTab("Local Player")
local Section = Tab:CreateSection("Character")
Tab:CreateSlider(
    {
        Name = "Walk Speed",
        Range = {0, 100},
        Increment = 1,
        Suffix = "",
        CurrentValue = 16,
        Callback = function(Value)
            WalkSpeed(Value)
        end
    }
)
Tab:CreateSlider(
    {
        Name = "Jump Power",
        Range = {0, 500},
        Increment = 10,
        Suffix = "",
        CurrentValue = 50,
        Callback = function(Value)
            JumpPower(Value)
        end
    }
)
Tab:CreateSlider(
    {
        Name = "Gravity",
        Range = {0, 500},
        Increment = workspace.Gravity,
        Suffix = "",
        CurrentValue = 50,
        Callback = function(Value)
            Gravity(Value)
        end
    }
)
Tab:CreateButton(
    {
        Name = "Netless",
        Callback = function()
            Netless()
        end
    }
)
Tab:CreateButton(
    {
        Name = "Replace Humanoid",
        Callback = function()
            ReplaceHUM()
        end
    }
)
local Section = Tab:CreateSection("Game")
Tab:CreateToggle(
    {
        Name = "Anti Idle",
        CurrentValue = false,
        Callback = function(Value)
            Auto_AntiIdle = Value
            vu = game:GetService("VirtualUser")
            LocalPlayer.Idled:Connect(
                function()
                    if Auto_AntiIdle then
                        vu:ClickButton1(Vector2.new(0, 0))
                    end
                end
            )
        end
    }
)
Tab:CreateButton(
    {
        Name = "Rejoin",
        Callback = function()
            TeleportService = game:GetService("TeleportService")
            TeleportService.TeleportToPlaceInstance(TeleportService, game.PlaceId, game.JobId)
        end
    }
)
Tab:CreateButton(
    {
        Name = "Refresh Script",
        Callback = function()
            local queue_on_teleport = syn and syn.queue_on_teleport or queue_on_teleport
            if (queue_on_teleport) then
                queue_on_teleport(
                    'loadstring(game.HttpGet(game, "https://raw.githubusercontent.com/DefinitelyWill/untitled-rma-gui/main/source.lua"))()'
                )
            end

            TeleportService = game:GetService("TeleportService")
            TeleportService.TeleportToPlaceInstance(TeleportService, game.PlaceId, game.JobId)
        end
    }
)

local Tab = Window:CreateTab("Bypass")
Tab:CreateToggle(
    {
        Name = "Premium Lounge",
        CurrentValue = false,
        Callback = function(Value)
            Bypass_PremiumLounge = Value
            while Bypass_PremiumLounge do
                task.wait()
                if LocalPlayer.PlayerGui.ProximityPrompts:FindFirstChild("Prompt") then
                    Prompt = LocalPlayer.PlayerGui.ProximityPrompts.Prompt
                    if Prompt.Frame.TextFrame.ActionText.Text == "Enter Room" then
                        if Prompt.Frame.InputFrame.Frame.CircularProgressBar.Progress.Value == 1 then
                            returnHRP().CFrame = CFrame.new(-5900, -50, 23)
                        end
                    end
                end
            end
        end
    }
)
Tab:CreateToggle(
    {
        Name = "Stage",
        CurrentValue = false,
        Callback = function(Value)
            workspace.GroupAccessPart.CanCollide = not Value
            LocalPlayer.PlayerScripts.GroupAccess.Disabled = Value
        end
    }
)
Tab:CreateToggle(
    {
        Name = "Blacklist Frame",
        CurrentValue = false,
        Callback = function(Value)
            Bypass_BlacklistFrame = Value
            LocalPlayer.PlayerGui.MainGui.BoothCustomisationFrame.BlacklistButton.MouseButton1Click:Connect(
                function()
                    if Bypass_BlacklistFrame then
                        LocalPlayer.PlayerGui.MainGui.BoothBlacklistFrame.Visible = true
                        LocalPlayer.PlayerGui.MainGui["Main Gui Core"].NotificationSound:Stop()
                        LocalPlayer.PlayerGui.MainGui.ChildAdded:Connect(
                            function(child)
                                if Bypass_BlacklistFrame then
                                    child:Destroy()
                                end
                            end
                        )
                    end
                end
            )
        end
    }
)
