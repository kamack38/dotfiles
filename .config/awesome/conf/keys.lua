local awful         = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")
local revelation    = require("modules.revelation")
local helpers       = require("helpers")
local apps          = require("conf.apps")
revelation.init()

--- Keys
--- ~~~~
local modkey = "Mod4"
local alt    = "Mod1"
local ctrl   = "Control"
local shift  = "Shift"

--- Global key bindings
--- ~~~~~~~~~~~~~~~~~~~
awful.keyboard.append_global_keybindings({
    --- Show key bindings
    awful.key({ modkey, }, "s", hotkeys_popup.show_help,
        { description = "show help", group = "awesome" }),

    --- Change focus
    awful.key({ modkey, alt }, "Up", function() awful.client.focus.bydirection('up') end,
        { description = "focus to the up", group = "layout" }),
    awful.key({ modkey, alt }, "Down", function() awful.client.focus.bydirection('down') end,
        { description = "focus to the down", group = "layout" }),
    awful.key({ modkey, alt }, "Left", function() awful.client.focus.bydirection('left') end,
        { description = "focus to the left", group = "layout" }),
    awful.key({ modkey, alt }, "Right", function() awful.client.focus.bydirection('right') end,
        { description = "focus to the right", group = "layout" }),

    -- awful.key({ modkey, }, "w", function() mymainmenu:show() end,
    --     { description = "show main menu", group = "awesome" }),

    --- Expose all windows
    awful.key({ modkey, }, "w", function()
        revelation({ rule = { class = "Polybar" }, is_excluded = true })
    end,
        { description = "expose all widnows", group = "client" }),

    --- Layout manipulation
    awful.key({ modkey, shift }, "j", function() awful.client.swap.byidx(1) end,
        { description = "swap with next client by index", group = "client" }),
    awful.key({ modkey, shift }, "k", function() awful.client.swap.byidx(-1) end,
        { description = "swap with previous client by index", group = "client" }),
    awful.key({ modkey, ctrl }, "j", function() awful.screen.focus_relative(1) end,
        { description = "focus the next screen", group = "screen" }),
    awful.key({ modkey, ctrl }, "k", function() awful.screen.focus_relative(-1) end,
        { description = "focus the previous screen", group = "screen" }),
    awful.key({ modkey, }, "u", awful.client.urgent.jumpto,
        { description = "jump to urgent client", group = "client" }),
    awful.key({ alt, }, "Tab",
        function()
            awful.client.focus.byidx(1)
        end,
        { description = "focus next by index", group = "client" }),
    awful.key({ alt, shift }, "Tab",
        function()
            awful.client.focus.byidx(-1)
        end,
        { description = "focus previous by index", group = "client" }),

    --- Center window
    awful.key({ modkey }, "c", function()
        awful.placement.centered(c, { honor_workarea = true, honor_padding = true })
    end),

    --- Brightness Control
    awful.key({}, "XF86MonBrightnessUp", function()
        awful.spawn("brightnessctl set 5%+ -q", false)
    end, { description = "increase brightness", group = "hotkeys" }),
    awful.key({}, "XF86MonBrightnessDown", function()
        awful.spawn("brightnessctl set 5%- -q", false)
    end, { description = "decrease brightness", group = "hotkeys" }),

    --- Media keys
    awful.key({}, "XF86AudioPlay",
        function() awful.util.spawn("playerctl --player=plasma-browser-integration,%any play-pause") end,
        { description = "play/pause audio", group = "hotkeys" }),
    awful.key({}, "XF86AudioStop",
        function() awful.util.spawn("playerctl --player=plasma-browser-integration,%any stop") end,
        { description = "stop audio", group = "hotkeys" }),
    awful.key({}, "XF86AudioNext",
        function() awful.util.spawn("playerctl --player=plasma-browser-integration,%any next") end,
        { description = "skip to next", group = "hotkeys" }),
    awful.key({}, "XF86AudioPrev",
        function() awful.util.spawn("playerctl --player=plasma-browser-integration,%any previous") end,
        { description = "skip to previous", group = "hotkeys" }),
    awful.key({}, "XF86AudioMute", function() awful.util.spawn("pamixer -t") end,
        { description = "mute volume", group = "hotkeys" }),
    awful.key({}, "XF86AudioRaiseVolume", function() awful.util.spawn("pamixer -i 2") end,
        { description = "raise volume", group = "hotkeys" }),
    awful.key({}, "XF86AudioLowerVolume", function() awful.util.spawn("pamixer -d 2") end,
        { description = "lower volume", group = "hotkeys" }),
    awful.key({ shift }, "XF86AudioRaiseVolume", function() awful.util.spawn("mpc vol +2") end,
        { description = "raise mpd volume", group = "hotkeys" }),
    awful.key({ shift }, "XF86AudioLowerVolume", function() awful.util.spawn("mpc vol -2") end,
        { description = "lower mpd volume", group = "hotkeys" }),
    awful.key({ shift }, "XF86AudioNext",
        function() awful.util.spawn("playerctl --player=plasma-browser-integration,%any position 5+") end,
        { description = "go 5 sec ahead", group = "hotkeys" }),
    awful.key({ shift }, "XF86AudioPrev",
        function() awful.util.spawn("playerctl --player=plasma-browser-integration,%any position 5-") end,
        { description = "go 5 sec back", group = "hotkeys" }),

    --- Open programs
    awful.key({ modkey, }, "`", function() awful.spawn(apps.default.terminal) end,
        { description = "open a terminal", group = "launcher" }),
    awful.key({ modkey, }, "e", function() awful.spawn(apps.default.file_manager) end,
        { description = "open a file manager", group = "launcher" }),
    awful.key({ modkey, }, "b", function() awful.spawn(apps.default.web_browser) end,
        { description = "open a web browser", group = "launcher" }),

    -- awful.key({ modkey, shift }, "l", function() awful.spawn(apps.default.lock_screen_cmd) end,
    --     { description = "launch lock screen", group = "launcher" }),

    --- Awesome control
    awful.key({ modkey, shift }, "r", awesome.restart,
        { description = "reload awesome", group = "awesome" }),
    awful.key({ modkey, shift }, "q", awesome.quit,
        { description = "quit awesome", group = "awesome" }),

    --- Resize window
    awful.key({ modkey, }, "l", function() awful.tag.incmwfact(0.05) end,
        { description = "increase master width factor", group = "layout" }),
    awful.key({ modkey, }, "h", function() awful.tag.incmwfact(-0.05) end,
        { description = "decrease master width factor", group = "layout" }),

    --- Change number of columns and rows
    awful.key({ modkey, shift }, "h", function() awful.tag.incnmaster(1, nil, true) end,
        { description = "increase the number of master clients", group = "layout" }),
    awful.key({ modkey, shift }, "l", function() awful.tag.incnmaster(-1, nil, true) end,
        { description = "decrease the number of master clients", group = "layout" }),
    awful.key({ modkey, ctrl }, "h", function() awful.tag.incncol(1, nil, true) end,
        { description = "increase the number of columns", group = "layout" }),
    awful.key({ modkey, ctrl }, "l", function() awful.tag.incncol(-1, nil, true) end,
        { description = "decrease the number of columns", group = "layout" }),

    --- Select layout
    awful.key({ modkey, ctrl }, "space", function() awful.layout.inc(1) end,
        { description = "select next", group = "layout" }),
    awful.key({ modkey, shift }, "space", function() awful.layout.inc(-1) end,
        { description = "select previous", group = "layout" }),

    --- Un-minimize windows
    awful.key({ modkey, ctrl }, "n",
        function()
            local c = awful.client.restore()
            -- Focus restored client
            if c then
                c:emit_signal(
                    "request::activate", "key.unminimize", { raise = true }
                )
            end
        end,
        { description = "restore minimized", group = "client" })
})

