local wezterm = require "wezterm"
local act = wezterm.action

config = {}

-- input method
config.use_ime = true

-- put tab bar at bottom of the window
-- config.tab_bar_at_bottom = true

-- color sheme
config.color_scheme = 'nightfox'

-- font settings
config.font = wezterm.font_with_fallback {
    {
        family = 'JetBrains Mono',
        harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' },
        -- weight = "Bold",
    },
    {
        family = "HackGen",
        -- weight = "Bold",
    },
}
config.font_size = 21.0

-- key bindings
config.leader = { mods = 'CTRL', key = 'b', timeout_milliseconds = 1000 }
config.keys = {
    {
        mods = 'LEADER|CTRL',
        key = 'b',
        action = act.SendKey { key = 'b', mods = 'CTRL' },
    },
    -- quick select
    {
        mods = 'LEADER',
        key = 'q',
        action = act.QuickSelect,
    },
    -- pane
    {
        mods = 'LEADER',
        key = 'o',
        action = act.ActivatePaneDirection 'Next',
    },
    {
        mods = 'LEADER',
        key = '%',
        action = act.SplitHorizontal,
    },
    {
        mods = 'LEADER',
        key = 'v', -- another keybind for SplitHorizontal
        action = act.SplitHorizontal,
    },
    {
        mods = 'LEADER',
        key = '"',
        action = act.SplitVertical,
    },
    -- tab
    {
        mods = 'LEADER',
        key = 'c',
        action = act.SpawnTab "CurrentPaneDomain",
    },
    {
        mods = 'LEADER',
        key = ',',
        action = act.PromptInputLine {
            description = 'Wezterm: set tab title',
            action = wezterm.action_callback(function(win,pane,line)
                if line then
                    win:active_tab():set_title(line)
                end
            end),
        },
    },
    -- workspace
    {
        mods = 'LEADER',
        key = 's',
        action = act.ShowLauncherArgs { flags = 'WORKSPACES' },
    },
    {
        mods = 'LEADER',
        key = '$',
        action = act.PromptInputLine {
            description = 'Wezterm: set workspace title',
            action = wezterm.action_callback(function(win,pane,line)
                if line then
                    wezterm.mux.rename_workspace(
                        wezterm.mux.get_active_workspace(),
                        line
                    )
                end
            end),
        },
    },
}

-- statusline
-- https://wezfurlong.org/wezterm/config/lua/window/set_right_status.html
wezterm.on('update-status', function(window, pane)
    -- Each element holds the text for a cell in a "powerline" style << fade
    local cells = {}

    -- current working directory
    local cwd_uri = pane:get_current_working_dir()
    if cwd_uri then
        cwd_uri = cwd_uri:sub(8) -- trim 'file://'
        local slash = cwd_uri:find '/'
        local cwd = cwd_uri:sub(slash)
        table.insert(cells, cwd)
    end

    -- workspace name
    local work_space = window:active_workspace()
    table.insert(cells, work_space)

    -- date/time: e.g.) "Wed Mar 3 08:14"
    local date = wezterm.strftime '%a %b %-d %H:%M'
    table.insert(cells, date)

    -- An entry for each battery (typically 0 or 1 battery)
    local BATTERY = utf8.char(0xf240)
    for _, b in ipairs(wezterm.battery_info()) do
        table.insert(cells, string.format(BATTERY .. ' %.0f%%', b.state_of_charge * 100))
    end

    -- The powerline < symbol
    local SOLID_LEFT_ARROW = utf8.char(0xe0b2)

    -- Color palette for the backgrounds of each cell
    local colors = {
        '#3c1361',
        '#52307c',
        '#663a82',
        '#7c5295',
        '#b491c8',
    }

    -- Foreground color for the text across the fade
    local text_fg = '#c0c0c0'

    -- The elements to be formatted
    local elements = {}
    -- How many cells have been formatted
    local num_cells = 0

    -- Translate a cell into elements
    function push(text, is_last)
        local cell_no = num_cells + 1
        table.insert(elements, { Foreground = { Color = text_fg } })
        table.insert(elements, { Background = { Color = colors[cell_no] } })
        table.insert(elements, { Text = ' ' .. text .. ' ' })
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
