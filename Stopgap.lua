--- STEAMODDED HEADER

--- MOD_NAME: Stopgap
--- MOD_ID: stopgap
--- MOD_AUTHOR: [TaiAurori]
--- MOD_DESCRIPTION: Employs some fancy tricks to make Cryptid saves smaller.
--- PREFIX: stopgap
--- VERSION: 1.0.0
--- LOADER_VERSION_GEQ: 1.0.0

Stopgap = {
    config = SMODS.current_mod.config
}

-- galdur
G.FUNCS.cycle_options = function(args)
    args = args or {}
    if args.cycle_config and args.cycle_config.ref_table and args.cycle_config.ref_value then
        args.cycle_config.ref_table[args.cycle_config.ref_value] = args.to_key
    end
end

SMODS.current_mod.config_tab = function()
    local scale = 5/6
    return {n=G.UIT.ROOT, config = {align = "cl", minh = G.ROOM.T.h*0.25, padding = 0.0, r = 0.1, colour = G.C.GREY}, nodes = {
        {n = G.UIT.R, config = { padding = 0.05 }, nodes = {
            {n = G.UIT.C, config = { minw = G.ROOM.T.w*0.25, padding = 0.05 }, nodes = {
                create_option_cycle{
                    label = "Save compression level",
                    info = {
                        "The level to pass to \"love.data.compress\".",
                        "Generally, higher numbers are slower, but",
                        "make smaller saves.",
                        "(Balatro's default is 1, Stopgap's is 6.)"
                    },
                    options = {1, 2, 3, 4, 5, 6, 7, 8, 9},
                    current_option = Stopgap.config.compression_level,
                    -- colour = CardSleeves.badge_colour,
                    w = 4.5,
                    text_scale = 0.4,
                    scale = scale,
                    ref_table = Stopgap.config,
                    ref_value = "compression_level",
                    opt_callback = "cycle_options",
                }
            }}
        }}
    }}
end