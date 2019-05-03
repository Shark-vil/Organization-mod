if ( SERVER ) then
    util.AddNetworkString( "ORGMOD.CL.SendServersideInfoToCLient" );
end;

local meta = {
    PrintNotification = function( self, p, h, t, toClient )
        if ( p == nil or not IsValid( p ) or not p:IsPlayer() ) then 
            ErrorNoHalt( "Mistake! Invalid argument passed to the \"PrintNotification\" procedure! (Value \"p\")\n" ); return; end;
        if ( not isnumber( h ) ) then 
            ErrorNoHalt( "Mistake! Invalid argument passed to the \"PrintNotification\" procedure! (Value \"h\")\n" ); return; end;
        if ( not isstring( t ) ) then 
            ErrorNoHalt( "Mistake! Invalid argument passed to the \"PrintNotification\" procedure!\n (Value \"t\")" ); return; end;
        if ( toClient ~= nil and not isbool( toClient ) ) then 
            ErrorNoHalt( "Mistake! Invalid argument passed to the \"PrintNotification\" procedure!\n (Value \"toClient\")" ); return; end;

        if ( CLIENT ) then
            LocalPlayer():PrintMessage( h, "Client: " .. tostring( t ) .. "\r\n" )
        else
            if ( toClient ) then
                p:SendLua( [[ORGMOD:PrintNotification(]] .. h .. ", nil, ".. tostring( t ) .. [[);]] );
            else
                PrintMessage( h, "Server: " .. tostring( t ) .. "\r\n" );
            end;
        end;
    end,
    GetSid = function( self, p )
        if ( not IsValid( p ) ) then
            ErrorNoHalt( "Mistake! Invalid or non-existent argument passed to \"GetSid\" procedure! (Value \"p\")\n" );
            return nil;    
        end;

        if ( game.SinglePlayer() ) then
            return "STEAM_0:0:0";
        else
            return p:SteamID();
        end;
    end,
    GetSid64 = function( self, p )
        if ( not IsValid( p ) ) then
            ErrorNoHalt( "Mistake! Invalid or non-existent argument passed to \"GetSid64\" procedure! (Value \"p\")\n" );
            return nil;    
        end;

        if ( game.SinglePlayer() ) then
            return 0;
        else
            return p:SteamID64();
        end;
    end,
    AddUserInSystem = function( self, p )
        if ( not IsValid( p ) ) then
            ErrorNoHalt( "Mistake! Invalid or non-existent argument passed to \"AddUserInSystem\" procedure! (Value \"p\")\n" );
            return false;    
        end;

        local user = {
            sid64 = self:GetSid64( p ),
            cash = 0,
            karma = 0,
            lvl = 0,
            weapons = {},
            spawn_point = {},   --[[
                                    map
                                        pos
                                        ang
                                --]]
            mission = {},
            transport = {},
            available_perks = {},
        }; 
        
        local data;
        local data_path = "orgmod/users/data.txt";
        if ( file.Exists( data_path, "DATA" ) ) then
            data = file.Read( data_path, "DATA" );
            data = util.JSONToTable( data );
            if ( istable( data ) ) then
                for _, u in pairs( data ) do
                    if ( user.sid64 == u.sid64 ) then
                        return false;
                    end;
                end;
                data[ table.Count( data ) + 1 ] = user;
            else
                data = { [1] = user };
            end;
        else
            data = { [1] = user };
        end;
        file.Write( data_path, util.TableToJSON( data, true ) );
        return true;
    end,
    AddPMC = function( self, _title, _owner, _access, _rank_name, _rank_color, _startCash )
		local clan = {
            title = _title,                 -- Название организации
            lvl = 0,                        -- Общий уровень всей организации
            rank_list = {                   -- Названия существующих рангов
                [1] = {
                    name = _rank_name,
                    access = _access,
                    color = _rank_color,
                },
            },
            employees = {                   -- Список сотрудников
                [1] = {
                    sid64 = self:GetSid64( _owner ),
                    rankId = 1,
                },
            },                 
                                            --[[
                                                ORG PARAMS:
                                                index
                                                    userId
                                                    rankId
                                            --]]   
            cash = _startCash,              -- Общий капитал организации
            notifications = {},             -- Оповещения организации
                                            --[[
                                                index
                                                    status (simple, warning, alarm)
                                                    notification_text
                                            --]]
            karma = 0,                      -- Карма организации
            mission = {},                   -- Выполняемые миссии организации
                                            --[[
                                                index
                                                    mission_index
                                                    name
                                                    description
                                                    current_time
                                                    start_time
                                                    end_time
                                                    step
                                                    status (performed, completed, failure)
                                                    add_cash (+-Int)
                                                    add_karma (+-Int)
                                            --]]
            transport = {},                 -- Купленный транспорт организации
                                            --[[
                                                index
                                                    class
                                                    health
                                            --]]
            available_perks = {},           -- Доступные перки
                                            --[[
                                                index
                                                    perk_index
                                                    last_used_time
                                                    count
                                                    delay
                                            --]]
            mother_base = {                 -- Управление виртуальной базой
                base_destroyed = false,             -- Статус уничтожения базы
                base_equipment = {},                -- Оборудование и оружие на базе
                                                    --[[
                                                        index
                                                            eq_index
                                                            name
                                                            health
                                                            damage
                                                            breakable (true, false)
                                                    --]]
                health_base = 10000,                -- Здоровье базы
                current_base_health = 10000,        -- Текущее здоровье базы
                development_department = {          -- Отдел разработки
                    access = false,
                    experience = 0,
                    progress = 0,
                    lvl = 0,
                    workers = {},                   --[[
                                                        employees_index
                                                    --]]
                },
                science_department = {              -- Научный отдел
                    access = false,
                    experience = 0,
                    progress = 0,
                    lvl = 0,
                    workers = {},                   --[[
                                                        employees_index
                                                    --]]
                },
                support_squad = {                   -- Отряд поддержки
                    access = false,
                    experience = 0,
                    progress = 0,
                    lvl = 0,
                    workers = {},                   --[[
                                                        employees_index
                                                    --]]
                },
                base_guard = {                      -- Охрана базы
                    access = false,
                    experience = 0,
                    progress = 0,
                    lvl = 0,
                    workers = {},                   --[[
                                                        employees_index
                                                    --]]
                },
                base_development_department = {     -- Отдел развития базы
                    access = true,
                    experience = 0,
                    progress = 0,
                    lvl = 0,
                    workers = {},                   --[[
                                                        employees_index
                                                    --]]
                },
            },
        };

        local data;
        local data_path = "orgmod/pmc/data.txt";
        if ( file.Exists( data_path, "DATA" ) ) then
            data = file.Read( data_path, "DATA" );
            data = util.JSONToTable( data );
            if ( istable( data ) ) then
                data[ table.Count( data ) + 1 ] = clan;
            else
                data = { [1] = clan };
            end;
        else
            data = { [1] = clan };
        end;
        file.Write( data_path, util.TableToJSON( data, true ) );
    end,
    GetPlayerPMC = function( self, p )
        if ( CLIENT ) then

        else
            
        end;
    end,
};
meta.__index = meta;
setmetatable( ORGMOD, meta );