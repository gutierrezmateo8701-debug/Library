--[[
    M4teoHub Library
    Script.lua
    Original UI Library
    Client-side Roblox Lua
]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer

local Library = {}

Library.Flags = {}
Library.Elements = {}
Library.Windows = {}

Library.Settings = {
    AnimationSpeed = 0.18,
    ClickSounds = true,
    MobileButton = true,
    Notifications = true
}

Library.Themes = {

    Dark = {
        Background = Color3.fromRGB(20, 20, 24),
        Secondary = Color3.fromRGB(27, 27, 32),
        Element = Color3.fromRGB(32, 32, 38),
        Hover = Color3.fromRGB(40, 40, 48),
        Text = Color3.fromRGB(240, 240, 245),
        SubText = Color3.fromRGB(165, 165, 175),
        Accent = Color3.fromRGB(90, 120, 255),
        Border = Color3.fromRGB(55, 55, 65)
    },

    Light = {
        Background = Color3.fromRGB(240, 240, 245),
        Secondary = Color3.fromRGB(225, 225, 232),
        Element = Color3.fromRGB(232, 232, 238),
        Hover = Color3.fromRGB(215, 215, 225),
        Text = Color3.fromRGB(30, 30, 35),
        SubText = Color3.fromRGB(90, 90, 100),
        Accent = Color3.fromRGB(70, 100, 220),
        Border = Color3.fromRGB(190, 190, 200)
    },

    Ocean = {
        Background = Color3.fromRGB(12, 24, 34),
        Secondary = Color3.fromRGB(17, 36, 50),
        Element = Color3.fromRGB(20, 45, 62),
        Hover = Color3.fromRGB(27, 58, 78),
        Text = Color3.fromRGB(225, 245, 255),
        SubText = Color3.fromRGB(145, 190, 205),
        Accent = Color3.fromRGB(40, 180, 220),
        Border = Color3.fromRGB(35, 90, 110)
    },

    Purple = {
        Background = Color3.fromRGB(23, 16, 32),
        Secondary = Color3.fromRGB(34, 24, 47),
        Element = Color3.fromRGB(43, 30, 58),
        Hover = Color3.fromRGB(55, 39, 73),
        Text = Color3.fromRGB(245, 235, 255),
        SubText = Color3.fromRGB(180, 155, 200),
        Accent = Color3.fromRGB(170, 90, 255),
        Border = Color3.fromRGB(90, 55, 120)
    },

    Red = {
        Background = Color3.fromRGB(30, 15, 17),
        Secondary = Color3.fromRGB(43, 20, 23),
        Element = Color3.fromRGB(55, 25, 28),
        Hover = Color3.fromRGB(72, 32, 36),
        Text = Color3.fromRGB(255, 240, 240),
        SubText = Color3.fromRGB(205, 155, 160),
        Accent = Color3.fromRGB(240, 65, 75),
        Border = Color3.fromRGB(110, 45, 50)
    },

    Green = {
        Background = Color3.fromRGB(14, 27, 19),
        Secondary = Color3.fromRGB(20, 40, 27),
        Element = Color3.fromRGB(25, 48, 32),
        Hover = Color3.fromRGB(32, 62, 41),
        Text = Color3.fromRGB(235, 255, 240),
        SubText = Color3.fromRGB(150, 195, 160),
        Accent = Color3.fromRGB(65, 210, 110),
        Border = Color3.fromRGB(40, 100, 60)
    },

    Midnight = {
        Background = Color3.fromRGB(10, 12, 20),
        Secondary = Color3.fromRGB(15, 18, 30),
        Element = Color3.fromRGB(20, 24, 38),
        Hover = Color3.fromRGB(28, 34, 52),
        Text = Color3.fromRGB(235, 240, 255),
        SubText = Color3.fromRGB(140, 150, 175),
        Accent = Color3.fromRGB(100, 120, 255),
        Border = Color3.fromRGB(45, 55, 85)
    },

    Crimson = {
        Background = Color3.fromRGB(28, 10, 14),
        Secondary = Color3.fromRGB(40, 13, 19),
        Element = Color3.fromRGB(52, 18, 25),
        Hover = Color3.fromRGB(70, 23, 33),
        Text = Color3.fromRGB(255, 235, 238),
        SubText = Color3.fromRGB(200, 145, 155),
        Accent = Color3.fromRGB(220, 35, 60),
        Border = Color3.fromRGB(100, 30, 42)
    },

    Rose = {
        Background = Color3.fromRGB(30, 15, 23),
        Secondary = Color3.fromRGB(43, 20, 32),
        Element = Color3.fromRGB(56, 27, 42),
        Hover = Color3.fromRGB(72, 34, 53),
        Text = Color3.fromRGB(255, 235, 245),
        SubText = Color3.fromRGB(205, 155, 180),
        Accent = Color3.fromRGB(245, 90, 165),
        Border = Color3.fromRGB(110, 50, 80)
    },

    Sunset = {
        Background = Color3.fromRGB(30, 18, 12),
        Secondary = Color3.fromRGB(44, 25, 15),
        Element = Color3.fromRGB(58, 32, 18),
        Hover = Color3.fromRGB(75, 40, 22),
        Text = Color3.fromRGB(255, 242, 225),
        SubText = Color3.fromRGB(205, 170, 135),
        Accent = Color3.fromRGB(255, 120, 45),
        Border = Color3.fromRGB(115, 65, 35)
    },

    Amber = {
        Background = Color3.fromRGB(30, 25, 12),
        Secondary = Color3.fromRGB(43, 35, 15),
        Element = Color3.fromRGB(57, 46, 18),
        Hover = Color3.fromRGB(73, 58, 22),
        Text = Color3.fromRGB(255, 248, 220),
        SubText = Color3.fromRGB(205, 190, 135),
        Accent = Color3.fromRGB(245, 190, 55),
        Border = Color3.fromRGB(110, 90, 35)
    },

    Cyan = {
        Background = Color3.fromRGB(8, 25, 27),
        Secondary = Color3.fromRGB(12, 39, 42),
        Element = Color3.fromRGB(16, 51, 55),
        Hover = Color3.fromRGB(20, 66, 70),
        Text = Color3.fromRGB(225, 255, 255),
        SubText = Color3.fromRGB(135, 195, 200),
        Accent = Color3.fromRGB(45, 220, 220),
        Border = Color3.fromRGB(30, 100, 105)
    },

    Azure = {
        Background = Color3.fromRGB(10, 18, 30),
        Secondary = Color3.fromRGB(15, 28, 45),
        Element = Color3.fromRGB(20, 37, 58),
        Hover = Color3.fromRGB(27, 48, 75),
        Text = Color3.fromRGB(230, 245, 255),
        SubText = Color3.fromRGB(140, 175, 205),
        Accent = Color3.fromRGB(55, 145, 255),
        Border = Color3.fromRGB(35, 80, 125)
    },

    Violet = {
        Background = Color3.fromRGB(20, 12, 30),
        Secondary = Color3.fromRGB(30, 18, 44),
        Element = Color3.fromRGB(40, 24, 58),
        Hover = Color3.fromRGB(52, 31, 75),
        Text = Color3.fromRGB(245, 235, 255),
        SubText = Color3.fromRGB(175, 145, 205),
        Accent = Color3.fromRGB(145, 75, 255),
        Border = Color3.fromRGB(80, 45, 120)
    },

    Monochrome = {
        Background = Color3.fromRGB(15, 15, 15),
        Secondary = Color3.fromRGB(24, 24, 24),
        Element = Color3.fromRGB(32, 32, 32),
        Hover = Color3.fromRGB(45, 45, 45),
        Text = Color3.fromRGB(245, 245, 245),
        SubText = Color3.fromRGB(165, 165, 165),
        Accent = Color3.fromRGB(210, 210, 210),
        Border = Color3.fromRGB(65, 65, 65)
    }
}

Library.Theme = Library.Themes.Midnight
Library.CurrentTheme = "Midnight"

local function getGuiParent()
    local ok, result = pcall(function()
        if gethui then
            return gethui()
        end
    end)

    if ok and result then
        return result
    end

    return game:GetService("CoreGui")
end

local function new(className, properties)
    local object = Instance.new(className)

    for property, value in pairs(properties or {}) do
        pcall(function()
            object[property] = value
        end)
    end

    return object
end

local function corner(object, radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, radius or 6)
    c.Parent = object
    return c
end

local function stroke(object, color, thickness)
    local s = Instance.new("UIStroke")
    s.Color = color or Color3.new(1,1,1)
    s.Thickness = thickness or 1
    s.Transparency = 0
    s.Parent = object
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
    if type(fn) == "function" then
        return pcall(fn, ...)
    end
end

function Library:_click()
    if not self.Settings.ClickSounds then
        return
    end

    pcall(function()
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://6895079853"
        sound.Volume = 0.35
        sound.Parent = getGuiParent()
        sound:Play()

        task.delay(2, function()
            if sound then
                sound:Destroy()
            end
        end)
    end)
end

function Library:SetTheme(theme)
    if type(theme) ~= "string" then
        return
    end

    local newTheme = self.Themes[theme]

    if not newTheme then
        return
    end

    self.Theme = newTheme
    self.CurrentTheme = theme

    for _, element in ipairs(self.Elements) do
        if element._theme then
            pcall(element._theme, newTheme)
        end
    end

    for _, window in ipairs(self.Windows) do
        if window.RefreshTheme then
            pcall(window.RefreshTheme)
        end
    end
end

function Library:Notify(config)
    if not self.Settings.Notifications then
        return
    end

    config = config or {}

    local title = config.Title or "Notification"
    local content = config.Content or ""
    local duration = config.Duration or 3

    for _, window in ipairs(self.Windows) do
        if window.Notify then
            window:Notify(title, content, duration)
            return
        end
    end
end

function Library:SetVisibility(state)
    for _, window in ipairs(self.Windows) do
        if window.WindowFrame then
            window.WindowFrame.Visible = state
        end
    end
end

function Library:Destroy()
    for _, window in ipairs(self.Windows) do
        if window.Gui then
            pcall(function()
                window.Gui:Destroy()
            end)
        end
    end

    self.Windows = {}
    self.Elements = {}
end

function Library:CreateWindow(config)
    config = config or {}

    local lib = self

    if config.Theme and self.Themes[config.Theme] then
        self.Theme = self.Themes[config.Theme]
        self.CurrentTheme = config.Theme
    end

    local guiName = "M4teoHubLibrary"

    local old = getGuiParent():FindFirstChild(guiName)

    if old then
        pcall(function()
            old:Destroy()
        end)
    end

    local gui = new("ScreenGui", {
        Name = guiName,
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        Parent = getGuiParent()
    })

    local requestedSize = config.Size

    if typeof(requestedSize) ~= "UDim2" then
        requestedSize = UDim2.fromOffset(460, 340)
    end

    local window = new("Frame", {
        Size = requestedSize,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        BackgroundColor3 = self.Theme.Background,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        Parent = gui
    })

    corner(window, 9)

    local windowStroke = stroke(
        window,
        self.Theme.Border,
        1
    )

    local shadow = new("ImageLabel", {
        Size = UDim2.new(1, 30, 1, 30),
        Position = UDim2.fromOffset(-15, -15),
        BackgroundTransparency = 1,
        Image = "rbxassetid://1316045217",
        ImageTransparency = 0.55,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(10,10,118,118),
        ZIndex = 0,
        Parent = window
    })

    local mainContainer = new("Frame", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Parent = window
    })

    local header = new("Frame", {
        Size = UDim2.new(1, 0, 0, 48),
        BackgroundTransparency = 1,
        Parent = mainContainer
    })

    local title = new("TextLabel", {
        Size = UDim2.new(1, -100, 0, 22),
        Position = UDim2.fromOffset(15, 7),
        BackgroundTransparency = 1,
        Text = config.Name or "M4teoHub",
        TextColor3 = self.Theme.Text,
        Font = Enum.Font.GothamBold,
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = header
    })

    local subtitle = new("TextLabel", {
        Size = UDim2.new(1, -100, 0, 16),
        Position = UDim2.fromOffset(15, 27),
        BackgroundTransparency = 1,
        Text = config.LoadingSubtitle or config.Subtitle or "",
        TextColor3 = self.Theme.SubText,
        Font = Enum.Font.Gotham,
        TextSize = 9,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = header
    })

    local minimize = new("TextButton", {
        Size = UDim2.fromOffset(28, 28),
        Position = UDim2.new(1, -64, 0, 10),
        BackgroundColor3 = self.Theme.Secondary,
        Text = "−",
        TextColor3 = self.Theme.SubText,
        Font = Enum.Font.GothamBold,
        TextSize = 15,
        AutoButtonColor = false,
        Parent = header
    })

    corner(minimize, 6)

    local close = new("TextButton", {
        Size = UDim2.fromOffset(28, 28),
        Position = UDim2.new(1, -32, 0, 10),
        BackgroundColor3 = self.Theme.Secondary,
        Text = "×",
        TextColor3 = self.Theme.SubText,
        Font = Enum.Font.GothamBold,
        TextSize = 15,
        AutoButtonColor = false,
        Parent = header
    })

    corner(close, 6)

    local body = new("Frame", {
        Size = UDim2.new(1, 0, 1, -48),
        Position = UDim2.fromOffset(0, 48),
        BackgroundTransparency = 1,
        Parent = mainContainer
    })

    local sidebar = new("Frame", {
        Size = UDim2.new(0, 125, 1, 0),
        BackgroundColor3 = self.Theme.Secondary,
        BorderSizePixel = 0,
        Parent = body
    })

    local sidebarPadding = new("UIPadding", {
        PaddingTop = UDim.new(0, 8),
        PaddingLeft = UDim.new(0, 7),
        PaddingRight = UDim.new(0, 7),
        PaddingBottom = UDim.new(0, 8),
        Parent = sidebar
    })

    local tabList = new("ScrollingFrame", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 2,
        ScrollBarImageColor3 = self.Theme.Accent,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        ScrollingDirection = Enum.ScrollingDirection.Y,
        Parent = sidebar
    })

    local tabLayout = new("UIListLayout", {
        Padding = UDim.new(0, 5),
        SortOrder = Enum.SortOrder.LayoutOrder,
        Parent = tabList
    })

    local content = new("Frame", {
        Size = UDim2.new(1, -125, 1, 0),
        Position = UDim2.fromOffset(125, 0),
        BackgroundColor3 = self.Theme.Background,
        BorderSizePixel = 0,
        Parent = body
    })

    local tabs = {}
    local activeTab = nil

    local windowObject = {
        Gui = gui,
        Window = mainContainer,
        WindowFrame = window,
        Content = content,
        Sidebar = sidebar,
        Tabs = tabs,
        Name = config.Name or "M4teoHub"
    }

    function windowObject:Notify(notifyTitle, notifyContent, duration)
        local notification = new("Frame", {
            Size = UDim2.fromOffset(260, 70),
            Position = UDim2.new(1, 280, 1, -85),
            BackgroundColor3 = lib.Theme.Secondary,
            BorderSizePixel = 0,
            Parent = gui
        })

        corner(notification, 8)
        stroke(notification, lib.Theme.Border)

        local nt = new("TextLabel", {
            Size = UDim2.new(1, -20, 0, 22),
            Position = UDim2.fromOffset(10, 8),
            BackgroundTransparency = 1,
            Text = tostring(notifyTitle),
            TextColor3 = lib.Theme.Text,
            Font = Enum.Font.GothamBold,
            TextSize = 12,
            TextXAlignment = Enum.TextXAlignment.Left,
            Parent = notification
        })

        local nc = new("TextLabel", {
            Size = UDim2.new(1, -20, 0, 30),
            Position = UDim2.fromOffset(10, 31),
            BackgroundTransparency = 1,
            Text = tostring(notifyContent),
            TextColor3 = lib.Theme.SubText,
            Font = Enum.Font.Gotham,
            TextSize = 10,
            TextWrapped = true,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Top,
            Parent = notification
        })

        tween(notification, 0.25, {
            Position = UDim2.new(1, -270, 1, -85)
        })

        task.delay(duration or 3, function()
            if notification and notification.Parent then
                tween(notification, 0.25, {
                    Position = UDim2.new(1, 280, 1, -85)
                })

                task.wait(0.3)

                if notification then
                    notification:Destroy()
                end
            end
        end)
    end

    function windowObject:RefreshTheme()
        window.BackgroundColor3 = lib.Theme.Background
        windowStroke.Color = lib.Theme.Border

        sidebar.BackgroundColor3 = lib.Theme.Secondary
        content.BackgroundColor3 = lib.Theme.Background

        title.TextColor3 = lib.Theme.Text
        subtitle.TextColor3 = lib.Theme.SubText

        minimize.BackgroundColor3 = lib.Theme.Secondary
        minimize.TextColor3 = lib.Theme.SubText

        close.BackgroundColor3 = lib.Theme.Secondary
        close.TextColor3 = lib.Theme.SubText

        tabList.ScrollBarImageColor3 = lib.Theme.Accent
    end

    function windowObject:CreateTab(tabConfig)

        -- FIX:
        -- Supports both:
        -- Window:CreateTab("Main")
        -- Window:CreateTab({Name = "Main"})
        if type(tabConfig) == "string" then
            tabConfig = {
                Name = tabConfig
            }
        else
            tabConfig = tabConfig or {}
        end

        local Tab = {
            Name = tabConfig.Name or "Tab",
            Elements = {},
            Page = nil,
            Button = nil
        }

        local button = new("TextButton", {
            Size = UDim2.new(1, -4, 0, 34),
            BackgroundColor3 = lib.Theme.Secondary,
            Text = "  " .. tostring(Tab.Name),
            TextColor3 = lib.Theme.SubText,
            Font = Enum.Font.GothamMedium,
            TextSize = 10,
            TextXAlignment = Enum.TextXAlignment.Left,
            AutoButtonColor = false,
            Parent = tabList
        })

        corner(button, 6)

        local page = new("ScrollingFrame", {
            Size = UDim2.new(1, -14, 1, -14),
            Position = UDim2.fromOffset(7, 7),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            ScrollBarThickness = 3,
            ScrollBarImageColor3 = lib.Theme.Accent,
            CanvasSize = UDim2.new(0, 0, 0, 0),
            AutomaticCanvasSize = Enum.AutomaticSize.Y,
            ScrollingDirection = Enum.ScrollingDirection.Y,
            Visible = false,
            Parent = content
        })

        local pageLayout = new("UIListLayout", {
            Padding = UDim.new(0, 7),
            SortOrder = Enum.SortOrder.LayoutOrder,
            Parent = page
        })

        local pagePadding = new("UIPadding", {
            PaddingTop = UDim.new(0, 2),
            PaddingBottom = UDim.new(0, 4),
            PaddingLeft = UDim.new(0, 2),
            PaddingRight = UDim.new(0, 2),
            Parent = page
        })

        Tab.Page = page
        Tab.Button = button

        local function activate()

            for _, other in ipairs(tabs) do
                other.Page.Visible = false

                tween(other.Button, 0.15, {
                    BackgroundColor3 = lib.Theme.Secondary
                })

                other.Button.TextColor3 = lib.Theme.SubText
            end

            page.Visible = true

            tween(button, 0.15, {
                BackgroundColor3 = lib.Theme.Element
            })

            button.TextColor3 = lib.Theme.Text

            activeTab = Tab
        end

        button.MouseButton1Click:Connect(function()
            lib:_click()
            activate()
        end)

        function Tab:CreateSection(name)
            local section = new("TextLabel", {
                Size = UDim2.new(1, -4, 0, 24),
                BackgroundTransparency = 1,
                Text = tostring(name or "Section"),
                TextColor3 = lib.Theme.Accent,
                Font = Enum.Font.GothamBold,
                TextSize = 10,
                TextXAlignment = Enum.TextXAlignment.Left,
                Parent = page
            })

            table.insert(lib.Elements, {
                _theme = function(theme)
                    section.TextColor3 = theme.Accent
                end
            })

            return section
        end

        function Tab:CreateLabel(textValue)
            local label = new("TextLabel", {
                Size = UDim2.new(1, -4, 0, 30),
                BackgroundColor3 = lib.Theme.Element,
                Text = tostring(textValue or ""),
                TextColor3 = lib.Theme.Text,
                Font = Enum.Font.Gotham,
                TextSize = 10,
                TextWrapped = true,
                TextXAlignment = Enum.TextXAlignment.Left,
                Parent = page
            })

            corner(label, 6)

            local padding = new("UIPadding", {
                PaddingLeft = UDim.new(0, 10),
                PaddingRight = UDim.new(0, 10),
                Parent = label
            })

            table.insert(lib.Elements, {
                _theme = function(theme)
                    label.BackgroundColor3 = theme.Element
                    label.TextColor3 = theme.Text
                end
            })

            local api = {}

            function api:Set(value)
                label.Text = tostring(value)
            end

            function api:Get()
                return label.Text
            end

            return api
        end

        function Tab:CreateParagraph(config)
            config = config or {}

            local holder = new("Frame", {
                Size = UDim2.new(1, -4, 0, 65),
                BackgroundColor3 = lib.Theme.Element,
                Parent = page
            })

            corner(holder, 6)

            local paragraphTitle = new("TextLabel", {
                Size = UDim2.new(1, -20, 0, 20),
                Position = UDim2.fromOffset(10, 7),
                BackgroundTransparency = 1,
                Text = tostring(config.Title or "Paragraph"),
                TextColor3 = lib.Theme.Text,
                Font = Enum.Font.GothamBold,
                TextSize = 11,
                TextXAlignment = Enum.TextXAlignment.Left,
                Parent = holder
            })

            local paragraphContent = new("TextLabel", {
                Size = UDim2.new(1, -20, 0, 35),
                Position = UDim2.fromOffset(10, 28),
                BackgroundTransparency = 1,
                Text = tostring(config.Content or ""),
                TextColor3 = lib.Theme.SubText,
                Font = Enum.Font.Gotham,
                TextSize = 9,
                TextWrapped = true,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextYAlignment = Enum.TextYAlignment.Top,
                Parent = holder
            })

            table.insert(lib.Elements, {
                _theme = function(theme)
                    holder.BackgroundColor3 = theme.Element
                    paragraphTitle.TextColor3 = theme.Text
                    paragraphContent.TextColor3 = theme.SubText
                end
            })

            return {
                Set = function(_, newConfig)
                    newConfig = newConfig or {}

                    paragraphTitle.Text = tostring(
                        newConfig.Title or paragraphTitle.Text
                    )

                    paragraphContent.Text = tostring(
                        newConfig.Content or paragraphContent.Text
                    )
                end
            }
        end

        function Tab:CreateDivider()
            local divider = new("Frame", {
                Size = UDim2.new(1, -4, 0, 1),
                BackgroundColor3 = lib.Theme.Border,
                BorderSizePixel = 0,
                Parent = page
            })

            table.insert(lib.Elements, {
                _theme = function(theme)
                    divider.BackgroundColor3 = theme.Border
                end
            })

            return divider
        end

        function Tab:CreateButton(config)
            config = config or {}

            local buttonHolder = new("TextButton", {
                Size = UDim2.new(1, -4, 0, 38),
                BackgroundColor3 = lib.Theme.Element,
                Text = "",
                AutoButtonColor = false,
                Parent = page
            })

            corner(buttonHolder, 6)

            local buttonText = new("TextLabel", {
                Size = UDim2.new(1, -20, 1, 0),
                Position = UDim2.fromOffset(10, 0),
                BackgroundTransparency = 1,
                Text = tostring(config.Name or "Button"),
                TextColor3 = lib.Theme.Text,
                Font = Enum.Font.GothamMedium,
                TextSize = 10,
                TextXAlignment = Enum.TextXAlignment.Left,
                Parent = buttonHolder
            })

            buttonHolder.MouseEnter:Connect(function()
                tween(buttonHolder, 0.12, {
                    BackgroundColor3 = lib.Theme.Hover
                })
            end)

            buttonHolder.MouseLeave:Connect(function()
                tween(buttonHolder, 0.12, {
                    BackgroundColor3 = lib.Theme.Element
                })
            end)

            buttonHolder.MouseButton1Click:Connect(function()
                lib:_click()
                callback(config.Callback)
            end)

            table.insert(lib.Elements, {
                _theme = function(theme)
                    buttonHolder.BackgroundColor3 = theme.Element
                    buttonText.TextColor3 = theme.Text
                end
            })

            return {
                Set = function(_, text)
                    buttonText.Text = tostring(text)
                end
            }
        end

        function Tab:CreateToggle(config)
            config = config or {}

            local current = config.CurrentValue == true

            if config.Flag then
                lib.Flags[config.Flag] = current
            end

            local holder = new("Frame", {
                Size = UDim2.new(1, -4, 0, 38),
                BackgroundColor3 = lib.Theme.Element,
                Parent = page
            })

            corner(holder, 6)

            local label = new("TextLabel", {
                Size = UDim2.new(1, -70, 1, 0),
                Position = UDim2.fromOffset(10, 0),
                BackgroundTransparency = 1,
                Text = tostring(config.Name or "Toggle"),
                TextColor3 = lib.Theme.Text,
                Font = Enum.Font.GothamMedium,
                TextSize = 10,
                TextXAlignment = Enum.TextXAlignment.Left,
                Parent = holder
            })

            local toggle = new("TextButton", {
                Size = UDim2.fromOffset(42, 22),
                Position = UDim2.new(1, -52, 0.5, -11),
                BackgroundColor3 = current
                    and lib.Theme.Accent
                    or lib.Theme.Hover,
                Text = "",
                AutoButtonColor = false,
                Parent = holder
            })

            corner(toggle, 11)

            local knob = new("Frame", {
                Size = UDim2.fromOffset(16, 16),
                Position = current
                    and UDim2.new(1, -19, 0.5, -8)
                    or UDim2.new(0, 3, 0.5, -8),
                BackgroundColor3 = Color3.fromRGB(245, 245, 245),
                Parent = toggle
            })

            corner(knob, 8)

            local function update(value, fire)
                current = value == true

                if config.Flag then
                    lib.Flags[config.Flag] = current
                end

                tween(toggle, 0.16, {
                    BackgroundColor3 = current
                        and lib.Theme.Accent
                        or lib.Theme.Hover
                })

                tween(knob, 0.16, {
                    Position = current
                        and UDim2.new(1, -19, 0.5, -8)
                        or UDim2.new(0, 3, 0.5, -8)
                })

                if fire then
                    callback(config.Callback, current)
                end
            end

            toggle.MouseButton1Click:Connect(function()
                lib:_click()
                update(not current, true)
            end)

            table.insert(lib.Elements, {
                _theme = function(theme)
                    holder.BackgroundColor3 = theme.Element
                    label.TextColor3 = theme.Text
                    toggle.BackgroundColor3 = current
                        and theme.Accent
                        or theme.Hover
                end
            })

            local api = {}

            function api:Set(value)
                update(value, true)
            end

            function api:Get()
                return current
            end

            function api:Refresh(value)
                update(value, false)
            end

            return api
        end

        function Tab:CreateSlider(config)
            config = config or {}

            local range = config.Range or {0, 100}
            local min = tonumber(range[1]) or 0
            local max = tonumber(range[2]) or 100
            local increment = tonumber(config.Increment) or 1

            local current = tonumber(config.CurrentValue)

            if current == nil then
                current = min
            end

            current = math.clamp(current, min, max)

            if config.Flag then
                lib.Flags[config.Flag] = current
            end

            local holder = new("Frame", {
                Size = UDim2.new(1, -4, 0, 55),
                BackgroundColor3 = lib.Theme.Element,
                Parent = page
            })

            corner(holder, 6)

            local label = new("TextLabel", {
                Size = UDim2.new(0.65, -10, 0, 22),
                Position = UDim2.fromOffset(10, 5),
                BackgroundTransparency = 1,
                Text = tostring(config.Name or "Slider"),
                TextColor3 = lib.Theme.Text,
                Font = Enum.Font.GothamMedium,
                TextSize = 10,
                TextXAlignment = Enum.TextXAlignment.Left,
                Parent = holder
            })

            local valueLabel = new("TextLabel", {
                Size = UDim2.new(0.35, -10, 0, 22),
                Position = UDim2.new(0.65, 0, 0, 5),
                BackgroundTransparency = 1,
                Text = tostring(current),
                TextColor3 = lib.Theme.SubText,
                Font = Enum.Font.Gotham,
                TextSize = 9,
                TextXAlignment = Enum.TextXAlignment.Right,
                Parent = holder
            })

            local bar = new("Frame", {
                Size = UDim2.new(1, -20, 0, 6),
                Position = UDim2.fromOffset(10, 36),
                BackgroundColor3 = lib.Theme.Hover,
                BorderSizePixel = 0,
                Parent = holder
            })

            corner(bar, 4)

            local fill = new("Frame", {
                Size = UDim2.new(
                    (current - min) / math.max(max - min, 1),
                    0,
                    1,
                    0
                ),
                BackgroundColor3 = lib.Theme.Accent,
                BorderSizePixel = 0,
                Parent = bar
            })

            corner(fill, 4)

            local dragging = false

            local function roundValue(value)
                if increment <= 0 then
                    return value
                end

                return math.floor(
                    ((value - min) / increment) + 0.5
                ) * increment + min
            end

            local function updateFromX(x, fire)
                local relative = math.clamp(
                    (x - bar.AbsolutePosition.X)
                        / math.max(bar.AbsoluteSize.X, 1),
                    0,
                    1
                )

                local value = min + (max - min) * relative

                value = roundValue(value)
                value = math.clamp(value, min, max)

                current = value

                local percent =
                    (current - min)
                    / math.max(max - min, 1)

                fill.Size = UDim2.new(percent, 0, 1, 0)
                valueLabel.Text = tostring(current)

                if config.Flag then
                    lib.Flags[config.Flag] = current
                end

                if fire then
                    callback(config.Callback, current)
                end
            end

            bar.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1
                    or input.UserInputType == Enum.UserInputType.Touch then

                    dragging = true
                    lib:_click()
                    updateFromX(input.Position.X, true)
                end
            end)

            UserInputService.InputChanged:Connect(function(input)
                if dragging and (
                    input.UserInputType == Enum.UserInputType.MouseMovement
                    or input.UserInputType == Enum.UserInputType.Touch
                ) then
                    updateFromX(input.Position.X, true)
                end
            end)

            UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1
                    or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = false
                end
            end)

            table.insert(lib.Elements, {
                _theme = function(theme)
                    holder.BackgroundColor3 = theme.Element
                    label.TextColor3 = theme.Text
                    valueLabel.TextColor3 = theme.SubText
                    bar.BackgroundColor3 = theme.Hover
                    fill.BackgroundColor3 = theme.Accent
                end
            })

            local api = {}

            function api:Set(value)
                value = tonumber(value)

                if not value then
                    return
                end

                current = math.clamp(
                    roundValue(value),
                    min,
                    max
                )

                local percent =
                    (current - min)
                    / math.max(max - min, 1)

                fill.Size = UDim2.new(percent, 0, 1, 0)
                valueLabel.Text = tostring(current)

                if config.Flag then
                    lib.Flags[config.Flag] = current
                end

                callback(config.Callback, current)
            end

            function api:Get()
                return current
            end

            return api
        end

        function Tab:CreateDropdown(config)
            config = config or {}

            local options = config.Options or {}

            local current =
                config.CurrentOption
                or options[1]
                or "None"

            if config.Flag then
                lib.Flags[config.Flag] = current
            end

            local holder = new("Frame", {
                Size = UDim2.new(1, -4, 0, 38),
                BackgroundColor3 = lib.Theme.Element,
                ClipsDescendants = true,
                Parent = page
            })

            corner(holder, 6)

            local main = new("TextButton", {
                Size = UDim2.new(1, 0, 0, 38),
                BackgroundTransparency = 1,
                Text = "",
                AutoButtonColor = false,
                Parent = holder
            })

            local label = new("TextLabel", {
                Size = UDim2.new(0.5, -10, 1, 0),
                Position = UDim2.fromOffset(10, 0),
                BackgroundTransparency = 1,
                Text = tostring(config.Name or "Dropdown"),
                TextColor3 = lib.Theme.Text,
                Font = Enum.Font.GothamMedium,
                TextSize = 11,
                TextXAlignment = Enum.TextXAlignment.Left,
                Parent = main
            })

            local selected = new("TextLabel", {
                Size = UDim2.new(0.5, -20, 1, 0),
                Position = UDim2.new(0.5, 0, 0, 0),
                BackgroundTransparency = 1,
                Text = tostring(current),
                TextColor3 = lib.Theme.SubText,
                Font = Enum.Font.Gotham,
                TextSize = 10,
                TextXAlignment = Enum.TextXAlignment.Right,
                Parent = main
            })

            -- FIX:
            -- Real ScrollingFrame instead of a normal Frame.
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
                Parent = holder
            })

            local layout = new("UIListLayout", {
                Padding = UDim.new(0, 3),
                SortOrder = Enum.SortOrder.LayoutOrder,
                Parent = list
            })

            local open = false

            local function rebuild()

                for _, child in ipairs(list:GetChildren()) do
                    if child:IsA("TextButton") then
                        child:Destroy()
                    end
                end

                for _, option in ipairs(options) do

                    local optionButton = new("TextButton", {
                        Size = UDim2.new(1, -6, 0, 28),
                        BackgroundColor3 = lib.Theme.Hover,
                        Text = tostring(option),
                        TextColor3 = lib.Theme.Text,
                        Font = Enum.Font.Gotham,
                        TextSize = 10,
                        AutoButtonColor = false,
                        Parent = list
                    })

                    corner(optionButton, 5)

                    optionButton.MouseEnter:Connect(function()
                        tween(optionButton, 0.1, {
                            BackgroundColor3 = lib.Theme.Element
                        })
                    end)

                    optionButton.MouseLeave:Connect(function()
                        tween(optionButton, 0.1, {
                            BackgroundColor3 = lib.Theme.Hover
                        })
                    end)

                    optionButton.MouseButton1Click:Connect(function()

                        current = option
                        selected.Text = tostring(option)

                        if config.Flag then
                            lib.Flags[config.Flag] = current
                        end

                        callback(config.Callback, current)
                        lib:_click()

                        open = false

                        tween(holder, 0.18, {
                            Size = UDim2.new(1, -4, 0, 38)
                        })

                        tween(list, 0.18, {
                            Size = UDim2.new(1, -8, 0, 0)
                        })
                    end)
                end
            end

            main.MouseButton1Click:Connect(function()

                lib:_click()

                open = not open

                rebuild()

                local count = #options

                local height =
                    open
                    and math.clamp(
                        count * 31 + 6,
                        0,
                        155
                    )
                    or 0

                tween(holder, 0.18, {
                    Size = UDim2.new(
                        1,
                        -4,
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
            end)

            table.insert(lib.Elements, {
                _theme = function(theme)
                    holder.BackgroundColor3 = theme.Element
                    label.TextColor3 = theme.Text
                    selected.TextColor3 = theme.SubText
                    list.ScrollBarImageColor3 = theme.Accent

                    for _, child in ipairs(list:GetChildren()) do
                        if child:IsA("TextButton") then
                            child.BackgroundColor3 = theme.Hover
                            child.TextColor3 = theme.Text
                        end
                    end
                end
            })

            local api = {}

            function api:Set(value)
                for _, option in ipairs(options) do
                    if option == value then
                        current = value
                        selected.Text = tostring(value)

                        if config.Flag then
                            lib.Flags[config.Flag] = value
                        end

                        return
                    end
                end
            end

            function api:Refresh(newOptions)
                options = newOptions or {}

                if options[1] then
                    current = options[1]
                    selected.Text = tostring(current)

                    if config.Flag then
                        lib.Flags[config.Flag] = current
                    end
                end

                if open then
                    rebuild()
                end
            end

            function api:Get()
                return current
            end

            return api
        end

        function Tab:CreateMultiDropdown(config)
            config = config or {}

            local options = config.Options or {}
            local selected = {}

            if type(config.CurrentOptions) == "table" then
                for _, value in ipairs(config.CurrentOptions) do
                    selected[value] = true
                end
            end

            if config.Flag then
                lib.Flags[config.Flag] = selected
            end

            local holder = new("Frame", {
                Size = UDim2.new(1, -4, 0, 38),
                BackgroundColor3 = lib.Theme.Element,
                ClipsDescendants = true,
                Parent = page
            })

            corner(holder, 6)

            local main = new("TextButton", {
                Size = UDim2.new(1, 0, 0, 38),
                BackgroundTransparency = 1,
                Text = "",
                AutoButtonColor = false,
                Parent = holder
            })

            local label = new("TextLabel", {
                Size = UDim2.new(0.55, -10, 1, 0),
                Position = UDim2.fromOffset(10, 0),
                BackgroundTransparency = 1,
                Text = tostring(config.Name or "Multi Dropdown"),
                TextColor3 = lib.Theme.Text,
                Font = Enum.Font.GothamMedium,
                TextSize = 10,
                TextXAlignment = Enum.TextXAlignment.Left,
                Parent = main
            })

            local selectedLabel = new("TextLabel", {
                Size = UDim2.new(0.45, -10, 1, 0),
                Position = UDim2.new(0.55, 0, 0, 0),
                BackgroundTransparency = 1,
                Text = "None",
                TextColor3 = lib.Theme.SubText,
                Font = Enum.Font.Gotham,
                TextSize = 9,
                TextXAlignment = Enum.TextXAlignment.Right,
                Parent = main
            })

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
                Parent = holder
            })

            local layout = new("UIListLayout", {
                Padding = UDim.new(0, 3),
                Parent = list
            })

            local open = false

            local function getSelectedText()
                local result = {}

                for _, option in ipairs(options) do
                    if selected[option] then
                        table.insert(result, tostring(option))
                    end
                end

                if #result == 0 then
                    return "None"
                end

                return table.concat(result, ", ")
            end

            local function rebuild()

                for _, child in ipairs(list:GetChildren()) do
                    if child:IsA("TextButton") then
                        child:Destroy()
                    end
                end

                for _, option in ipairs(options) do

                    local button = new("TextButton", {
                        Size = UDim2.new(1, -6, 0, 28),
                        BackgroundColor3 = selected[option]
                            and lib.Theme.Accent
                            or lib.Theme.Hover,
                        Text = tostring(option),
                        TextColor3 = lib.Theme.Text,
                        Font = Enum.Font.Gotham,
                        TextSize = 10,
                        AutoButtonColor = false,
                        Parent = list
                    })

                    corner(button, 5)

                    button.MouseButton1Click:Connect(function()

                        selected[option] = not selected[option]

                        button.BackgroundColor3 =
                            selected[option]
                            and lib.Theme.Accent
                            or lib.Theme.Hover

                        selectedLabel.Text = getSelectedText()

                        if config.Flag then
                            lib.Flags[config.Flag] = selected
                        end

                        callback(
                            config.Callback,
                            selected
                        )

                        lib:_click()
                    end)
                end
            end

            main.MouseButton1Click:Connect(function()

                lib:_click()

                open = not open

                rebuild()

                local height =
                    open
                    and math.clamp(
                        #options * 31 + 6,
                        0,
                        155
                    )
                    or 0

                tween(holder, 0.18, {
                    Size = UDim2.new(
                        1,
                        -4,
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
            end)

            selectedLabel.Text = getSelectedText()

            table.insert(lib.Elements, {
                _theme = function(theme)
                    holder.BackgroundColor3 = theme.Element
                    label.TextColor3 = theme.Text
                    selectedLabel.TextColor3 = theme.SubText
                    list.ScrollBarImageColor3 = theme.Accent
                end
            })

            local api = {}

            function api:Set(values)
                selected = {}

                if type(values) == "table" then
                    for _, value in ipairs(values) do
                        selected[value] = true
                    end
                end

                selectedLabel.Text = getSelectedText()

                if config.Flag then
                    lib.Flags[config.Flag] = selected
                end
            end

            function api:Get()
                local result = {}

                for _, option in ipairs(options) do
                    if selected[option] then
                        table.insert(result, option)
                    end
                end

                return result
            end

            function api:Refresh(newOptions)
                options = newOptions or {}
                rebuild()
                selectedLabel.Text = getSelectedText()
            end

            return api
        end

        function Tab:CreateInput(config)
            config = config or {}

            local holder = new("Frame", {
                Size = UDim2.new(1, -4, 0, 54),
                BackgroundColor3 = lib.Theme.Element,
                Parent = page
            })

            corner(holder, 6)

            local label = new("TextLabel", {
                Size = UDim2.new(0.42, -10, 1, 0),
                Position = UDim2.fromOffset(10, 0),
                BackgroundTransparency = 1,
                Text = tostring(config.Name or "Input"),
                TextColor3 = lib.Theme.Text,
                Font = Enum.Font.GothamMedium,
                TextSize = 10,
                TextXAlignment = Enum.TextXAlignment.Left,
                Parent = holder
            })

            local box = new("TextBox", {
                Size = UDim2.new(0.58, -16, 0, 32),
                Position = UDim2.new(0.42, 6, 0.5, -16),
                BackgroundColor3 = lib.Theme.Hover,
                TextColor3 = lib.Theme.Text,
                PlaceholderColor3 = lib.Theme.SubText,
                PlaceholderText = tostring(
                    config.PlaceholderText or ""
                ),
                Text = tostring(config.CurrentValue or ""),
                Font = Enum.Font.Gotham,
                TextSize = 10,
                ClearTextOnFocus = false,
                Parent = holder
            })

            corner(box, 5)

            box.FocusLost:Connect(function()
                callback(config.Callback, box.Text)

                if config.RemoveTextAfterFocusLost then
                    box.Text = ""
                end
            end)

            table.insert(lib.Elements, {
                _theme = function(theme)
                    holder.BackgroundColor3 = theme.Element
                    label.TextColor3 = theme.Text
                    box.BackgroundColor3 = theme.Hover
                    box.TextColor3 = theme.Text
                    box.PlaceholderColor3 = theme.SubText
                end
            })

            local api = {}

            function api:Set(value)
                box.Text = tostring(value)
            end

            function api:Get()
                return box.Text
            end

            return api
        end

        function Tab:CreateKeybind(config)
            config = config or {}

            local current = config.CurrentKeybind
                or config.Keybind
                or Enum.KeyCode.RightControl

            local holder = new("Frame", {
                Size = UDim2.new(1, -4, 0, 38),
                BackgroundColor3 = lib.Theme.Element,
                Parent = page
            })

            corner(holder, 6)

            local label = new("TextLabel", {
                Size = UDim2.new(0.55, -10, 1, 0),
                Position = UDim2.fromOffset(10, 0),
                BackgroundTransparency = 1,
                Text = tostring(config.Name or "Keybind"),
                TextColor3 = lib.Theme.Text,
                Font = Enum.Font.GothamMedium,
                TextSize = 10,
                TextXAlignment = Enum.TextXAlignment.Left,
                Parent = holder
            })

            local keyButton = new("TextButton", {
                Size = UDim2.fromOffset(75, 26),
                Position = UDim2.new(1, -85, 0.5, -13),
                BackgroundColor3 = lib.Theme.Hover,
                Text = current.Name,
                TextColor3 = lib.Theme.Text,
                Font = Enum.Font.Gotham,
                TextSize = 9,
                AutoButtonColor = false,
                Parent = holder
            })

            corner(keyButton, 5)

            local listening = false

            keyButton.MouseButton1Click:Connect(function()
                if listening then
                    return
                end

                listening = true
                keyButton.Text = "Press key..."

                lib:_click()
            end)

            UserInputService.InputBegan:Connect(function(input, processed)
                if listening then
                    if input.UserInputType == Enum.UserInputType.Keyboard then
                        current = input.KeyCode
                        keyButton.Text = current.Name
                        listening = false
                    end

                    return
                end

                if processed then
                    return
                end

                if input.KeyCode == current then
                    callback(config.Callback)
                end
            end)

            table.insert(lib.Elements, {
                _theme = function(theme)
                    holder.BackgroundColor3 = theme.Element
                    label.TextColor3 = theme.Text
                    keyButton.BackgroundColor3 = theme.Hover
                    keyButton.TextColor3 = theme.Text
                end
            })

            local api = {}

            function api:Set(key)
                if typeof(key) == "EnumItem" then
                    current = key
                    keyButton.Text = current.Name
                end
            end

            function api:Get()
                return current
            end

            return api
        end

        function Tab:CreateColorPicker(config)
            config = config or {}

            local current = config.Color
                or Color3.fromRGB(255, 255, 255)

            local holder = new("Frame", {
                Size = UDim2.new(1, -4, 0, 45),
                BackgroundColor3 = lib.Theme.Element,
                Parent = page
            })

            corner(holder, 6)

            local label = new("TextLabel", {
                Size = UDim2.new(1, -60, 1, 0),
                Position = UDim2.fromOffset(10, 0),
                BackgroundTransparency = 1,
                Text = tostring(config.Name or "Color"),
                TextColor3 = lib.Theme.Text,
                Font = Enum.Font.GothamMedium,
                TextSize = 10,
                TextXAlignment = Enum.TextXAlignment.Left,
                Parent = holder
            })

            local preview = new("Frame", {
                Size = UDim2.fromOffset(32, 25),
                Position = UDim2.new(1, -42, 0.5, -12),
                BackgroundColor3 = current,
                Parent = holder
            })

            corner(preview, 5)

            local box = new("TextBox", {
                Size = UDim2.new(1, -90, 0, 26),
                Position = UDim2.fromOffset(80, 9),
                BackgroundColor3 = lib.Theme.Hover,
                TextColor3 = lib.Theme.Text,
                PlaceholderText = "R,G,B",
                Text = "",
                Font = Enum.Font.Gotham,
                TextSize = 9,
                ClearTextOnFocus = false,
                Parent = holder
            })

            box.Visible = false
            corner(box, 5)

            local function setColor(color)
                if typeof(color) ~= "Color3" then
                    return
                end

                current = color
                preview.BackgroundColor3 = color

                if config.Flag then
                    lib.Flags[config.Flag] = color
                end

                callback(config.Callback, color)
            end

            holder.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    box.Visible = not box.Visible
                end
            end)

            box.FocusLost:Connect(function()
                local r, g, b =
                    box.Text:match(
                        "(%d+)%s*,%s*(%d+)%s*,%s*(%d+)"
                    )

                if r and g and b then
                    setColor(
                        Color3.fromRGB(
                            math.clamp(tonumber(r), 0, 255),
                            math.clamp(tonumber(g), 0, 255),
                            math.clamp(tonumber(b), 0, 255)
                        )
                    )
                end
            end)

            table.insert(lib.Elements, {
                _theme = function(theme)
                    holder.BackgroundColor3 = theme.Element
                    label.TextColor3 = theme.Text
                    box.BackgroundColor3 = theme.Hover
                    box.TextColor3 = theme.Text
                end
            })

            local api = {}

            function api:Set(color)
                setColor(color)
            end

            function api:Get()
                return current
            end

            return api
        end

        table.insert(tabs, Tab)

        if not activeTab then
            task.defer(function()
                activate()
            end)
        end

        return Tab
    end

    minimize.MouseButton1Click:Connect(function()
        lib:_click()

        local visible = body.Visible

        if visible then
            tween(window, 0.2, {
                Size = UDim2.fromOffset(
                    math.max(window.AbsoluteSize.X, 300),
                    48
                )
            })

            body.Visible = false
        else
            body.Visible = true

            tween(window, 0.2, {
                Size = requestedSize
            })
        end
    end)

    close.MouseButton1Click:Connect(function()
        lib:_click()

        tween(window, 0.2, {
            Size = UDim2.fromOffset(0, 0)
        })

        task.wait(0.22)

        if gui then
            gui:Destroy()
        end
    end)

    minimize.MouseEnter:Connect(function()
        tween(minimize, 0.1, {
            BackgroundColor3 = lib.Theme.Hover
        })
    end)

    minimize.MouseLeave:Connect(function()
        tween(minimize, 0.1, {
            BackgroundColor3 = lib.Theme.Secondary
        })
    end)

    close.MouseEnter:Connect(function()
        tween(close, 0.1, {
            BackgroundColor3 = lib.Theme.Hover
        })
    end)

    close.MouseLeave:Connect(function()
        tween(close, 0.1, {
            BackgroundColor3 = lib.Theme.Secondary
        })
    end)

    -- Dragging
    do
        local dragging = false
        local dragStart
        local startPosition

        header.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1
                or input.UserInputType == Enum.UserInputType.Touch then

                dragging = true
                dragStart = input.Position
                startPosition = window.Position
            end
        end)

        UserInputService.InputChanged:Connect(function(input)
            if not dragging then
                return
            end

            if input.UserInputType ~= Enum.UserInputType.MouseMovement
                and input.UserInputType ~= Enum.UserInputType.Touch then
                return
            end

            local delta = input.Position - dragStart

            tween(window, 0.08, {
                Position = UDim2.new(
                    startPosition.X.Scale,
                    startPosition.X.Offset + delta.X,
                    startPosition.Y.Scale,
                    startPosition.Y.Offset + delta.Y
                )
            })
        end)

        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1
                or input.UserInputType == Enum.UserInputType.Touch then

                dragging = false
            end
        end)
    end

    -- Mobile floating button
    if self.Settings.MobileButton then

        local mobileButton = new("TextButton", {
            Size = UDim2.fromOffset(45, 45),
            Position = UDim2.new(0, 15, 0.5, -22),
            BackgroundColor3 = self.Theme.Element,
            Text = "M",
            TextColor3 = self.Theme.Text,
            Font = Enum.Font.GothamBold,
            TextSize = 16,
            AutoButtonColor = false,
            Visible = UserInputService.TouchEnabled,
            Parent = gui
        })

        corner(mobileButton, 12)
        stroke(mobileButton, self.Theme.Border)

        mobileButton.MouseButton1Click:Connect(function()
            lib:_click()

            window.Visible = not window.Visible
        end)

        table.insert(lib.Elements, {
            _theme = function(theme)
                mobileButton.BackgroundColor3 = theme.Element
                mobileButton.TextColor3 = theme.Text
            end
        })
    end

    table.insert(self.Windows, windowObject)

    return windowObject
end

-- Optional RGB border animation support
Library.RGBBordersEnabled = false
Library.RGBConnection = nil

function Library:SetRGBBorders(enabled)
    self.RGBBordersEnabled = enabled == true

    if self.RGBConnection then
        self.RGBConnection:Disconnect()
        self.RGBConnection = nil
    end

    if not self.RGBBordersEnabled then
        for _, window in ipairs(self.Windows) do
            if window.WindowFrame then
                local s = window.WindowFrame:FindFirstChildOfClass("UIStroke")

                if s then
                    s.Color = self.Theme.Border
                end
            end
        end

        return
    end

    self.RGBConnection = RunService.RenderStepped:Connect(function()
        local hue = (os.clock() * 0.15) % 1
        local color = Color3.fromHSV(hue, 0.85, 1)

        for _, window in ipairs(self.Windows) do
            if window.WindowFrame then
                local s = window.WindowFrame:FindFirstChildOfClass("UIStroke")

                if s then
                    s.Color = color
                end
            end
        end
    end)
end

return Library
