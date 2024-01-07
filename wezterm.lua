local wezterm = require("wezterm")
local act = wezterm.action

config = {}

-- input method
config.use_ime = true

-- put tab bar at bottom of the window
-- config.tab_bar_at_bottom = true

-- color sheme
config.color_scheme = "nightfox"

-- font settings
config.font = wezterm.font_with_fallback({
    {
        family = "JetBrains Mono",
        harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
        -- weight = "Bold",
    },
    {
        family = "HackGen",
        -- weight = "Bold",
    },
})
config.font_size = 21.0

-- key bindings
local leader_key = ";"
config.leader = { mods = "CTRL", key = leader_key, timeout_milliseconds = 1000 }
config.keys = {
    {
        mods = "LEADER|CTRL",
        key = leader_key,
        action = act.SendKey({ key = leader_key, mods = "CTRL" }),
    },
    -- quick select
    {
        mods = "LEADER",
        key = "q",
        action = act.QuickSelect,
    },
    -- pane
    {
        mods = "LEADER",
        key = "o",
        action = act.ActivatePaneDirection("Next"),
    },
    {
        mods = "LEADER",
        key = "%",
        action = act.SplitHorizontal,
    },
    {
        mods = "LEADER",
        key = "v", -- another keybind for SplitHorizontal
        action = act.SplitHorizontal,
    },
    {
        mods = "LEADER",
        key = '"',
        action = act.SplitVertical,
    },
    -- tab
    {
        mods = "LEADER",
        key = "c",
        action = act.SpawnTab("CurrentPaneDomain"),
    },
    {
        mods = "LEADER",
        key = ",",
        action = act.PromptInputLine({
            description = "(wezterm) Set tab title:",
            action = wezterm.action_callback(function(win, pane, line)
                if line then
                    win:active_tab():set_title(line)
                end
            end),
        }),
    },
    {
        mods = "CTRL",
        key = "@",
        action = act.Nop, -- disable mysterious "activate 2nd tab"
    },
    -- workspace
    {
        mods = "LEADER",
        key = "a",
        action = act.ShowLauncherArgs({ flags = "WORKSPACES", title = "Select workspace" }),
    },
    {
        -- Rename workspace
        mods = "LEADER",
        key = "$",
        action = act.PromptInputLine({
            description = "(wezterm) Set workspace title:",
            action = wezterm.action_callback(function(win, pane, line)
                if line then
                    wezterm.mux.rename_workspace(wezterm.mux.get_active_workspace(), line)
                end
            end),
        }),
    },
    {
        -- Create new workspace
        mods = "LEADER|SHIFT",
        key = "S",
        action = act.PromptInputLine({
            description = "(wezterm) Create new workspace:",
            action = wezterm.action_callback(function(window, pane, line)
                if line then
                    window:perform_action(
                        act.SwitchToWorkspace({
                            name = line,
                        }),
                        pane
                    )
                end
            end),
        }),
    },
    {
        -- Switch between workspaces
        mods = "LEADER",
        key = "s",
        action = wezterm.action_callback(function(win, pane)
            local workspaces = {}
            for i, name in ipairs(wezterm.mux.get_workspace_names()) do
                table.insert(workspaces, {
                    id = name,
                    label = string.format("%d. %s", i, name),
                })
            end
            local current = wezterm.mux.get_active_workspace()
            win:perform_action(
                act.InputSelector({
                    action = wezterm.action_callback(function(_, _, id, label)
                        if not id and not label then
                            wezterm.log_info("Workspace selection canceled")
                        else
                            win:perform_action(act.SwitchToWorkspace({ name = id }), pane)
                        end
                    end),
                    title = "Switch workspace",
                    choices = workspaces,
                    fuzzy = true,
                    fuzzy_description = string.format("Switch workspace: %s -> ", current), -- requires nightly build
                }),
                pane
            )
        end),
    },
}

-- statusline
-- https://wezfurlong.org/wezterm/config/lua/window/set_right_status.html
wezterm.on("update-status", function(window, pane)
    -- Each element holds the text for a cell in a "powerline" style << fade
    local cells = {}

    -- current working directory
    local cwd_uri = pane:get_current_working_dir()
    if cwd_uri then
        -- Type of cwd_uri changed from string to Url object
        -- see, https://wezfurlong.org/wezterm/config/lua/wezterm.url/Url.html
        local cwd = cwd_uri.file_path
        table.insert(cells, cwd)
    end

    -- workspace name
    local work_space = window:active_workspace()
    table.insert(cells, work_space)

    -- date/time: e.g.) "Wed Mar 3 08:14"
    local date = wezterm.strftime("%a %b %-d %H:%M")
    table.insert(cells, date)

    -- An entry for each battery (typically 0 or 1 battery)
    local BATTERY = utf8.char(0xf240)
    for _, b in ipairs(wezterm.battery_info()) do
        table.insert(cells, string.format(BATTERY .. " %.0f%%", b.state_of_charge * 100))
    end

    -- The powerline < symbol
    local SOLID_LEFT_ARROW = utf8.char(0xe0b2)

    -- Color palette for the backgrounds of each cell
    local colors = {
        "#3c1361",
        "#52307c",
        "#663a82",
        "#7c5295",
        "#b491c8",
    }

    -- Foreground color for the text across the fade
    local text_fg = "#c0c0c0"

    -- The elements to be formatted
    local elements = {}
    -- How many cells have been formatted
    local num_cells = 0

    -- Translate a cell into elements
    function push(text, is_last)
        local cell_no = num_cells + 1
        table.insert(elements, { Foreground = { Color = text_fg } })
        table.insert(elements, { Background = { Color = colors[cell_no] } })
        table.insert(elements, { Text = " " .. text .. " " })
        if not is_last then
            table.insert(elements, { Foreground = { Color = colors[cell_no + 1] } })
            table.insert(elements, { Text = SOLID_LEFT_ARROW })
        end
        num_cells = num_cells + 1
    end

    while #cells > 0 do
        local cell = table.remove(cells, 1)
        push(cell, #cells == 0)
    end

    window:set_right_status(wezterm.format(elements))
end)

return config
