-- local enableClantag = ui.new_checkbox("LUA", "B", "CorsAA Clantag")
local hotkey = ui.new_hotkey('LUA', 'B', 'Force on shot')
local indicator = ui.new_checkbox('LUA', 'B', 'Force on shot indicator')
local multipoint = ui.reference('LUA', 'B', 'multi-point')
local target_hitbox = ui.reference('LUA', 'B', 'target hitbox')

local ui_get, ui_set = ui.get, ui.set
local globals_curtime, globals_tickinterval = globals.curtime, globals.tickinterval
local entity_get_player_weapon, entity_get_players, entity_get_prop = entity.get_player_weapon, entity.get_players, entity.get_prop
local plist_set = plist.set
local client_screen_size = client.screen_size
local renderer_text = renderer.text
local math_floor = math.floor

local is_pressed = false
local cached1 = {}
local cached2 = {}

client.set_event_callback('predict_command', function()
    local hotkey_state = ui_get(hotkey)
    if hotkey_state then
        if not is_pressed then
            cached_multipoint = ui_get(multipoint)
            cached_target_hitbox = ui_get(target_hitbox)

            ui_set(multipoint, {'head'})
            ui_set(target_hitbox, {'head'})
        end
        is_pressed = true
    else
        if is_pressed then
            ui_set(multipoint, cached_multipoint)
            ui_set(target_hitbox, cached_target_hitbox)
        end
        is_pressed = false
    end

    local curtime = globals_curtime()
    local tickinterval = globals_tickinterval()

    local max_backtrackable_ticks = math_floor(0.2 / tickinterval)

    local players = entity_get_players(true)
    for _, player in pairs(players) do
        local player_weapon = entity_get_player_weapon(player)
        local last_shot_time = entity_get_prop(player_weapon, 'm_fLastShotTime')
        if last_shot_time then

            local time_difference = curtime - last_shot_time
            local ticks_since_last_shot = time_difference / tickinterval

            plist_set(player, 'add to whitelist', ticks_since_last_shot > max_backtrackable_ticks and hotkey_state)
        end
    end
end)

client.set_event_callback('paint', function()
    if ui_get(indicator) and ui_get(hotkey) then
        local w, h = client_screen_size()
        local center_x, center_y = w / 2, h / 2

        renderer_text(center_x, center_y + 40, 255, 255, 255, 220, "c", 0, "Force on shot")
    end
end)

-- ClanTag
local function time_to_ticks(time)
	return math_floor(time / globals_tickinterval() + .5)
end

local skeet_tag_name = "skeet.cc (Old)"
local richgang = "richgang"
local hoodbroke = "hoodbroke"
local hoodrich = "hoodrich"
local aimheadz = "aimheadz"
local gamesneeze = "gamesneeze"
local esoWixxaSENSE = "esoWixxaSENSE"
local hurensohn = "hurensohn"
local stiegl = "$ti€gl"
local ottakring = "0ttakr1ng"
local gosser = "gö$$er"
local punti = "punt1g4y3r"

local enabled_reference = ui.new_combobox("MISC", "Miscellaneous", "Clan tag spammer", {"Off", "gamesense", skeet_tag_name, richgang, hoodbroke, hoodrich, aimheadz, gamesneeze, esoWixxaSENSE, hurensohn, stiegl, ottakring, gosser, punti})
local default_reference = ui.reference("MISC", "Miscellaneous", "Clan tag spammer")

local clan_tag_prev = ""
local enabled_prev = "Off"

ui.set_visible(default_reference, false)

local function on_enabled_changed()
	local enabled = ui_get(enabled_reference)

	ui_set(default_reference, enabled == "gamesense")
end
ui.set_callback(enabled_reference, on_enabled_changed)
on_enabled_changed()

