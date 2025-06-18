-- Lokasi: LocalScript di StarterGui

-- SERVICES
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- GUI TRANSISI "Made by Jope"
local introGui = Instance.new("ScreenGui")
introGui.Name = "IntroGui"
introGui.ResetOnSpawn = false
introGui.IgnoreGuiInset = true
introGui.Parent = playerGui

local background = Instance.new("Frame")
background.Size = UDim2.new(1, 0, 1, 0)
background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
background.BackgroundTransparency = 1
background.BorderSizePixel = 0
background.Parent = introGui

local label = Instance.new("TextLabel")
label.AnchorPoint = Vector2.new(0.5, 0.5)
label.Position = UDim2.new(0.5, 0, 0.5, 0)
label.Size = UDim2.new(0, 300, 0, 50)
label.Text = "Made by Jope"
label.TextColor3 = Color3.new(1, 1, 1)
label.TextTransparency = 1
label.BackgroundTransparency = 1
label.TextScaled = true
label.Font = Enum.Font.SourceSansSemibold
label.Parent = background

-- Fade-in Tween
local fadeInBackground = TweenService:Create(background, TweenInfo.new(1), {BackgroundTransparency = 0.5})
local fadeInLabel = TweenService:Create(label, TweenInfo.new(1), {TextTransparency = 0})

-- Fade-out Tween
local fadeOutBackground = TweenService:Create(background, TweenInfo.new(1), {BackgroundTransparency = 1})
local fadeOutLabel = TweenService:Create(label, TweenInfo.new(1), {TextTransparency = 1})

fadeInBackground:Play()
fadeInLabel:Play()
fadeInLabel.Completed:Wait()

task.wait(3)

fadeOutBackground:Play()
fadeOutLabel:Play()
fadeOutLabel.Completed:Wait()

introGui:Destroy()

-- ========== KICK TIMER GUI MULAI DI SINI ==========

local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "KickTimerGui"
gui.ResetOnSpawn = false

-- Main Frame
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 300, 0, 250)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -125)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = gui
mainFrame.Active = true
mainFrame.Draggable = true

-- Header
local header = Instance.new("TextLabel")
header.Size = UDim2.new(1, -40, 0, 30)
header.Position = UDim2.new(0, 10, 0, 5)
header.Text = "⏳ Kick Timer"
header.Font = Enum.Font.SourceSansSemibold
header.TextSize = 22
header.TextColor3 = Color3.new(1, 1, 1)
header.BackgroundTransparency = 1
header.TextXAlignment = Enum.TextXAlignment.Left
header.Parent = mainFrame

-- Minimize Button
local minimize = Instance.new("TextButton")
minimize.Text = "-"
minimize.Size = UDim2.new(0, 30, 0, 30)
minimize.Position = UDim2.new(1, -35, 0, 5)
minimize.Font = Enum.Font.SourceSansBold
minimize.TextSize = 22
minimize.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
minimize.TextColor3 = Color3.new(1, 1, 1)
minimize.Parent = mainFrame

-- Input Fields
local inputs = {}
local labels = {"Jam", "Menit", "Detik"}

for i, label in ipairs(labels) do
	local box = Instance.new("TextBox")
	box.PlaceholderText = label
	box.Text = ""
	box.Size = UDim2.new(0.3, -5, 0, 35)
	box.Position = UDim2.new((i - 1) * 0.33 + 0.025, 0, 0, 45)
	box.Font = Enum.Font.SourceSans
	box.TextSize = 20
	box.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
	box.TextColor3 = Color3.new(1, 1, 1)
	box.Parent = mainFrame
	inputs[label] = box
end

-- Countdown Label
local countdownLabel = Instance.new("TextLabel")
countdownLabel.Size = UDim2.new(1, -20, 0, 30)
countdownLabel.Position = UDim2.new(0, 10, 0, 90)
countdownLabel.Text = "Countdown: 00:00:00"
countdownLabel.Font = Enum.Font.SourceSans
countdownLabel.TextSize = 20
countdownLabel.TextColor3 = Color3.new(1, 1, 1)
countdownLabel.BackgroundTransparency = 1
countdownLabel.Parent = mainFrame

-- Buttons
local runButton = Instance.new("TextButton")
runButton.Size = UDim2.new(1, -20, 0, 40)
runButton.Position = UDim2.new(0, 10, 0, 130)
runButton.Text = "Run"
runButton.Font = Enum.Font.SourceSansBold
runButton.TextSize = 22
runButton.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
runButton.TextColor3 = Color3.new(1, 1, 1)
runButton.Parent = mainFrame

