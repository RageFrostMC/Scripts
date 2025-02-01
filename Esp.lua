local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

-- Toggle variable
local nameTagsEnabled = false

-- Function to create a name tag
local function createNameTag(character, playerName)
    if not character then return end

    -- Check if nametag already exists
    if character:FindFirstChild("NameTag") then return end

    -- Create BillboardGui
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "NameTag"
    billboard.Size = UDim2.new(6, 0, 1.5, 0)  -- Adjust size of the nametag
    billboard.StudsOffset = Vector3.new(0, 3, 0)  -- Position above player's head
    billboard.Adornee = character:FindFirstChild("Head")
    billboard.AlwaysOnTop = true
    billboard.Parent = character

    -- Create TextLabel
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.TextScaled = true
    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)  -- White text
    textLabel.TextStrokeTransparency = 0  -- Outline
    textLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)  -- Black outline
    textLabel.Font = Enum.Font.GothamBold
    textLabel.Text = playerName  -- Player’s username
    textLabel.Parent = billboard
end

-- Function to remove name tag
local function removeNameTag(character)
    if not character then return end
    local nameTag = character:FindFirstChild("NameTag")
    if nameTag then
        nameTag:Destroy()
    end
end

-- Function to toggle name tags
local function toggleNameTags()
    nameTagsEnabled = not nameTagsEnabled
    for _, player in pairs(Players:GetPlayers()) do
        if player.Character then
            if nameTagsEnabled then
                createNameTag(player.Character, player.Name)
            else
                removeNameTag(player.Character)
            end
        end
    end
end

-- Listen for the F key to toggle name tags
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.F then
        toggleNameTags()
    end
end)

-- Apply name tag when a player spawns
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        if nameTagsEnabled then
            createNameTag(character, player.Name)
        end
    end)
end)

-- Initial name tag application
for _, player in pairs(Players:GetPlayers()) do
    if player.Character and nameTagsEnabled then
        createNameTag(player.Character, player.Name)
    end
end
