--[[
    M4teoHub Library
    Original Roblox UI Library
    Fixed Rounded Corners Edition

    Loader:
    local Library = loadstring(game:HttpGet(
        "https://raw.githubusercontent.com/gutierrezmateo8701-debug/Library/main/Script.lua"
    ))()
]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer

local Library = {}
Library.__index = Library

--//======================================================
--// SETTINGS
--//======================================================

Library.Settings = {
    AnimationSpeed = 0.18,
    ClickSounds = true,
    MobileButton = true,
    Notifications = true,
}

Library.Version = "1.0.4"

--//======================================================
--// GUI PARENT
--//======================================================

local function getGuiParent()
    local ok, hui = pcall(function()
        return gethui()
    end)

    if ok and hui then
        return hui
    end

    local ok2, core = pcall(function()
        return game:GetService("CoreGui")
    end)

    if ok2 and core then
        return core
    end

    return LocalPlayer:WaitForChild("PlayerGui")
end

--//======================================================
--// UTILS
--//======================================================

local function new(className, properties)
    local object = Instance.new(className)

    for property, value in pairs(properties or {}) do
        pcall(function()
            object[property] = value
        end)
    end

    return object
end

local function corner(parent, radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, radius or 8)
    c.Parent = parent
    return c
end

local function stroke(parent, color, thickness, transparency)
    local s = Instance.new("UIStroke")

    s.Color = color or Color3.new(1, 1, 1)
    s.Thickness = thickness or 1
    s.Transparency = transparency or 0

    s.Parent = parent

    return s
end

local function tween(object, duration, properties)
    local info = TweenInfo.new(
        duration or Library.Settings.AnimationSpeed,
        Enum.EasingStyle.Quint,
        Enum.EasingDirection.Out
    )

    local t = TweenService:Create(object, info, properties)
    t:Play()

    return t
end

local function callback(fn, ...)
    if typeof(fn) == "function" then
        task.spawn(fn, ...)
    end
end

local function clamp(value, min, max)
    return math.clamp(value, min, max)
end

--//======================================================
--// THEMES
--//======================================================

Library.Themes = {

    Dark = {
        Background = Color3.fromRGB(18, 15, 25),
        Sidebar = Color3.fromRGB(25, 20, 35),
        Element = Color3.fromRGB(35, 27, 47),
        ElementHover = Color3.fromRGB(45, 34, 60),
        Header = Color3.fromRGB(105, 102, 112),
        Text = Color3.fromRGB(240, 240, 245),
        SubText = Color3.fromRGB(165, 160, 175),
        Accent = Color3.fromRGB(150, 55, 255),
        Stroke = Color3.fromRGB(65, 48, 85),
    },

    Light = {
        Background = Color3.fromRGB(238, 238, 242),
        Sidebar = Color3.fromRGB(225, 225, 232),
        Element = Color3.fromRGB(250, 250, 255),
        ElementHover = Color3.fromRGB(235, 235, 242),
        Header = Color3.fromRGB(210, 210, 218),
        Text = Color3.fromRGB(35, 35, 40),
        SubText = Color3.fromRGB(100, 100, 110),
        Accent = Color3.fromRGB(90, 80, 210),
        Stroke = Color3.fromRGB(190, 190, 200),
    },

    Ocean = {
        Background = Color3.fromRGB(9, 20, 30),
        Sidebar = Color3.fromRGB(12, 29, 42),
        Element = Color3.fromRGB(17, 40, 56),
        ElementHover = Color3.fromRGB(22, 52, 70),
        Header = Color3.fromRGB(30, 75, 95),
        Text = Color3.fromRGB(235, 250, 255),
        SubText = Color3.fromRGB(145, 190, 205),
        Accent = Color3.fromRGB(0, 190, 255),
        Stroke = Color3.fromRGB(25, 90, 110),
    },

    Purple = {
        Background = Color3.fromRGB(22, 13, 35),
        Sidebar = Color3.fromRGB(31, 18, 48),
        Element = Color3.fromRGB(43, 25, 65),
        ElementHover = Color3.fromRGB(56, 32, 83),
        Header = Color3.fromRGB(75, 47, 100),
        Text = Color3.fromRGB(245, 240, 255),
        SubText = Color3.fromRGB(180, 160, 200),
        Accent = Color3.fromRGB(170, 70, 255),
        Stroke = Color3.fromRGB(85, 50, 120),
    },

    Red = {
        Background = Color3.fromRGB(30, 12, 15),
        Sidebar = Color3.fromRGB(43, 16, 20),
        Element = Color3.fromRGB(58, 22, 27),
        ElementHover = Color3.fromRGB(75, 27, 33),
        Header = Color3.fromRGB(100, 40, 45),
        Text = Color3.fromRGB(255, 240, 240),
        SubText = Color3.fromRGB(200, 155, 160),
        Accent = Color3.fromRGB(255, 60, 75),
        Stroke = Color3.fromRGB(120, 45, 50),
    },

    Green = {
        Background = Color3.fromRGB(10, 25, 17),
        Sidebar = Color3.fromRGB(15, 36, 24),
        Element = Color3.fromRGB(21, 50, 32),
        ElementHover = Color3.fromRGB(28, 65, 41),
        Header = Color3.fromRGB(40, 90, 55),
        Text = Color3.fromRGB(235, 255, 240),
        SubText = Color3.fromRGB(155, 195, 165),
        Accent = Color3.fromRGB(60, 220, 110),
        Stroke = Color3.fromRGB(45, 105, 60),
    },

    Midnight = {
        Background = Color3.fromRGB(15, 10, 25),
        Sidebar = Color3.fromRGB(25, 16, 38),
        Element = Color3.fromRGB(34, 21, 50),
        ElementHover = Color3.fromRGB(45, 27, 65),
        Header = Color3.fromRGB(125, 122, 135),
        Text = Color3.fromRGB(245, 240, 255),
        SubText = Color3.fromRGB(170, 160, 185),
        Accent = Color3.fromRGB(175, 60, 255),
        Stroke = Color3.fromRGB(65, 40, 90),
    },

    Crimson = {
        Background = Color3.fromRGB(25, 8, 12),
        Sidebar = Color3.fromRGB(38, 11, 17),
        Element = Color3.fromRGB(53, 15, 22),
        ElementHover = Color3.fromRGB(70, 20, 29),
        Header = Color3.fromRGB(110, 30, 40),
        Text = Color3.fromRGB(255, 240, 242),
        SubText = Color3.fromRGB(195, 145, 150),
        Accent = Color3.fromRGB(225, 35, 65),
        Stroke = Color3.fromRGB(115, 35, 45),
    },

    Rose = {
        Background = Color3.fromRGB(30, 13, 22),
        Sidebar = Color3.fromRGB(45, 17, 32),
        Element = Color3.fromRGB(62, 23, 44),
        ElementHover = Color3.fromRGB(80, 29, 55),
        Header = Color3.fromRGB(120, 55, 80),
        Text = Color3.fromRGB(255, 240, 247),
        SubText = Color3.fromRGB(205, 155, 175),
        Accent = Color3.fromRGB(255, 80, 150),
        Stroke = Color3.fromRGB(125, 50, 80),
    },

    Sunset = {
        Background = Color3.fromRGB(32, 17, 10),
        Sidebar = Color3.fromRGB(48, 24, 13),
        Element = Color3.fromRGB(65, 32, 17),
        ElementHover = Color3.fromRGB(85, 41, 20),
        Header = Color3.fromRGB(120, 62, 30),
        Text = Color3.fromRGB(255, 244, 230),
        SubText = Color3.fromRGB(210, 170, 135),
        Accent = Color3.fromRGB(255, 120, 45),
        Stroke = Color3.fromRGB(130, 65, 30),
    },

    Amber = {
        Background = Color3.fromRGB(30, 23, 8),
        Sidebar = Color3.fromRGB(44, 34, 11),
        Element = Color3.fromRGB(60, 46, 14),
        ElementHover = Color3.fromRGB(78, 59, 17),
        Header = Color3.fromRGB(110, 85, 25),
        Text = Color3.fromRGB(255, 250, 225),
        SubText = Color3.fromRGB(205, 185, 130),
        Accent = Color3.fromRGB(255, 185, 45),
        Stroke = Color3.fromRGB(125, 95, 30),
    },

    Cyan = {
        Background = Color3.fromRGB(7, 25, 28),
        Sidebar = Color3.fromRGB(10, 38, 42),
        Element = Color3.fromRGB(14, 52, 56),
        ElementHover = Color3.fromRGB(19, 67, 72),
        Header = Color3.fromRGB(30, 100, 105),
        Text = Color3.fromRGB(230, 255, 255),
        SubText = Color3.fromRGB(140, 195, 200),
        Accent = Color3.fromRGB(30, 230, 240),
        Stroke = Color3.fromRGB(35, 110, 115),
    },

    Azure = {
        Background = Color3.fromRGB(8, 17, 32),
        Sidebar = Color3.fromRGB(11, 26, 47),
        Element = Color3.fromRGB(16, 37, 65),
        ElementHover = Color3.fromRGB(21, 48, 83),
        Header = Color3.fromRGB(35, 70, 120),
        Text = Color3.fromRGB(235, 245, 255),
        SubText = Color3.fromRGB(145, 175, 210),
        Accent = Color3.fromRGB(50, 145, 255),
        Stroke = Color3.fromRGB(40, 85, 135),
    },

    Violet = {
        Background = Color3.fromRGB(19, 9, 32),
        Sidebar = Color3.fromRGB(29, 14, 47),
        Element = Color3.fromRGB(43, 20, 69),
        ElementHover = Color3.fromRGB(57, 26, 90),
        Header = Color3.fromRGB(80, 45, 125),
        Text = Color3.fromRGB(245, 238, 255),
        SubText = Color3.fromRGB(175, 155, 205),
        Accent = Color3.fromRGB(135, 65, 255),
        Stroke = Color3.fromRGB(85, 45, 125),
    },

    Monochrome = {
        Background = Color3.fromRGB(15, 15, 15),
        Sidebar = Color3.fromRGB(25, 25, 25),
        Element = Color3.fromRGB(35, 35, 35),
        ElementHover = Color3.fromRGB(48, 48, 48),
        Header = Color3.fromRGB(75, 75, 75),
        Text = Color3.fromRGB(245, 245, 245),
        SubText = Color3.fromRGB(160, 160, 160),
        Accent = Color3.fromRGB(220, 220, 220),
        Stroke = Color3.fromRGB(70, 70, 70),
    }
}

Library.Theme = Library.Themes.Midnight
Library.CurrentTheme = "Midnight"

--//======================================================
--// CLICK SOUND
--//======================================================

local ClickSoundId = "rbxassetid://6895079853"

function Library:_click()
    if not self.Settings.ClickSounds then
        return
    end

    pcall(function()
        local sound = Instance.new("Sound")
        sound.SoundId = ClickSoundId
        sound.Volume = 0.35
        sound.Parent = getGuiParent()

        sound:Play()

        task.delay(1, function()
            pcall(function()
                sound:Destroy()
            end)
        end)
    end)
end

--//======================================================
--// THEME
--//======================================================

function Library:SetTheme(themeName)
    if not self.Themes[themeName] then
        return false
    end

    self.Theme = self.Themes[themeName]
    self.CurrentTheme = themeName

    if self._RefreshTheme then
        pcall(self._RefreshTheme)
    end

    return true
end

--//======================================================
--// RGB BORDER
--//======================================================

function Library:SetRGBBorders(enabled)
    self.RGBBorders = enabled == true

    if self._RGBConnection then
        self._RGBConnection:Disconnect()
        self._RGBConnection = nil
    end

    if not self.RGBBorders then
        for _, s in ipairs(self._RGBStrokes or {}) do
            if s and s.Parent then
                s.Color = self.Theme.Accent
            end
        end

        return
    end

    local hue = 0

    self._RGBConnection = RunService.RenderStepped:Connect(function(dt)
        if not self.MainGui or not self.MainGui.Parent then
            return
        end

        hue = (hue + dt * 0.15) % 1

        local color = Color3.fromHSV(hue, 0.85, 1)

        for _, s in ipairs(self._RGBStrokes or {}) do
            if s and s.Parent then
                s.Color = color
            end
        end
    end)
end

--//======================================================
--// NOTIFY
--//======================================================

function Library:Notify(data)
    if not self.Settings.Notifications then
        return
    end

    if type(data) == "string" then
        data = {
            Title = "Notification",
            Content = data,
            Duration = 3
        }
    end

    data = data or {}

    local title = data.Title or "Notification"
    local content = data.Content or ""
    local duration = data.Duration or 3

    if not self.NotificationHolder then
        return
    end

    local notification = new("Frame", {
        Size = UDim2.new(1, 0, 0, 75),
        BackgroundColor3 = self.Theme.Element,
        BorderSizePixel = 0,
        BackgroundTransparency = 0,
    })

    corner(notification, 10)
    stroke(notification, self.Theme.Stroke, 1, 0.35)

    notification.Parent = self.NotificationHolder

    local titleLabel = new("TextLabel", {
        Size = UDim2.new(1, -20, 0, 25),
        Position = UDim2.fromOffset(10, 8),
        BackgroundTransparency = 1,
        Text = tostring(title),
        TextColor3 = self.Theme.Text,
        Font = Enum.Font.GothamBold,
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left,
    })

    titleLabel.Parent = notification

    local contentLabel = new("TextLabel", {
        Size = UDim2.new(1, -20, 0, 30),
        Position = UDim2.fromOffset(10, 34),
        BackgroundTransparency = 1,
        Text = tostring(content),
        TextColor3 = self.Theme.SubText,
        Font = Enum.Font.Gotham,
        TextSize = 12,
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Top,
    })

    contentLabel.Parent = notification

    notification.Position = UDim2.new(1, 20, 0, 0)

    tween(notification, 0.25, {
        Position = UDim2.new(0, 0, 0, 0)
    })

    task.delay(duration, function()
        if notification and notification.Parent then
            tween(notification, 0.2, {
                Position = UDim2.new(1, 20, 0, 0)
            })

            task.wait(0.22)

            pcall(function()
                notification:Destroy()
            end)
        end
    end)
end

--//======================================================
--// VISIBILITY
--//======================================================

function Library:SetVisibility(visible)
    self.Visible = visible == true

    if self.WindowFrame then
        if self.Visible then
            self.WindowFrame.Visible = true
            tween(self.WindowFrame, 0.2, {
                BackgroundTransparency = 0
            })
        else
            tween(self.WindowFrame, 0.2, {
                BackgroundTransparency = 1
            })

            task.delay(0.22, function()
                if not self.Visible and self.WindowFrame then
                    self.WindowFrame.Visible = false
                end
            end)
        end
    end
end

--//======================================================
--// DESTROY
--//======================================================

function Library:Destroy()
    if self._RGBConnection then
        self._RGBConnection:Disconnect()
        self._RGBConnection = nil
    end

    if self._InputConnections then
        for _, connection in ipairs(self._InputConnections) do
            pcall(function()
                connection:Disconnect()
            end)
        end
    end

    if self.MainGui then
        pcall(function()
            self.MainGui:Destroy()
        end)
    end

    self.MainGui = nil
end

--//======================================================
--// CREATE WINDOW
--//======================================================

function Library:CreateWindow(config)
    config = config or {}

    local lib = self

    local requestedSize = config.Size

    if typeof(requestedSize) ~= "UDim2" then
        requestedSize = UDim2.fromOffset(460, 340)
    end

    lib.Theme = lib.Themes[config.Theme or "Midnight"] or lib.Themes.Midnight
    lib.CurrentTheme = config.Theme or "Midnight"

    lib.RGBBorders = config.RGBBorders == true

    --// Clean previous GUI
    pcall(function()
        local parent = getGuiParent()

        local old = parent:FindFirstChild("M4teoHub")
        if old then
            old:Destroy()
        end
    end)

    --//==================================================
    --// MAIN GUI
    --//==================================================

    local gui = new("ScreenGui", {
        Name = "M4teoHub",
        ResetOnSpawn = false,
        IgnoreGuiInset = true,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    })

    gui.Parent = getGuiParent()

    lib.MainGui = gui

    --//==================================================
    --// WINDOW
    --//==================================================

    local window = new("Frame", {
        Name = "Window",
        Size = requestedSize,
        Position = UDim2.fromScale(0.5, 0.5),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = lib.Theme.Background,
        BorderSizePixel = 0,

        -- IMPORTANT FIX:
        -- This clips all children to the rounded window.
        ClipsDescendants = true,
    })

    window.Parent = gui

    lib.WindowFrame = window
    lib.Visible = true

    -- Main rounded corners
    corner(window, 14)

    local windowStroke = stroke(
        window,
        lib.Theme.Stroke,
        1,
        0.15
    )

    lib._RGBStrokes = {
        windowStroke
    }

    --//==================================================
    --// HEADER
    --//==================================================

    local header = new("Frame", {
        Name = "Header",
        Size = UDim2.new(1, 0, 0, 86),
        BackgroundColor3 = lib.Theme.Header,
        BorderSizePixel = 0,
        ClipsDescendants = true,
    })

    header.Parent = window

    -- Header itself gets rounded corners, but the
    -- window ClipsDescendants prevents overflow.
    corner(header, 14)

    -- Bottom cover keeps header bottom square
    -- while the outer window controls the actual corners.
    local headerBottom = new("Frame", {
        Size = UDim2.new(1, 0, 0, 20),
        Position = UDim2.new(0, 0, 1, -20),
        BackgroundColor3 = lib.Theme.Header,
        BorderSizePixel = 0,
    })

    headerBottom.Parent = header

    local title = new("TextLabel", {
        Size = UDim2.new(1, -130, 0, 28),
        Position = UDim2.fromOffset(28, 18),
        BackgroundTransparency = 1,
        Text = config.Name or "M4teoHub",
        TextColor3 = lib.Theme.Text,
        Font = Enum.Font.GothamBold,
        TextSize = 19,
        TextXAlignment = Enum.TextXAlignment.Left,
    })

    title.Parent = header

    local subtitle = new("TextLabel", {
        Size = UDim2.new(1, -130, 0, 20),
        Position = UDim2.fromOffset(28, 47),
        BackgroundTransparency = 1,
        Text = config.LoadingSubtitle or "Library",
        TextColor3 = lib.Theme.SubText,
        Font = Enum.Font.Gotham,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
    })

    subtitle.Parent = header

    --// Minimize
    local minimize = new("TextButton", {
        Size = UDim2.fromOffset(50, 50),
        Position = UDim2.new(1, -115, 0, 16),
        BackgroundColor3 = lib.Theme.Element,
        BorderSizePixel = 0,
        Text = "−",
        TextColor3 = lib.Theme.Text,
        Font = Enum.Font.GothamBold,
        TextSize = 22,
        AutoButtonColor = false,
    })

    minimize.Parent = header
    corner(minimize, 11)

    --// Close
    local close = new("TextButton", {
        Size = UDim2.fromOffset(50, 50),
        Position = UDim2.new(1, -60, 0, 16),
        BackgroundColor3 = lib.Theme.Element,
        BorderSizePixel = 0,
        Text = "×",
        TextColor3 = lib.Theme.Text,
        Font = Enum.Font.GothamBold,
        TextSize = 20,
        AutoButtonColor = false,
    })

    close.Parent = header
    corner(close, 11)

    --//==================================================
    --// BODY
    --//==================================================

    local body = new("Frame", {
        Name = "Body",
        Size = UDim2.new(1, 0, 1, -86),
        Position = UDim2.fromOffset(0, 86),
        BackgroundColor3 = lib.Theme.Background,
        BorderSizePixel = 0,

        -- Important for rounded-window clipping.
        ClipsDescendants = true,
    })

    body.Parent = window

    --//==================================================
    --// SIDEBAR
    --//==================================================

    local sidebar = new("Frame", {
        Name = "Sidebar",
        Size = UDim2.new(0, 225, 1, 0),
        BackgroundColor3 = lib.Theme.Sidebar,
        BorderSizePixel = 0,
        ClipsDescendants = true,
    })

    sidebar.Parent = body

    -- Keep sidebar visually rectangular inside the window.
    -- Outer corners are handled by Window.
    corner(sidebar, 0)

    local sidebarLayout = new("UIListLayout", {
        Padding = UDim.new(0, 6),
        SortOrder = Enum.SortOrder.LayoutOrder,
    })

    sidebarLayout.Parent = sidebar

    local sidebarPadding = new("UIPadding", {
        PaddingTop = UDim.new(0, 22),
        PaddingLeft = UDim.new(0, 10),
        PaddingRight = UDim.new(0, 10),
    })

    sidebarPadding.Parent = sidebar

    --//==================================================
    --// CONTENT
    --//==================================================

    local content = new("Frame", {
        Name = "Content",
        Size = UDim2.new(1, -225, 1, 0),
        Position = UDim2.new(0, 225, 0, 0),
        BackgroundColor3 = lib.Theme.Background,
        BorderSizePixel = 0,
        ClipsDescendants = true,
    })

    content.Parent = body

    local contentPadding = new("UIPadding", {
        PaddingTop = UDim.new(0, 20),
        PaddingBottom = UDim.new(0, 14),
        PaddingLeft = UDim.new(0, 16),
        PaddingRight = UDim.new(0, 16),
    })

    contentPadding.Parent = content

    --//==================================================
    --// NOTIFICATIONS
    --//==================================================

    local notificationHolder = new("Frame", {
        Size = UDim2.fromOffset(280, 400),
        Position = UDim2.new(1, -300, 0, 20),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
    })

    notificationHolder.Parent = gui

    local notificationLayout = new("UIListLayout", {
        Padding = UDim.new(0, 8),
        SortOrder = Enum.SortOrder.LayoutOrder,
        VerticalAlignment = Enum.VerticalAlignment.Top,
    })

    notificationLayout.Parent = notificationHolder

    lib.NotificationHolder = notificationHolder

    --//==================================================
    --// TAB DATA
    --//==================================================

    local tabs = {}
    local currentTab = nil

    local function selectTab(tab)
        if currentTab == tab then
            return
        end

        currentTab = tab

        for _, data in ipairs(tabs) do
            local selected = data == tab

            tween(data.Button, 0.16, {
                BackgroundColor3 = selected
                    and lib.Theme.ElementHover
                    or lib.Theme.Sidebar
            })

            tween(data.ButtonStroke, 0.16, {
                Transparency = selected and 0 or 1
            })

            data.Page.Visible = selected

            if selected then
                data.Page.Position = UDim2.fromOffset(12, 0)

                tween(data.Page, 0.2, {
                    Position = UDim2.fromOffset(0, 0)
                })
            end
        end
    end

    --//==================================================
    --// TAB CREATOR
    --//==================================================

    function lib.WindowObject_CreateTab(windowObject, tabConfig)
        if type(tabConfig) == "string" then
            tabConfig = {
                Name = tabConfig
            }
        else
            tabConfig = tabConfig or {}
        end

        local tabName = tabConfig.Name or "Tab"

        local tabButton = new("TextButton", {
            Size = UDim2.new(1, 0, 0, 48),
            BackgroundColor3 = lib.Theme.Sidebar,
            BorderSizePixel = 0,
            Text = "",
            AutoButtonColor = false,
            LayoutOrder = #tabs + 1,
        })

        tabButton.Parent = sidebar
        corner(tabButton, 10)

        local tabText = new("TextLabel", {
            Size = UDim2.new(1, -20, 1, 0),
            Position = UDim2.fromOffset(10, 0),
            BackgroundTransparency = 1,
            Text = tabName,
            TextColor3 = lib.Theme.Text,
            Font = Enum.Font.Gotham,
            TextSize = 13,
            TextXAlignment = Enum.TextXAlignment.Left,
        })

        tabText.Parent = tabButton

        local tabStroke = stroke(
            tabButton,
            lib.Theme.Accent,
            1,
            1
        )

        local page = new("ScrollingFrame", {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            ScrollBarThickness = 3,
            ScrollBarImageColor3 = lib.Theme.Accent,
            CanvasSize = UDim2.new(0, 0, 0, 0),
            AutomaticCanvasSize = Enum.AutomaticSize.Y,
            ScrollingDirection = Enum.ScrollingDirection.Y,
            Visible = false,
        })

        page.Parent = content

        local pagePadding = new("UIPadding", {
            PaddingBottom = UDim.new(0, 10),
        })

        pagePadding.Parent = page

        local pageLayout = new("UIListLayout", {
            Padding = UDim.new(0, 10),
            SortOrder = Enum.SortOrder.LayoutOrder,
        })

        pageLayout.Parent = page

        local tab = {
            Name = tabName,
            Button = tabButton,
            ButtonStroke = tabStroke,
            Page = page,
            Layout = pageLayout,
        }

        table.insert(tabs, tab)

        tabButton.MouseButton1Click:Connect(function()
            lib:_click()
            selectTab(tab)
        end)

        --//==============================================
        --// SECTION
        --//==============================================

        function tab:CreateSection(text)
            local section = new("TextLabel", {
                Size = UDim2.new(1, 0, 0, 28),
                BackgroundTransparency = 1,
                Text = tostring(text or "Section"),
                TextColor3 = lib.Theme.Accent,
                Font = Enum.Font.GothamBold,
                TextSize = 15,
                TextXAlignment = Enum.TextXAlignment.Left,
            })

            section.Parent = page

            return section
        end

        --//==============================================
        --// LABEL
        --//==============================================

        function tab:CreateLabel(text)
            local label = new("TextLabel", {
                Size = UDim2.new(1, 0, 0, 30),
                BackgroundTransparency = 1,
                Text = tostring(text or ""),
                TextColor3 = lib.Theme.Text,
                Font = Enum.Font.Gotham,
                TextSize = 13,
                TextXAlignment = Enum.TextXAlignment.Left,
            })

            label.Parent = page

            return label
        end

        --//==============================================
        --// PARAGRAPH
        --//==============================================

        function tab:CreateParagraph(data)
            data = data or {}

            local frame = new("Frame", {
                Size = UDim2.new(1, 0, 0, 70),
                BackgroundColor3 = lib.Theme.Element,
                BorderSizePixel = 0,
            })

            frame.Parent = page
            corner(frame, 10)

            local titleLabel = new("TextLabel", {
                Size = UDim2.new(1, -20, 0, 22),
                Position = UDim2.fromOffset(10, 8),
                BackgroundTransparency = 1,
                Text = tostring(data.Title or "Paragraph"),
                TextColor3 = lib.Theme.Text,
                Font = Enum.Font.GothamBold,
                TextSize = 13,
                TextXAlignment = Enum.TextXAlignment.Left,
            })

            titleLabel.Parent = frame

            local contentLabel = new("TextLabel", {
                Size = UDim2.new(1, -20, 0, 35),
                Position = UDim2.fromOffset(10, 30),
                BackgroundTransparency = 1,
                Text = tostring(data.Content or ""),
                TextColor3 = lib.Theme.SubText,
                Font = Enum.Font.Gotham,
                TextSize = 12,
                TextWrapped = true,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextYAlignment = Enum.TextYAlignment.Top,
            })

            contentLabel.Parent = frame

            return frame
        end

        --//==============================================
        --// DIVIDER
        --//==============================================

        function tab:CreateDivider()
            local divider = new("Frame", {
                Size = UDim2.new(1, 0, 0, 1),
                BackgroundColor3 = lib.Theme.Stroke,
                BorderSizePixel = 0,
            })

            divider.Parent = page

            return divider
        end

        --//==============================================
        --// BUTTON
        --//==============================================

        function tab:CreateButton(data)
            if type(data) == "string" then
                data = {
                    Name = data
                }
            end

            data = data or {}

            local button = new("TextButton", {
                Size = UDim2.new(1, 0, 0, 52),
                BackgroundColor3 = lib.Theme.Element,
                BorderSizePixel = 0,
                Text = tostring(data.Name or "Button"),
                TextColor3 = lib.Theme.Text,
                Font = Enum.Font.Gotham,
                TextSize = 13,
                AutoButtonColor = false,
            })

            button.Parent = page
            corner(button, 10)

            local bs = stroke(
                button,
                lib.Theme.Stroke,
                1,
                0.5
            )

            button.MouseEnter:Connect(function()
                tween(button, 0.12, {
                    BackgroundColor3 = lib.Theme.ElementHover
                })
            end)

            button.MouseLeave:Connect(function()
                tween(button, 0.12, {
                    BackgroundColor3 = lib.Theme.Element
                })
            end)

            button.MouseButton1Click:Connect(function()
                lib:_click()
                callback(data.Callback)
            end)

            return {
                Instance = button
            }
        end

        --//==============================================
        --// TOGGLE
        --//==============================================

        function tab:CreateToggle(data)
            data = data or {}

            local current = data.Current == true

            local holder = new("Frame", {
                Size = UDim2.new(1, 0, 0, 52),
                BackgroundColor3 = lib.Theme.Element,
                BorderSizePixel = 0,
            })

            holder.Parent = page
            corner(holder, 10)

            local label = new("TextLabel", {
                Size = UDim2.new(1, -80, 1, 0),
                Position = UDim2.fromOffset(14, 0),
                BackgroundTransparency = 1,
                Text = tostring(data.Name or "Toggle"),
                TextColor3 = lib.Theme.Text,
                Font = Enum.Font.Gotham,
                TextSize = 13,
                TextXAlignment = Enum.TextXAlignment.Left,
            })

            label.Parent = holder

            local toggle = new("TextButton", {
                Size = UDim2.fromOffset(48, 26),
                Position = UDim2.new(1, -60, 0.5, -13),
                BackgroundColor3 = current
                    and lib.Theme.Accent
                    or lib.Theme.Stroke,
                BorderSizePixel = 0,
                Text = "",
                AutoButtonColor = false,
            })

            toggle.Parent = holder
            corner(toggle, 13)

            local knob = new("Frame", {
                Size = UDim2.fromOffset(20, 20),
                Position = current
                    and UDim2.new(1, -23, 0.5, -10)
                    or UDim2.new(0, 3, 0.5, -10),
                BackgroundColor3 = Color3.new(1, 1, 1),
                BorderSizePixel = 0,
            })

            knob.Parent = toggle
            corner(knob, 10)

            local function refresh()
                tween(toggle, 0.15, {
                    BackgroundColor3 = current
                        and lib.Theme.Accent
                        or lib.Theme.Stroke
                })

                tween(knob, 0.15, {
                    Position = current
                        and UDim2.new(1, -23, 0.5, -10)
                        or UDim2.new(0, 3, 0.5, -10)
                })
            end

            toggle.MouseButton1Click:Connect(function()
                current = not current
                lib:_click()
                refresh()
                callback(data.Callback, current)
            end)

            return {
                Set = function(_, value)
                    current = value == true
                    refresh()
                    callback(data.Callback, current)
                end,

                Get = function()
                    return current
                end,

                Refresh = refresh
            }
        end

        --//==============================================
        --// SLIDER
        --//==============================================

        function tab:CreateSlider(data)
            data = data or {}

            local min = tonumber(data.Range and data.Range[1]) or 0
            local max = tonumber(data.Range and data.Range[2]) or 100
            local current = tonumber(data.CurrentValue) or min

            current = clamp(current, min, max)

            local holder = new("Frame", {
                Size = UDim2.new(1, 0, 0, 70),
                BackgroundColor3 = lib.Theme.Element,
                BorderSizePixel = 0,
            })

            holder.Parent = page
            corner(holder, 10)

            local label = new("TextLabel", {
                Size = UDim2.new(1, -30, 0, 25),
                Position = UDim2.fromOffset(14, 7),
                BackgroundTransparency = 1,
                Text = tostring(data.Name or "Slider"),
                TextColor3 = lib.Theme.Text,
                Font = Enum.Font.Gotham,
                TextSize = 13,
                TextXAlignment = Enum.TextXAlignment.Left,
            })

            label.Parent = holder

            local valueLabel = new("TextLabel", {
                Size = UDim2.fromOffset(70, 25),
                Position = UDim2.new(1, -85, 0, 7),
                BackgroundTransparency = 1,
                Text = tostring(current),
                TextColor3 = lib.Theme.SubText,
                Font = Enum.Font.Gotham,
                TextSize = 12,
                TextXAlignment = Enum.TextXAlignment.Right,
            })

            valueLabel.Parent = holder

            local bar = new("Frame", {
                Size = UDim2.new(1, -28, 0, 6),
                Position = UDim2.fromOffset(14, 48),
                BackgroundColor3 = lib.Theme.Stroke,
                BorderSizePixel = 0,
            })

            bar.Parent = holder
            corner(bar, 3)

            local fill = new("Frame", {
                Size = UDim2.new(
                    (current - min) / math.max(max - min, 1),
                    0,
                    1,
                    0
                ),
                BackgroundColor3 = lib.Theme.Accent,
                BorderSizePixel = 0,
            })

            fill.Parent = bar
            corner(fill, 3)

            local dragging = false

            local function setFromX(x)
                local percent = clamp(
                    (x - bar.AbsolutePosition.X) /
                    math.max(bar.AbsoluteSize.X, 1),
                    0,
                    1
                )

                current = min + (max - min) * percent

                if data.Increment then
                    current =
                        math.floor(
                            current / data.Increment + 0.5
                        ) * data.Increment
                end

                current = clamp(current, min, max)

                local normalized =
                    (current - min) /
                    math.max(max - min, 1)

                fill.Size = UDim2.new(
                    normalized,
                    0,
                    1,
                    0
                )

                valueLabel.Text = tostring(current)

                callback(data.Callback, current)
            end

            bar.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1
                    or input.UserInputType == Enum.UserInputType.Touch then

                    dragging = true
                    setFromX(input.Position.X)
                    lib:_click()
                end
            end)

            UserInputService.InputChanged:Connect(function(input)
                if not dragging then
                    return
                end

                if input.UserInputType == Enum.UserInputType.MouseMovement
                    or input.UserInputType == Enum.UserInputType.Touch then

                    setFromX(input.Position.X)
                end
            end)

            UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1
                    or input.UserInputType == Enum.UserInputType.Touch then

                    dragging = false
                end
            end)

            return {
                Set = function(_, value)
                    current = clamp(
                        tonumber(value) or current,
                        min,
                        max
                    )

                    local normalized =
                        (current - min) /
                        math.max(max - min, 1)

                    tween(fill, 0.15, {
                        Size = UDim2.new(
                            normalized,
                            0,
                            1,
                            0
                        )
                    })

                    valueLabel.Text = tostring(current)

                    callback(data.Callback, current)
                end,

                Get = function()
                    return current
                end
            }
        end

        --//==============================================
        --// DROPDOWN
        --//==============================================

        function tab:CreateDropdown(data)
            data = data or {}

            local options = data.Options or {}
            local current = data.CurrentOption

            if current == nil then
                current = options[1]
            end

            local opened = false

            local holder = new("Frame", {
                Size = UDim2.new(1, 0, 0, 38),
                BackgroundColor3 = lib.Theme.Element,
                BorderSizePixel = 0,
                ClipsDescendants = true,
            })

            holder.Parent = page
            corner(holder, 10)

            local top = new("TextButton", {
                Size = UDim2.new(1, 0, 0, 38),
                BackgroundTransparency = 1,
                Text = "",
                AutoButtonColor = false,
            })

            top.Parent = holder

            local nameLabel = new("TextLabel", {
                Size = UDim2.new(0.45, 0, 1, 0),
                Position = UDim2.fromOffset(14, 0),
                BackgroundTransparency = 1,
                Text = tostring(data.Name or "Dropdown"),
                TextColor3 = lib.Theme.Text,
                Font = Enum.Font.Gotham,
                TextSize = 13,
                TextXAlignment = Enum.TextXAlignment.Left,
            })

            nameLabel.Parent = top

            local selectedLabel = new("TextLabel", {
                Size = UDim2.new(0.55, -30, 1, 0),
                Position = UDim2.new(0.45, 0, 0, 0),
                BackgroundTransparency = 1,
                Text = tostring(current or ""),
                TextColor3 = lib.Theme.SubText,
                Font = Enum.Font.Gotham,
                TextSize = 12,
                TextXAlignment = Enum.TextXAlignment.Right,
            })

            selectedLabel.Parent = top

            -- REAL SCROLLING FRAME
            local list = new("ScrollingFrame", {
                Size = UDim2.new(1, -8, 0, 0),
                Position = UDim2.fromOffset(4, 38),
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                ScrollBarThickness = 3,
                ScrollBarImageColor3 = lib.Theme.Accent,
                CanvasSize = UDim2.new(0, 0, 0, 0),
                AutomaticCanvasSize = Enum.AutomaticSize.Y,
                ScrollingDirection = Enum.ScrollingDirection.Y,
                ClipsDescendants = true,
            })

            list.Parent = holder

            local listLayout = new("UIListLayout", {
                Padding = UDim.new(0, 4),
                SortOrder = Enum.SortOrder.LayoutOrder,
            })

            listLayout.Parent = list

            local listPadding = new("UIPadding", {
                PaddingTop = UDim.new(0, 4),
                PaddingBottom = UDim.new(0, 4),
            })

            listPadding.Parent = list

            local optionButtons = {}

            local function refreshHeight()
                local height = opened
                    and math.clamp(#options * 31 + 6, 0, 155)
                    or 0

                tween(holder, 0.18, {
                    Size = UDim2.new(
                        1,
                        0,
                        0,
                        38 + height
                    )
                })

                tween(list, 0.18, {
                    Size = UDim2.new(
                        1,
                        -8,
                        0,
                        height
                    )
                })
            end

            for index, option in ipairs(options) do
                local optionButton = new("TextButton", {
                    Size = UDim2.new(1, -6, 0, 27),
                    BackgroundColor3 = lib.Theme.ElementHover,
                    BorderSizePixel = 0,
                    Text = tostring(option),
                    TextColor3 = lib.Theme.Text,
                    Font = Enum.Font.Gotham,
                    TextSize = 12,
                    AutoButtonColor = false,
                    LayoutOrder = index,
                })

                optionButton.Parent = list
                corner(optionButton, 7)

                optionButton.MouseButton1Click:Connect(function()
                    current = option
                    selectedLabel.Text = tostring(option)

                    lib:_click()

                    callback(data.Callback, option)

                    opened = false
                    refreshHeight()
                end)

                table.insert(optionButtons, optionButton)
            end

            top.MouseButton1Click:Connect(function()
                lib:_click()

                opened = not opened
                refreshHeight()
            end)

            return {
                Set = function(_, value)
                    current = value
                    selectedLabel.Text = tostring(value)
                    callback(data.Callback, value)
                end,

                Get = function()
                    return current
                end,

                Refresh = function(_, newOptions)
                    options = newOptions or {}
                end
            }
        end

        --//==============================================
        --// MULTI DROPDOWN
        --//==============================================

        function tab:CreateMultiDropdown(data)
            data = data or {}

            local options = data.Options or {}
            local selected = {}

            for _, value in ipairs(data.CurrentOptions or {}) do
                selected[value] = true
            end

            local opened = false

            local holder = new("Frame", {
                Size = UDim2.new(1, 0, 0, 38),
                BackgroundColor3 = lib.Theme.Element,
                BorderSizePixel = 0,
                ClipsDescendants = true,
            })

            holder.Parent = page
            corner(holder, 10)

            local top = new("TextButton", {
                Size = UDim2.new(1, 0, 0, 38),
                BackgroundTransparency = 1,
                Text = "",
                AutoButtonColor = false,
            })

            top.Parent = holder

            local nameLabel = new("TextLabel", {
                Size = UDim2.new(0.45, 0, 1, 0),
                Position = UDim2.fromOffset(14, 0),
                BackgroundTransparency = 1,
                Text = tostring(data.Name or "Multi Dropdown"),
                TextColor3 = lib.Theme.Text,
                Font = Enum.Font.Gotham,
                TextSize = 13,
                TextXAlignment = Enum.TextXAlignment.Left,
            })

            nameLabel.Parent = top

            local selectedLabel = new("TextLabel", {
                Size = UDim2.new(0.55, -30, 1, 0),
                Position = UDim2.new(0.45, 0, 0, 0),
                BackgroundTransparency = 1,
                Text = "Ninguno",
                TextColor3 = lib.Theme.SubText,
                Font = Enum.Font.Gotham,
                TextSize = 12,
                TextXAlignment = Enum.TextXAlignment.Right,
                TextTruncate = Enum.TextTruncate.AtEnd,
            })

            selectedLabel.Parent = top

            local list = new("ScrollingFrame", {
                Size = UDim2.new(1, -8, 0, 0),
                Position = UDim2.fromOffset(4, 38),
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                ScrollBarThickness = 3,
                ScrollBarImageColor3 = lib.Theme.Accent,
                CanvasSize = UDim2.new(0, 0, 0, 0),
                AutomaticCanvasSize = Enum.AutomaticSize.Y,
                ScrollingDirection = Enum.ScrollingDirection.Y,
                ClipsDescendants = true,
            })

            list.Parent = holder

            local layout = new("UIListLayout", {
                Padding = UDim.new(0, 4),
                SortOrder = Enum.SortOrder.LayoutOrder,
            })

            layout.Parent = list

            local padding = new("UIPadding", {
                PaddingTop = UDim.new(0, 4),
                PaddingBottom = UDim.new(0, 4),
            })

            padding.Parent = list

            local function updateText()
                local values = {}

                for _, option in ipairs(options) do
                    if selected[option] then
                        table.insert(values, tostring(option))
                    end
                end

                if #values == 0 then
                    selectedLabel.Text = "Ninguno"
                else
                    selectedLabel.Text = table.concat(values, ", ")
                end
            end

            local function updateHeight()
                local height = opened
                    and math.clamp(#options * 31 + 6, 0, 155)
                    or 0

                tween(holder, 0.18, {
                    Size = UDim2.new(
                        1,
                        0,
                        0,
                        38 + height
                    )
                })

                tween(list, 0.18, {
                    Size = UDim2.new(
                        1,
                        -8,
                        0,
                        height
                    )
                })
            end

            for index, option in ipairs(options) do
                local optionButton = new("TextButton", {
                    Size = UDim2.new(1, -6, 0, 27),
                    BackgroundColor3 = lib.Theme.ElementHover,
                    BorderSizePixel = 0,
                    Text = tostring(option),
                    TextColor3 = lib.Theme.Text,
                    Font = Enum.Font.Gotham,
                    TextSize = 12,
                    AutoButtonColor = false,
                    LayoutOrder = index,
                })

                optionButton.Parent = list
                corner(optionButton, 7)

                optionButton.MouseButton1Click:Connect(function()
                    selected[option] = not selected[option]

                    lib:_click()

                    updateText()

                    local result = {}

                    for _, item in ipairs(options) do
                        if selected[item] then
                            table.insert(result, item)
                        end
                    end

                    callback(data.Callback, result)
                end)
            end

            top.MouseButton1Click:Connect(function()
                lib:_click()

                opened = not opened
                updateHeight()
            end)

            updateText()

            return {
                Get = function()
                    local result = {}

                    for _, option in ipairs(options) do
                        if selected[option] then
                            table.insert(result, option)
                        end
                    end

                    return result
                end,

                Set = function(_, values)
                    selected = {}

                    for _, value in ipairs(values or {}) do
                        selected[value] = true
                    end

                    updateText()
                    callback(data.Callback, values)
                end
            }
        end

        --//==============================================
        --// INPUT
        --//==============================================

        function tab:CreateInput(data)
            data = data or {}

            local holder = new("Frame", {
                Size = UDim2.new(1, 0, 0, 60),
                BackgroundColor3 = lib.Theme.Element,
                BorderSizePixel = 0,
            })

            holder.Parent = page
            corner(holder, 10)

            local label = new("TextLabel", {
                Size = UDim2.new(1, -20, 0, 20),
                Position = UDim2.fromOffset(12, 6),
                BackgroundTransparency = 1,
                Text = tostring(data.Name or "Input"),
                TextColor3 = lib.Theme.Text,
                Font = Enum.Font.Gotham,
                TextSize = 12,
                TextXAlignment = Enum.TextXAlignment.Left,
            })

            label.Parent = holder

            local box = new("TextBox", {
                Size = UDim2.new(1, -24, 0, 27),
                Position = UDim2.fromOffset(12, 29),
                BackgroundColor3 = lib.Theme.ElementHover,
                BorderSizePixel = 0,
                PlaceholderText = tostring(data.PlaceholderText or ""),
                Text = tostring(data.CurrentValue or ""),
                TextColor3 = lib.Theme.Text,
                PlaceholderColor3 = lib.Theme.SubText,
                Font = Enum.Font.Gotham,
                TextSize = 12,
                ClearTextOnFocus = false,
            })

            box.Parent = holder
            corner(box, 7)

            box.FocusLost:Connect(function()
                callback(data.Callback, box.Text)
            end)

            return {
                Set = function(_, value)
                    box.Text = tostring(value)
                    callback(data.Callback, box.Text)
                end,

                Get = function()
                    return box.Text
                end
            }
        end

        --//==============================================
        --// KEYBIND
        --//==============================================

        function tab:CreateKeybind(data)
            data = data or {}

            local currentKey = data.CurrentKeybind or Enum.KeyCode.RightShift

            local holder = new("Frame", {
                Size = UDim2.new(1, 0, 0, 52),
                BackgroundColor3 = lib.Theme.Element,
                BorderSizePixel = 0,
            })

            holder.Parent = page
            corner(holder, 10)

            local label = new("TextLabel", {
                Size = UDim2.new(1, -100, 1, 0),
                Position = UDim2.fromOffset(14, 0),
                BackgroundTransparency = 1,
                Text = tostring(data.Name or "Keybind"),
                TextColor3 = lib.Theme.Text,
                Font = Enum.Font.Gotham,
                TextSize = 13,
                TextXAlignment = Enum.TextXAlignment.Left,
            })

            label.Parent = holder

            local keyButton = new("TextButton", {
                Size = UDim2.fromOffset(75, 30),
                Position = UDim2.new(1, -87, 0.5, -15),
                BackgroundColor3 = lib.Theme.ElementHover,
                BorderSizePixel = 0,
                Text = currentKey.Name,
                TextColor3 = lib.Theme.Text,
                Font = Enum.Font.GothamBold,
                TextSize = 11,
                AutoButtonColor = false,
            })

            keyButton.Parent = holder
            corner(keyButton, 7)

            local listening = false

            keyButton.MouseButton1Click:Connect(function()
                listening = true
                keyButton.Text = "..."
                lib:_click()
            end)

            local connection

            connection = UserInputService.InputBegan:Connect(function(input, processed)
                if listening and input.UserInputType == Enum.UserInputType.Keyboard then
                    currentKey = input.KeyCode
                    listening = false
                    keyButton.Text = currentKey.Name

                    callback(data.Callback, currentKey)
                    return
                end

                if processed then
                    return
                end

                if input.KeyCode == currentKey then
                    callback(data.Callback, currentKey)
                end
            end)

            return {
                Set = function(_, key)
                    currentKey = key
                    keyButton.Text = currentKey.Name
                end,

                Get = function()
                    return currentKey
                end,

                Destroy = function()
                    pcall(function()
                        connection:Disconnect()
                    end)

                    holder:Destroy()
                end
            }
        end

        --//==============================================
        --// COLOR PICKER
        --//==============================================

        function tab:CreateColorPicker(data)
            data = data or {}

            local currentColor =
                data.Color
                or Color3.fromRGB(255, 255, 255)

            local holder = new("Frame", {
                Size = UDim2.new(1, 0, 0, 70),
                BackgroundColor3 = lib.Theme.Element,
                BorderSizePixel = 0,
            })

            holder.Parent = page
            corner(holder, 10)

            local label = new("TextLabel", {
                Size = UDim2.new(1, -100, 0, 25),
                Position = UDim2.fromOffset(14, 10),
                BackgroundTransparency = 1,
                Text = tostring(data.Name or "Color"),
                TextColor3 = lib.Theme.Text,
                Font = Enum.Font.Gotham,
                TextSize = 13,
                TextXAlignment = Enum.TextXAlignment.Left,
            })

            label.Parent = holder

            local preview = new("Frame", {
                Size = UDim2.fromOffset(42, 42),
                Position = UDim2.new(1, -57, 0.5, -21),
                BackgroundColor3 = currentColor,
                BorderSizePixel = 0,
            })

            preview.Parent = holder
            corner(preview, 10)

            local input = new("TextBox", {
                Size = UDim2.new(1, -25, 0, 25),
                Position = UDim2.fromOffset(12, 39),
                BackgroundColor3 = lib.Theme.ElementHover,
                BorderSizePixel = 0,
                Text = string.format(
                    "%d,%d,%d",
                    math.floor(currentColor.R * 255),
                    math.floor(currentColor.G * 255),
                    math.floor(currentColor.B * 255)
                ),
                TextColor3 = lib.Theme.Text,
                Font = Enum.Font.Gotham,
                TextSize = 11,
                ClearTextOnFocus = false,
            })

            input.Parent = holder
            corner(input, 7)

            input.FocusLost:Connect(function()
                local r, g, b =
                    input.Text:match("(%d+)%s*,%s*(%d+)%s*,%s*(%d+)")

                if r and g and b then
                    currentColor = Color3.fromRGB(
                        clamp(tonumber(r), 0, 255),
                        clamp(tonumber(g), 0, 255),
                        clamp(tonumber(b), 0, 255)
                    )

                    preview.BackgroundColor3 = currentColor

                    callback(
                        data.Callback,
                        currentColor
                    )
                end
            end)

            return {
                Set = function(_, color)
                    if typeof(color) ~= "Color3" then
                        return
                    end

                    currentColor = color
                    preview.BackgroundColor3 = color

                    input.Text = string.format(
                        "%d,%d,%d",
                        math.floor(color.R * 255),
                        math.floor(color.G * 255),
                        math.floor(color.B * 255)
                    )

                    callback(data.Callback, color)
                end,

                Get = function()
                    return currentColor
                end
            }
        end

        return tab
    end

    -- Public CreateTab
    function windowObject:CreateTab(tabConfig)
        return lib.WindowObject_CreateTab(self, tabConfig)
    end

    -- Compatibility alias
    function lib:CreateTab(tabConfig)
        return lib.WindowObject_CreateTab(lib, tabConfig)
    end

    --//==================================================
    --// WINDOW CONTROLS
    --//==================================================

    local minimized = false

    minimize.MouseButton1Click:Connect(function()
        lib:_click()

        minimized = not minimized

        if minimized then
            tween(window, 0.2, {
                Size = UDim2.fromOffset(
                    requestedSize.X.Offset,
                    86
                )
            })
        else
            tween(window, 0.2, {
                Size = requestedSize
            })
        end
    end)

    close.MouseButton1Click:Connect(function()
        lib:_click()
        lib:Destroy()
    end)

    --//==================================================
    --// DRAGGING
    --//==================================================

    local dragging = false
    local dragStart
    local startPosition

    header.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then

            dragging = true
            dragStart = input.Position
            startPosition = window.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if not dragging then
            return
        end

        if input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch then

            local delta = input.Position - dragStart

            window.Position = UDim2.new(
                startPosition.X.Scale,
                startPosition.X.Offset + delta.X,
                startPosition.Y.Scale,
                startPosition.Y.Offset + delta.Y
            )
        end
    end)

    --//==================================================
    --// MOBILE BUTTON
    --//==================================================

    if lib.Settings.MobileButton then
        local mobileButton = new("TextButton", {
            Name = "MobileButton",
            Size = UDim2.fromOffset(82, 82),
            Position = UDim2.new(0, 82, 0.5, -40),
            BackgroundColor3 = lib.Theme.Element,
            BorderSizePixel = 0,
            Text = "M",
            TextColor3 = lib.Theme.Text,
            Font = Enum.Font.GothamBold,
            TextSize = 22,
            AutoButtonColor = false,
        })

        mobileButton.Parent = gui
        corner(mobileButton, 16)

        mobileButton.MouseButton1Click:Connect(function()
            lib:_click()

            if window.Visible then
                lib:SetVisibility(false)
            else
                lib:SetVisibility(true)
            end
        end)

        lib.MobileButton = mobileButton
    end

    --//==================================================
    --// THEME REFRESH
    --//==================================================

    function lib._RefreshTheme()
        local t = lib.Theme

        window.BackgroundColor3 = t.Background
        body.BackgroundColor3 = t.Background
        sidebar.BackgroundColor3 = t.Sidebar
        content.BackgroundColor3 = t.Background

        header.BackgroundColor3 = t.Header
        headerBottom.BackgroundColor3 = t.Header

        title.TextColor3 = t.Text
        subtitle.TextColor3 = t.SubText

        minimize.BackgroundColor3 = t.Element
        close.BackgroundColor3 = t.Element

        windowStroke.Color = t.Stroke

        if lib.MobileButton then
            lib.MobileButton.BackgroundColor3 = t.Element
            lib.MobileButton.TextColor3 = t.Text
        end

        for _, tab in ipairs(tabs) do
            tab.Button.BackgroundColor3 =
                tab == currentTab
                and t.ElementHover
                or t.Sidebar

            tab.ButtonStroke.Color = t.Accent

            for _, object in ipairs(tab.Page:GetChildren()) do
                if object:IsA("TextLabel")
                    or object:IsA("TextButton")
                    or object:IsA("TextBox") then

                    if object:IsA("TextLabel")
                        or object:IsA("TextButton") then

                        if object.TextColor3 ~= Color3.new(1, 1, 1) then
                            object.TextColor3 = t.Text
                        end
                    end
                end
            end
        end
    end

    --====================================================
    -- RGB
    --====================================================

    if lib.RGBBorders then
        lib:SetRGBBorders(true)
    end

    --====================================================
    -- INITIAL TAB
    --====================================================

    if #tabs > 0 then
        selectTab(tabs[1])
    end

    --====================================================
    -- PUBLIC WINDOW OBJECT
    --====================================================

    local windowObject = {}

    function windowObject:CreateTab(tabConfig)
        return lib.WindowObject_CreateTab(self, tabConfig)
    end

    function windowObject:SetTheme(theme)
        lib:SetTheme(theme)
    end

    function windowObject:Destroy()
        lib:Destroy()
    end

    function windowObject:SetVisibility(value)
        lib:SetVisibility(value)
    end

    lib.Window = windowObject

    return windowObject
end

return Library
