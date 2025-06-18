-- SERVICES
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- TRANSISI "Made by Jope"
local introGui = Instance.new("ScreenGui")
introGui.Name = "IntroGui"
introGui.ResetOnSpawn = false
introGui.IgnoreGuiInset = true
introGui.Parent = playerGui

local background = Instance.new("Frame")
background.Size = UDim2.new(1, 0, 1, 0)
background.BackgroundColor3 = Color3.new(0, 0, 0)
background.BackgroundTransparency = 0.5
background.BorderSizePixel = 0
background.Parent = introGui

local label = Instance.new("TextLabel")
label.AnchorPoint = Vector2.new(0.5, 0.5)
label.Position = UDim2.new(0.5, 0, 0.5, 0)
label.Size = UDim2.new(0, 300, 0, 50)
label.Text = "Made by Jope"
label.TextColor3 = Color3.new(1, 1, 1)
label.BackgroundTransparency = 1
label.TextScaled = true
label.Font = Enum.Font.SourceSansSemibold
label.Parent = background

task.wait(3)
introGui:Destroy()

-- GUI UTAMA
local gui = Instance.new("ScreenGui")
gui.Name = "KickTimerGui"
gui.ResetOnSpawn = false
gui.Parent = playerGui

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 350, 0, 260)
mainFrame.Position = UDim2.new(0.5, -175, 0.5, -130)
mainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = gui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "Kick Timer GUI"
title.Font = Enum.Font.SourceSansBold
title.TextSize = 18
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
title.Parent = mainFrame

-- INPUT FIELDS
local function createInput(name, pos)
	local label = Instance.new("TextLabel")
	label.Text = name .. ":"
	label.Size = UDim2.new(0, 60, 0, 30)
	label.Position = pos
	label.TextColor3 = Color3.new(1,1,1)
	label.BackgroundTransparency = 1
	label.Font = Enum.Font.SourceSans
	label.TextSize = 16
	label.Parent = mainFrame

	local box = Instance.new("TextBox")
	box.Size = UDim2.new(0, 60, 0, 30)
	box.Position = pos + UDim2.new(0, 65, 0, 0)
	box.PlaceholderText = "0"
	box.Text = ""
	box.Name = name
	box.TextSize = 16
	box.TextColor3 = Color3.new(1, 1, 1)
	box.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
	box.ClearTextOnFocus = false
	box.Parent = mainFrame

	return box
end

local hourBox = createInput("Jam", UDim2.new(0, 20, 0, 40))
local minBox = createInput("Menit", UDim2.new(0, 20, 0, 80))
local secBox = createInput("Detik", UDim2.new(0, 20, 0, 120))

-- COUNTDOWN LABEL
local countdownLabel = Instance.new("TextLabel", mainFrame)
countdownLabel.Size = UDim2.new(0, 200, 0, 30)
countdownLabel.Position = UDim2.new(0, 140, 0, 160)
countdownLabel.Text = "Countdown: 00:00:00"
countdownLabel.TextSize = 16
countdownLabel.TextColor3 = Color3.new(1, 1, 1)
countdownLabel.BackgroundTransparency = 1
countdownLabel.Font = Enum.Font.SourceSans

-- STATE
local running, paused = false, false
local remainingTime = 0
local timerConnection

-- FORMAT FUNCTION
local function formatTime(t)
	local h = math.floor(t / 3600)
	local m = math.floor((t % 3600) / 60)
	local s = math.floor(t % 60)
	return string.format("%02d:%02d:%02d", h, m, s)
end

-- UPDATE COUNTDOWN DISPLAY
local function updateCountdown()
	countdownLabel.Text = "Countdown: " .. formatTime(remainingTime)
end

-- START TIMER
local function startTimer()
	if timerConnection then timerConnection:Disconnect() end
	timerConnection = RunService.RenderStepped:Connect(function()
		if running and not paused then
			if remainingTime > 0 then
				remainingTime -= 1 / 60
				updateCountdown()
			else
				player:Kick("Waktu habis!")
				timerConnection:Disconnect()
			end
		end
	end)
end

-- BUTTONS
local runButton = Instance.new("TextButton", mainFrame)
runButton.Size = UDim2.new(0.5, -5, 0, 30)
runButton.Position = UDim2.new(0, 0, 1, -30)
runButton.Text = "Run"
runButton.TextSize = 16
runButton.TextColor3 = Color3.new(1, 1, 1)
runButton.BackgroundColor3 = Color3.fromRGB(0, 170, 0)

local terminatedButton = Instance.new("TextButton", mainFrame)
terminatedButton.Size = UDim2.new(0.5, -5, 0, 30)
terminatedButton.Position = UDim2.new(0.5, 5, 1, -30)
terminatedButton.Text = "Terminated"
terminatedButton.TextSize = 16
terminatedButton.TextColor3 = Color3.new(1, 1, 1)
terminatedButton.BackgroundColor3 = Color3.fromRGB(170, 0, 0)

-- RESET & RESUME BUTTONS (dijadikan satu baris)
local resetButton = Instance.new("TextButton", mainFrame)
resetButton.Size = UDim2.new(0.5, -5, 0, 30)
resetButton.Position = UDim2.new(0, 140, 0, 200)
resetButton.Text = "Reset"
resetButton.Visible = false
resetButton.TextSize = 16
resetButton.TextColor3 = Color3.new(1, 1, 1)
resetButton.BackgroundColor3 = Color3.fromRGB(255, 140, 0)

local resumeButton = Instance.new("TextButton", mainFrame)
resumeButton.Size = UDim2.new(0.5, -5, 0, 30)
resumeButton.Position = UDim2.new(0.5, 145, 0, 200)
resumeButton.Text = "Resume"
resumeButton.Visible = false
resumeButton.TextSize = 16
resumeButton.TextColor3 = Color3.new(1, 1, 1)
resumeButton.BackgroundColor3 = Color3.fromRGB(0, 140, 255)

-- BUTTON LOGIC
runButton.MouseButton1Click:Connect(function()
	if not running then
		local jam = tonumber(hourBox.Text) or 0
		local menit = math.clamp(tonumber(minBox.Text) or 0, 0, 60)
		local detik = math.clamp(tonumber(secBox.Text) or 0, 0, 60)

		remainingTime = jam * 3600 + menit * 60 + detik
		if remainingTime <= 0 then return end

		running = true
		paused = false
		runButton.Text = "Pause"
		updateCountdown()
		startTimer()
	else
		paused = true
		running = true
		runButton.Visible = false
		resetButton.Visible = true
		resumeButton.Visible = true
	end
end)

resumeButton.MouseButton1Click:Connect(function()
	paused = false
	runButton.Visible = true
	runButton.Text = "Pause"
	resetButton.Visible = false
	resumeButton.Visible = false
end)

resetButton.MouseButton1Click:Connect(function()
	paused = false
	running = false
	remainingTime = 0
	updateCountdown()
	runButton.Visible = true
	runButton.Text = "Run"
	resetButton.Visible = false
	resumeButton.Visible = false
end)

terminatedButton.MouseButton1Click:Connect(function()
	if timerConnection then
		timerConnection:Disconnect()
	end
	gui:Destroy()
end)