local function gamesense_anim(text, indices)
	local text_anim = "               " .. text .. "                      " 
	local tickinterval = globals_tickinterval()
	local tickcount = globals_tickcount() + time_to_ticks(client_latency())
	local i = tickcount / time_to_ticks(0.3)
	i = math_floor(i % #indices)
	i = indices[i+1]+1

	return string_sub(text_anim, i, i+15)
end

local function run_tag_animation()
	if ui_get(enabled_reference) == skeet_tag_name then
		--don't advertise other cheats using this or drone strike
		local clan_tag = gamesense_anim("skeet.cc", {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 11, 11, 11, 11, 11, 11, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22})
		if clan_tag ~= clan_tag_prev then
			client_set_clan_tag(clan_tag)
		end
		clan_tag_prev = clan_tag
	end
	if ui_get(enabled_reference) == richgang then
		--don't advertise other cheats using this or drone strike
		local clan_tag = gamesense_anim("richgang", {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 11, 11, 11, 11, 11, 11, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22})
		if clan_tag ~= clan_tag_prev then
			client_set_clan_tag(clan_tag)
		end
		clan_tag_prev = clan_tag
	end
	if ui_get(enabled_reference) == hoodbroke then
		--don't advertise other cheats using this or drone strike
		local clan_tag = gamesense_anim("hoodbroke", {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 11, 11, 11, 11, 11, 11, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22})
		if clan_tag ~= clan_tag_prev then
			client_set_clan_tag(clan_tag)
		end
		clan_tag_prev = clan_tag
	end
	if ui_get(enabled_reference) == hoodrich then
		--don't advertise other cheats using this or drone strike
		local clan_tag = gamesense_anim("hoodrich", {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 11, 11, 11, 11, 11, 11, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22})
		if clan_tag ~= clan_tag_prev then
			client_set_clan_tag(clan_tag)
		end
		clan_tag_prev = clan_tag
	end
	if ui_get(enabled_reference) == aimheadz then
		--don't advertise other cheats using this or drone strike
		local clan_tag = gamesense_anim("aimheadz", {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 11, 11, 11, 11, 11, 11, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22})
		if clan_tag ~= clan_tag_prev then
			client_set_clan_tag(clan_tag)
		end
		clan_tag_prev = clan_tag
	end
	if ui_get(enabled_reference) == gamesneeze then
		--don't advertise other cheats using this or drone strike
		local clan_tag = gamesense_anim("gamesneeze", {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 11, 11, 11, 11, 11, 11, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22})
		if clan_tag ~= clan_tag_prev then
			client_set_clan_tag(clan_tag)
		end
		clan_tag_prev = clan_tag
	end
	if ui_get(enabled_reference) == esoWixxaSENSE then
		--don't advertise other cheats using this or drone strike
		local clan_tag = gamesense_anim("esoWixxaSENSE", {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 11, 11, 11, 11, 11, 11, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22})
		if clan_tag ~= clan_tag_prev then
			client_set_clan_tag(clan_tag)
		end
		clan_tag_prev = clan_tag
	end
	if ui_get(enabled_reference) == hurensohn then
		--don't advertise other cheats using this or drone strike
		local clan_tag = gamesense_anim("hurensohn", {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 11, 11, 11, 11, 11, 11, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22})
		if clan_tag ~= clan_tag_prev then
			client_set_clan_tag(clan_tag)
		end
		clan_tag_prev = clan_tag
	end
	if ui_get(enabled_reference) == stiegl then
		--don't advertise other cheats using this or drone strike
		local clan_tag = gamesense_anim("$ti€gl", {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 11, 11, 11, 11, 11, 11, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22})
		if clan_tag ~= clan_tag_prev then
			client_set_clan_tag(clan_tag)
		end
		clan_tag_prev = clan_tag
	end
	if ui_get(enabled_reference) == ottakring then
		--don't advertise other cheats using this or drone strike
		local clan_tag = gamesense_anim("0ttakr1ng", {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 11, 11, 11, 11, 11, 11, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22})
		if clan_tag ~= clan_tag_prev then
			client_set_clan_tag(clan_tag)
		end
		clan_tag_prev = clan_tag
	end
	if ui_get(enabled_reference) == gosser then
		--don't advertise other cheats using this or drone strike
		local clan_tag = gamesense_anim("gö$$er", {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 11, 11, 11, 11, 11, 11, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22})
		if clan_tag ~= clan_tag_prev then
			client_set_clan_tag(clan_tag)
		end
		clan_tag_prev = clan_tag
	end
		if ui_get(enabled_reference) == punti then
		--don't advertise other cheats using this or drone strike
		local clan_tag = gamesense_anim("punt1g4y3r", {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 11, 11, 11, 11, 11, 11, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22})
		if clan_tag ~= clan_tag_prev then
			client_set_clan_tag(clan_tag)
		end
		clan_tag_prev = clan_tag
	end
end

local function on_paint(ctx)
	local enabled = ui_get(enabled_reference)
	if enabled == skeet_tag_name then
		local local_player = entity_get_local_player()
		if local_player ~= nil and (not entity_is_alive(local_player)) and globals_tickcount() % 2 == 0 then --missing noclip check
			run_tag_animation()
		end
	elseif enabled == richgang then
		local local_player = entity_get_local_player()
		if local_player ~= nil and (not entity_is_alive(local_player)) and globals_tickcount() % 2 == 0 then --missing noclip check
			run_tag_animation()
		end
	elseif enabled == hoodbroke then
		local local_player = entity_get_local_player()
		if local_player ~= nil and (not entity_is_alive(local_player)) and globals_tickcount() % 2 == 0 then --missing noclip check
			run_tag_animation()
		end
	elseif enabled == hoodrich then
		local local_player = entity_get_local_player()
		if local_player ~= nil and (not entity_is_alive(local_player)) and globals_tickcount() % 2 == 0 then --missing noclip check
			run_tag_animation()
		end
	elseif enabled == aimheadz then
		local local_player = entity_get_local_player()
		if local_player ~= nil and (not entity_is_alive(local_player)) and globals_tickcount() % 2 == 0 then --missing noclip check
			run_tag_animation()
		end
	elseif enabled == gamesneeze then
		local local_player = entity_get_local_player()
		if local_player ~= nil and (not entity_is_alive(local_player)) and globals_tickcount() % 2 == 0 then --missing noclip check
			run_tag_animation()
		end
	elseif enabled == esoWixxaSENSE then
		local local_player = entity_get_local_player()
		if local_player ~= nil and (not entity_is_alive(local_player)) and globals_tickcount() % 2 == 0 then --missing noclip check
			run_tag_animation()
		end
	elseif enabled == hurensohn then
		local local_player = entity_get_local_player()
		if local_player ~= nil and (not entity_is_alive(local_player)) and globals_tickcount() % 2 == 0 then --missing noclip check
			run_tag_animation()
		end
	elseif enabled == stiegl then
		local local_player = entity_get_local_player()
		if local_player ~= nil and (not entity_is_alive(local_player)) and globals_tickcount() % 2 == 0 then --missing noclip check
			run_tag_animation()
		end
	elseif enabled == ottakring then
		local local_player = entity_get_local_player()
		if local_player ~= nil and (not entity_is_alive(local_player)) and globals_tickcount() % 2 == 0 then --missing noclip check
			run_tag_animation()
		end
	elseif enabled == gosser then
		local local_player = entity_get_local_player()
		if local_player ~= nil and (not entity_is_alive(local_player)) and globals_tickcount() % 2 == 0 then --missing noclip check
			run_tag_animation()
		end
	elseif enabled == punti then
		local local_player = entity_get_local_player()
		if local_player ~= nil and (not entity_is_alive(local_player)) and globals_tickcount() % 2 == 0 then --missing noclip check
			run_tag_animation()
		end
	elseif enabled_prev == skeet_tag_name then
		client_set_clan_tag("\0")
	end
	enabled_prev = enabled
end
client.set_event_callback("paint", on_paint)

local function on_run_command(e)
	if ui_get(enabled_reference) == skeet_tag_name then
		if e.chokedcommands == 0 then
			run_tag_animation()
		end
	end
	if ui_get(enabled_reference) == richgang then
		if e.chokedcommands == 0 then
			run_tag_animation()
		end
	end
	if ui_get(enabled_reference) == hoodbroke then
		if e.chokedcommands == 0 then
			run_tag_animation()
		end
	end
	if ui_get(enabled_reference) == hoodrich then
		if e.chokedcommands == 0 then
			run_tag_animation()
		end
	end
	if ui_get(enabled_reference) == aimheadz then
		if e.chokedcommands == 0 then
			run_tag_animation()
		end
	end
	if ui_get(enabled_reference) == esoWixxaSENSE then
		if e.chokedcommands == 0 then
			run_tag_animation()
		end
	end
	if ui_get(enabled_reference) == aimheadz then
		if e.chokedcommands == 0 then
			run_tag_animation()
		end
	end
	if ui_get(enabled_reference) == hurensohn then
		if e.chokedcommands == 0 then
			run_tag_animation()
		end
	end
	if ui_get(enabled_reference) == stiegl then
		if e.chokedcommands == 0 then
			run_tag_animation()
		end
	end
	if ui_get(enabled_reference) == ottakring then
		if e.chokedcommands == 0 then
			run_tag_animation()
		end
	end
	if ui_get(enabled_reference) == gosser then
		if e.chokedcommands == 0 then
			run_tag_animation()
		end
	end
	if ui_get(enabled_reference) == punti then
		if e.chokedcommands == 0 then
			run_tag_animation()
		end
	end
end
client.set_event_callback("run_command", on_run_command)