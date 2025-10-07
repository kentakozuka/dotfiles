-- Enable IPC for command line access
hs.ipc.cliInstall()

-- Disable window animations
hs.window.animationDuration = 0

-- Left Half
hs.hotkey.bind({"ctrl", "alt"}, "Left", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()
  f.x = max.x
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
end)

-- Right Half
hs.hotkey.bind({"ctrl", "alt"}, "Right", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()
  f.x = max.x + (max.w / 2)
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
end)

-- Top Half
hs.hotkey.bind({"ctrl", "alt"}, "Up", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()
  f.x = max.x
  f.y = max.y
  f.w = max.w
  f.h = max.h / 2
  win:setFrame(f)
end)

-- Bottom Half
hs.hotkey.bind({"ctrl", "alt"}, "Down", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()
  f.x = max.x
  f.y = max.y + (max.h / 2)
  f.w = max.w
  f.h = max.h / 2
  win:setFrame(f)
end)

-- Full
hs.hotkey.bind({"ctrl", "alt"}, "Return", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()
  f.x = max.x
  f.y = max.y
  f.w = max.w
  f.h = max.h
  win:setFrame(f)
end)

-- Top Left
hs.hotkey.bind({"ctrl", "cmd"}, "Left", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()
  f.x = max.x
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h / 2
  win:setFrame(f)
end)

-- Top Right
hs.hotkey.bind({"ctrl", "cmd"}, "Right", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()
  f.x = max.x + (max.w / 2)
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h / 2
  win:setFrame(f)
end)

-- Bottom Left
hs.hotkey.bind({"ctrl", "shift"}, "Left", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()
  f.x = max.x
  f.y = max.y + (max.h / 2)
  f.w = max.w / 2
  f.h = max.h / 2
  win:setFrame(f)
end)

-- Bottom Right
hs.hotkey.bind({"ctrl", "shift"}, "Right", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()
  f.x = max.x + (max.w / 2)
  f.y = max.y + (max.h / 2)
  f.w = max.w / 2
  f.h = max.h / 2
  win:setFrame(f)
end)

-- Center
hs.hotkey.bind({"ctrl", "alt"}, "C", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()
  f.w = max.w * 0.7
  f.h = max.h * 0.7
  f.x = max.x + (max.w - f.w) / 2
  f.y = max.y + (max.h - f.h) / 2
  win:setFrame(f)
end)

local function keyCode(key, modifiers)
  modifiers = modifiers or {}
  return function()
    hs.eventtap.event.newKeyEvent(modifiers, string.lower(key), true):post()
    hs.timer.usleep(1000)
    hs.eventtap.event.newKeyEvent(modifiers, string.lower(key), false):post()
  end
end

local function keyCodeSet(keys)
  return function()
    for i, keyEvent in ipairs(keys) do
      keyEvent()
    end
  end
end

local function remapKey(modifiers, key, keyCode)
  hs.hotkey.bind(modifiers, key, keyCode, nil, keyCode)
end

remapKey({ 'ctrl' }, '[',  keyCodeSet({
    keyCode('escape'),
    keyCode(';', {'ctrl', 'shift'})
}))

-- Switc kana/alphanumeric.
-- https://zenn.dev/obregonia1/articles/419ae303355f54
-- Why simply hotkey.bind does not work?
-- https://mac-ra.com/hammerspoon-command-eikana02/
local simpleCmd = false
local map = hs.keycodes.map
local function eikanaEvent(event)
  local c = event:getKeyCode()
  local f = event:getFlags()
  if event:getType() == hs.eventtap.event.types.keyDown then
    if f['cmd'] then
      simpleCmd = true
    end
  elseif event:getType() == hs.eventtap.event.types.flagsChanged then
    if not f['cmd'] then
      if simpleCmd == false then
        if c == map['cmd'] then
          hs.keycodes.setMethod('Alphanumeric (Google)')
        elseif c == map['rightcmd'] then
          hs.keycodes.setMethod('Hiragana (Google)')
        end
      end
      simpleCmd = false
    end
  end
end

eikana = hs.eventtap.new({hs.eventtap.event.types.keyDown, hs.eventtap.event.types.flagsChanged}, eikanaEvent)
eikana:start()

-- Reload config
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "R", function()
  hs.reload()
end)

-- Configure macOS system preferences
-- Disable most recently used spaces ordering
hs.execute("defaults write com.apple.dock mru-spaces -bool false && killall Dock 2>/dev/null || true")
-- Enable dock auto-hide
hs.execute("defaults write com.apple.dock autohide -bool true && killall Dock 2>/dev/null || true")
-- Force 24-hour time format
hs.execute("defaults write NSGlobalDomain AppleICUForce24HourTime -bool true")
-- Always show menu bar
hs.execute("defaults write NSGlobalDomain _HIHideMenuBar -bool false")
-- Show app switcher on all displays
hs.execute("defaults write com.apple.Dock appswitcher-all-displays -bool true && killall Dock 2>/dev/null || true")

hs.alert.show("Config loaded")