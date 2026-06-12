local function toggleVivaldiWezTerm()
  local front = hs.application.frontmostApplication()
  local bundleID = front and front:bundleID() or ""

  if bundleID == "com.github.wez.wezterm" then
    hs.application.launchOrFocusByBundleID("com.vivaldi.Vivaldi")
  else
    hs.application.launchOrFocusByBundleID("com.github.wez.wezterm")
  end
end

hs.hotkey.bind({}, "F16", toggleVivaldiWezTerm)

local function openVivaldiProfile(tabCount)
  hs.application.launchOrFocus("Vivaldi")

  hs.timer.doAfter(0.05, function()
    -- Vivaldi側で Window -> Manage Profiles に割り当てたショートカット
    hs.eventtap.keyStroke({"ctrl", "alt", "cmd"}, "p")

    hs.timer.doAfter(0.03, function()
      for i = 1, tabCount do
		hs.eventtap.keyStroke({}, "tab", 0)

        hs.timer.usleep(10000)
      end

      hs.eventtap.keyStroke({}, "return")
    end)
  end)
end

-- 英数 + 1 → Personal
hs.hotkey.bind({}, "F17", function()
  openVivaldiProfile(1)
end)

-- 英数 + 2 → KMC
hs.hotkey.bind({}, "F18", function()
  openVivaldiProfile(4)
end)

hs.alert.show("Hammerspoon loaded")
