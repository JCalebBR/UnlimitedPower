local settings_volume = 50
local settings_chance = 10
local settings_shadow = false

local mod = get_mod("UnlimitedPower")
local Audio
mod.on_setting_changed = function(setting_name)
    if setting_name == "mod_volume" then
        settings_volume = mod:get(setting_name)
    elseif setting_name == "mod_chance" then
        settings_chance = mod:get(setting_name)
    elseif setting_name == "mod_shadow" then
        settings_shadow = mod:get(setting_name)
    end
end

mod.on_all_mods_loaded = function()
    LocalServer = get_mod("DarktideLocalServer")
    if not LocalServer then
        mod:echo(
            'Required mod "Darktide Local Server" not found: Download from Nexus Mods and include in mod_load_order.txt'
        )
        mod:disable_all_hooks()
        mod:disable_all_commands()
    end
    Audio = get_mod("Audio")
    if not LocalServer then
        mod:echo(
            'Required mod "Audio Plugin" not found: Download from Nexus Mods and include in mod_load_order.txt'
        )
        mod:disable_all_hooks()
        mod:disable_all_commands()
    end
    Audio.hook_sound("play_psyker_lightning_bolt_charge", function(sound_type, sound_name, delta)
        if delta == nil or delta > 6 then
            if math.random() < (settings_chance / 100) then
                if settings_shadow == true then
                    Audio.play_file("UnlimitedPower/audio/shadow.ogg",
                        { audio_type = "sfx", volume = settings_volume, speechnorm = "e=50:r=0.0001:l=1" })
                else
                    Audio.play_file("UnlimitedPower/audio/unlimitedpower.ogg",
                        { audio_type = "sfx", volume = settings_volume, speechnorm = "e=50:r=0.0001:l=1" })
                end
            end
        end
        return true
    end)
    Audio.hook_sound("play_force_sword_on", function(sound_type, sound_name, delta)
        if delta == nil or delta > 3 then
            if math.random() < (settings_chance / 100) then
                Audio.play_file("UnlimitedPower/audio/itstreasonthen.ogg",
                    { audio_type = "sfx", volume = settings_volume, speechnorm = "e=50:r=0.0001:l=1" })
            end
        end
        return true
    end)
    Audio.hook_sound("play_warp_charge_build_up_critical", function(sound_type, sound_name, delta)
        if delta == nil or delta > 4 then
            if math.random() < (settings_chance / 100) then
                Audio.play_file("UnlimitedPower/audio/nonono.ogg",
                    { audio_type = "sfx", volume = settings_volume, speechnorm = "e=50:r=0.0001:l=1" })
            end
        end
        return true
    end)
    Audio.hook_sound("play_psyker_overload_charge_start", function(sound_type, sound_name, delta)
        if delta == nil or delta > 4 then
            if math.random() < (settings_chance / 100) then
                Audio.play_file("UnlimitedPower/audio/theattemptonmylife.ogg",
                    { audio_type = "sfx", volume = settings_volume, speechnorm = "e=50:r=0.0001:l=1" })
            end
        end
        return true
    end)
end
