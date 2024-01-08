hs.alert.show("Reloading HammerSpoon Config...")

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "H", function()
    hs.toggleConsole()
end)

-- hs.hotkey.bind({"cmd", "alt", "ctrl"}, "R", function()
--     hs.reload()
-- end)

hs.loadSpoon("ReloadConfiguration")
spoon.ReloadConfiguration:start()

hs.hotkey.bind({"cmd","alt","ctrl"}, "Up", function ()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen()
	local sf = screen:frame()
	f.x = sf.x
	f.y = sf.y
	f.w = sf.w
	f.h = sf.h
	win:setFrame(f)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Left", function()
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

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Right", function()
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

-- print input method names
-- Current input names (2024/01/08):
--   1: "Hiragana (Google)"
--   2: "Alphanumeric (Google)"
-- hs.hotkey.bind({"cmd", "alt"}, "m", function()
--   local methods = hs.keycodes.methods()
--   for i, v in ipairs(methods) do
--     print("Input Method number:", i)
--     print(v)
--   end
-- end)

-- Test for hook window focus change
-- hs.window.filter.default:subscribe(
--   hs.window.filter.windowFocused,
--   function (window, appName, event)
--     hs.alert(string.format("Focus changed to %s!", appName))
--   end
-- )

-- hs.hotkey.bind({"cmd", "alt"}, "j", function()
--   hs.keycodes.setMethod("Alphanumeric (Google)")
--   hs.alert("Set system IME to Alphanumeric.")
-- end)

hs.window.filter.default:subscribe(
  hs.window.filter.windowFocused,
  function (window, appName, event)
    if appName == "WezTerm" then
      hs.keycodes.setMethod("Alphanumeric (Google)")
      hs.alert(string.format("Wezterm focused and set IME to Alphanumeric!", appName))
    end
  end
)
