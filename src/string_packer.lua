local ability_defaults = {
    ["h_chips"] = 0,
    ["perma_h_mult"] = 0,
    ["partial_rounds"] = 0,
    ["h_x_chips"] = 0,
    ["perma_mult"] = 0,
    ["t_mult"] = 0,
    ["h_dollars"] = 0,
    ["set"] = "Joker",
    ["perma_p_dollars"] = 0,
    ["extra_value"] = 0,
    ["perma_bonus"] = 0,
    ["p_dollars"] = 0,
    ["perma_x_mult"] = 0,
    ["d_size"] = 0,
    ["bonus"] = 0,
    ["h_mult"] = 0,
    ["val"] = 0,
    ["perma_h_dollars"] = 0,
    ["upgrade_rounds"] = 0,
    ["mult"] = 0,
    ["perma_h_x_mult"] = 0,
    ["hands_played_at_create"] = 0,
    ["order"] = 0,
    ["perma_h_chips"] = 0,
    ["h_size"] = 0,
    ["cry_prob"] = 2,
    ["double_scale"] = true,
    ["perma_h_x_chips"] = 0,
    ["perma_x_chips"] = 0,
    ["x_chips"] = 0,
    ["h_x_mult"] = 0,
    ["type"] = "",
    ["t_chips"] = 0,
    ["x_mult"] = 0,
}

-- don't have pairs() in loadstring land, have to do things manually
local ability_keys = {}
for i,v in pairs(ability_defaults) do
    table.insert(ability_keys, i)
end

local ability_packed = nil
local keys_packed = nil

function STOPGAP_STR_PACK(data, recursive, is_game, is_ability)
	local ret_str = ""
    if is_game == nil then
        is_game = data.GAME and not recursive
    end

    if is_game and (not recursive) then
ret_str = ret_str.."local abil="..ability_packed.."local keys="..keys_packed..[[
local function def(ref, data)
    for i=1, #keys do
        local key = keys[i]
        if ref[key] and not data[key] then
            data[key] = ref[key]
        end
    end
    return data
end
]]
    end
    
    ret_str = ret_str..(recursive and "" or "return ").."{"
	
    for i, v in pairs(data) do
        local type_i, type_v = type(i), type(v)
        assert((type_i ~= "table"), "Data table cannot have an table as a key reference")

        local real_i = i
        if type_i == "string" then
            i = '['..string.format("%q",i)..']'
        else
            i = "["..i.."]"
        end

        if type_v == "table" then
            if v.m and v.e then
                v = "to_big("..v.m..","..v.e..")"
            elseif v.array and v.sign then
                local v0 = "to_big({"
                for qi = 1,#v.array do
                    v0 = v0 .. v.array[qi] .. ", "
                end
                v0 = v0 .. "},"..v.sign..")"
                v = v0
            elseif v.is and v:is(Object) then
                v = [["]].."MANUAL_REPLACE"..[["]]
            else
                v = STOPGAP_STR_PACK(v, true, is_game, real_i == "ability")
                if real_i == "ability" then
                    v = "def(abil,"..v..")"
                end
            end
        else
            if is_game and is_ability and ability_defaults[real_i] and v == ability_defaults[real_i] then
                v = "REDUNDANT"
            elseif is_game and is_ability and i == "consumeable" and next(v) == nil then
                v = "REDUNDANT"
            else
                if type_v == "string" then v = string.format("%q", v) end
                if type_v == "boolean" then v = v and "true" or "false" end
            end
        end
        
        if v ~= "REDUNDANT" then
            ret_str = ret_str..i.."="..v..","
        end
    end

    ret_str = ret_str.."}"

    return ret_str
end

ability_packed = VANILLA_STR_PACK(ability_defaults, true)
keys_packed = VANILLA_STR_PACK(ability_keys, true)

function STR_PACK(data, recursive)
	local config = STR_UNPACK(get_compressed("config/stopgap.jkr")) or {}
    if not config["strip_level"] then
        config["strip_level"] = 2
    end

    if config["strip_level"] >= 2 then
        return STOPGAP_STR_PACK(data, recursive, config, is_game)
    end

    return VANILLA_STR_PACK(data, recursive)
end