--- Client key bindings
--- ~~~~~~~~~~~~~~~~~~~
client.connect_signal("request::default_keybindings", function()
    awful.keyboard.append_client_keybindings({

        --- Toggle fullscreen
        awful.key({ modkey, }, "f",
            function(c)
                c.fullscreen = not c.fullscreen
                c:raise()
            end,
            { description = "toggle fullscreen", group = "client" }),

        --- Close window
        awful.key({ modkey, }, "x", function(c) c:kill() end,
            { description = "close", group = "client" }),

        --- Toggle floating
        awful.key({ modkey, }, "space", awful.client.floating.toggle,
            { description = "toggle floating", group = "client" }),

        --- Keep on top
        awful.key({ modkey, }, "t", function(c) c.ontop = not c.ontop end,
            { description = "toggle keep on top", group = "client" }),

        --- Minimize windows
        awful.key({ modkey, }, "n",
            function(c)
                -- The client currently has the input focus, so it cannot be
                -- minimized, since minimized clients can't have the focus.
                c.minimized = true
            end,
            { description = "minimize", group = "client" }),

        --- Maximize windows
        awful.key({ modkey, }, "m",
            function(c)
                c.maximized = not c.maximized
                c:raise()
            end,
            { description = "(un)maximize", group = "client" }),
        awful.key({ modkey, ctrl }, "m",
            function(c)
                c.maximized_vertical = not c.maximized_vertical
                c:raise()
            end,
            { description = "(un)maximize vertically", group = "client" }),
        awful.key({ modkey, shift }, "m",
            function(c)
                c.maximized_horizontal = not c.maximized_horizontal
                c:raise()
            end,
            { description = "(un)maximize horizontally", group = "client" }),

        --- Move or swap by direction
        awful.key({ modkey, }, "Up", function(c)
            helpers.client.move_client(c, "up")
        end, { description = "move up", group = "layout" }),
        awful.key({ modkey, }, "Down", function(c)
            helpers.client.move_client(c, "down")
        end, { description = "move down", group = "layout" }),
        awful.key({ modkey, }, "Left", function(c)
            helpers.client.move_client(c, "left")
        end, { description = "move to the left", group = "layout" }),
        awful.key({ modkey, }, "Right", function(c)
            helpers.client.move_client(c, "right")
        end, { description = "move to the right", group = "layout" }),

        awful.key({ modkey, ctrl }, "Return", function(c) c:swap(awful.client.getmaster()) end,
            { description = "move to master", group = "client" }),
        awful.key({ modkey, }, "o", function(c) c:move_to_screen() end,
            { description = "move to screen", group = "client" })
    })
end)

