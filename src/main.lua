Stopgap = {
    config = SMODS.current_mod.config
}

G.FUNCS.cycle_options = function(args)
    args = args or {}
    if args.cycle_config and args.cycle_config.ref_table and args.cycle_config.ref_value then
        args.cycle_config.ref_table[args.cycle_config.ref_value] = args.to_key
    end
end

SMODS.current_mod.config_tab = function()
    return {n = G.UIT.ROOT, config = {colour = G.C.GREY, r = 0.1, padding = 0.5}, nodes = {
        create_option_cycle {
            label = "Save compression level",
            info = {
                "The level to pass to \"love.data.compress\".",
                "Generally, higher numbers are slower, but",
                "make smaller saves.",
                "(Balatro's default is 1, Stopgap's is 9.)"
            },
            options = {1, 2, 3, 4, 5, 6, 7, 8, 9},
            current_option = Stopgap.config.compression_level,
            w = 4.5,
            text_scale = 0.4,
            ref_table = Stopgap.config,
            ref_value = "compression_level",
            opt_callback = "cycle_options",
        },
        
        create_option_cycle {
            label = "Save Strip level",
            info = {
                "The effort that Stopgap should put in to",
                "reduce a save's size.",
                "",
                "Restart to apply changes to these settings!"
            },
            options = {"None", "Regular"},
            current_option = Stopgap.config.strip_level,
            w = 4.5,
            text_scale = 0.4,
            ref_table = Stopgap.config,
            ref_value = "strip_level",
            opt_callback = "cycle_options",
        },
    }}
end