local terminated = Instance.new("TextButton")
terminated.Size = UDim2.new(1, -20, 0, 40)
terminated.Position = UDim2.new(0, 10, 0, 180)
terminated.Text = "Terminated"
terminated.Font = Enum.Font.SourceSansBold
terminated.TextSize = 22
terminated.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
terminated.TextColor3 = Color3.new(1, 1, 1)
terminated.Parent = mainFrame

local resumeButton = Instance.new("TextButton")
resumeButton.Size = UDim2.new(0.5, -15, 0, 40)
resumeButton.Position = UDim2.new(0, 10, 0, 130)
resumeButton.Text = "Pause"
resumeButton.Font = Enum.Font.SourceSansBold
resumeButton.TextSize = 22
resumeButton.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
resumeButton.TextColor3 = Color3.new(1, 1, 1)
resumeButton.Visible = false
resumeButton.Parent = mainFrame

local resetButton = Instance.new("TextButton")
resetButton.Size = UDim2.new(0.5, -15, 0, 40)
resetButton.Position = UDim2.new(0.5, 5, 0, 130)
resetButton.Text = "Reset"
resetButton.Font = Enum.Font.SourceSansBold
resetButton.TextSize = 22
resetButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
resetButton.TextColor3 = Color3.new(1, 1, 1)
resetButton.Visible = false
resetButton.Parent = mainFrame

-- Restore Icon
local restoreIcon = Instance.new("TextButton")
restoreIcon.Size = UDim2.new(0, 100, 0, 30)
restoreIcon.Position = UDim2.new(0, 10, 0, 10)
restoreIcon.Text = "⏳ Kick Timer"
restoreIcon.Visible = false
restoreIcon.Parent = gui
restoreIcon.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
restoreIcon.TextColor3 = Color3.new(1, 1, 1)
restoreIcon.Active = true
restoreIcon.Draggable = true

-- Minimize/Restore
minimize.MouseButton1Click:Connect(function()
	mainFrame.Visible = false
	restoreIcon.Visible = true
end)
restoreIcon.MouseButton1Click:Connect(function()
	mainFrame.Visible = true
	restoreIcon.Visible = false
end)

-- Timer logic
local running = false
local paused = false
local countdown = 0
local timerConn

local function formatTime(seconds)
	local h = math.floor(seconds / 3600)
	local m = math.floor((seconds % 3600) / 60)
	local s = seconds % 60
	return string.format("%02d:%02d:%02d", h, m, s)
end

local function startTimer()
	if timerConn then timerConn:Disconnect() end
	timerConn = game:GetService("RunService").RenderStepped:Connect(function(dt)
		if running and not paused then
			countdown -= dt
			if countdown <= 0 then
				player:Kick("Waktu habis!")
				running = false
				timerConn:Disconnect()
			else
				countdownLabel.Text = "Countdown: " .. formatTime(math.floor(countdown))
			end
		end
	end)
end

-- Run
runButton.MouseButton1Click:Connect(function()
	local h = tonumber(inputs["Jam"].Text) or 0
	local m = tonumber(inputs["Menit"].Text) or 0
	local s = tonumber(inputs["Detik"].Text) or 0

	if m > 60 then m = 60 inputs["Menit"].Text = "60" end
	if s > 60 then s = 60 inputs["Detik"].Text = "60" end

	countdown = h * 3600 + m * 60 + s
	if countdown <= 0 then
		countdownLabel.Text = "Masukkan waktu valid!"
		return
	end

	running = true
	paused = false
	startTimer()
	countdownLabel.Text = "Countdown: " .. formatTime(math.floor(countdown))

	runButton.Visible = false
	resumeButton.Visible = true
	resetButton.Visible = true
end)

-- Resume / Pause
resumeButton.MouseButton1Click:Connect(function()
	if paused then
		paused = false
		resumeButton.Text = "Pause"
	else
		paused = true
		resumeButton.Text = "Resume"
	end
end)

-- Reset
resetButton.MouseButton1Click:Connect(function()
	running = false
	paused = false
	countdown = 0
	countdownLabel.Text = "Countdown: 00:00:00"
	resumeButton.Text = "Pause"
	runButton.Visible = true
	resumeButton.Visible = false
	resetButton.Visible = false
end)

-- Terminate
terminated.MouseButton1Click:Connect(function()
	if timerConn then timerConn:Disconnect() end
	running = false
	gui:Destroy()
end)