--- Move through workspaces
--- ~~~~~~~~~~~~~~~~~~~~~~~
awful.keyboard.append_global_keybindings({
    --- Switch to next tag
    awful.key({ modkey, }, "Tab", awful.tag.viewnext,
        { description = "view next", group = "tag" }),

    --- Switch to previous tag
    awful.key({ modkey, shift }, "Tab", awful.tag.viewprev,
        { description = "view previous", group = "tag" }),

    --- Switch to previously selected tag
    awful.key({ modkey, }, "Escape", awful.tag.history.restore,
        { description = "go back", group = "tag" }),

    --- View tag only
    awful.key({
        modifiers = { modkey },
        keygroup = "numrow",
        description = "only view tag",
        group = "tags",
        on_press = function(index)
            local screen = awful.screen.focused()
            local tag = screen.tags[index]
            if tag then
                tag:view_only()
            end
        end,
    }),

    --- Toggle tag
    awful.key({
        modifiers = { modkey, ctrl },
        keygroup = "numrow",
        description = "toggle tag",
        group = "tags",
        on_press = function(index)
            local screen = awful.screen.focused()
            local tag = screen.tags[index]
            if tag then
                awful.tag.viewtoggle(tag)
            end
        end,
    }),

    --- Move focused client to tag
    awful.key({
        modifiers = { modkey, shift },
        keygroup = "numrow",
        description = "move focused client to tag",
        group = "tags",
        on_press = function(index)
            if client.focus then
                local tag = client.focus.screen.tags[index]
                if tag then
                    client.focus:move_to_tag(tag)
                end
            end
        end,
    }),
})

--- Mouse buttons on the client
--- ~~~~~~~~~~~~~~~~~~~~~~~~~~~
client.connect_signal("request::default_mousebindings", function()
    awful.mouse.append_client_mousebindings({
        -- awful.button({}, 1, function(c)
        --     c:activate({ context = "mouse_click" })
        -- end),
        -- awful.button({ mod }, 1, function(c)
        --     c:activate({ context = "mouse_click", action = "mouse_move" })
        -- end),
        -- awful.button({ mod }, 3, function(c)
        --     c:activate({ context = "mouse_click", action = "mouse_resize" })
        -- end),
        awful.button({}, 1, function(c)
            c:emit_signal("request::activate", "mouse_click", { raise = true })
        end),
        awful.button({ modkey }, 1, function(c)
            c:emit_signal("request::activate", "mouse_click", { raise = true })
            awful.mouse.client.move(c)
        end),
        awful.button({ modkey }, 3, function(c)
            c:emit_signal("request::activate", "mouse_click", { raise = true })
            awful.mouse.client.resize(c)
        end)
    })
end)
