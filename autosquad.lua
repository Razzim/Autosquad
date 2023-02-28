--fills all vacant squad positions with squadless dorfs
--by Razzim

local utils = require('utils')

function fillSquads()
    local unit = {}

    for i, unit in pairs( df.global.world.units.active ) do
        if dfhack.units.isCitizen(unit) and unit.military.squad_id == -1 and unit.profession ~= 103 then
            assignFreeSquadPosition(unit)
        end
    end    
end

function assignFreeSquadPosition(unit)
    for i, squad in pairs( df.global.world.squads.all ) do
        if squad.symbol ~= -1 then
            for j, position in pairs( squad.positions ) do
                if position.occupant == -1 then
                    position.occupant = unit.hist_figure_id
                    unit.military.squad_id = squad.id
                    unit.military.squad_position = j
                    return
                end
            end
        end
    end
end

fillSquads()
