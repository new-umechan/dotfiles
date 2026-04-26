local function toggleArcWezTerm()
local front = hs.application.frontmostApplication()
local bundleID = front and front:bundleID() or ""

if bundleID == "com.github.wez.wezterm" then
  hs.application.launchOrFocusByBundleID("company.thebrowser.Browser")
else
  hs.application.launchOrFocusByBundleID("com.github.wez.wezterm")
end
end

hs.hotkey.bind({}, "F18", toggleArcWezTerm)

hs.alert.show("Hammerspoon loaded")
