--[[ Окна ]] --
ORGMOD.windows = {};
ORGMOD.windows.OrganizationAdmin = include( "orgmod/cl/menu/clan_admin.lua" );
ORGMOD.windows.OrganizationControl = include( "orgmod/cl/menu/organization_control/main_menu.lua" );
--[[ Консольные команды ]] --
-- Открыть меню управления кланом
concommand.Add(
    "open_clan_menu", 
    function( ply, cmd, args )
        if ( string.lower( args[1] ) == "clan_admin_menu" and ( LocalPlayer():IsAdmin() or LocalPlayer():IsSuperAdmin() ) ) then
            ORGMOD.windows.OrganizationAdmin.MainMenu();
        end;
        if ( string.lower( args[1] ) == "my_organizations" ) then
            ORGMOD.windows.OrganizationControl.MainMenu();
        end;
    end,
    function( cmd, stringargs )
        stringargs = string.Trim( stringargs );
        stringargs = string.lower( stringargs );
        local windows = {
            ["clan_admin_menu"] = true,
            ["my_organizations"] = false,
        };
        local data_result = {};
        if ( string.len( stringargs ) == 0 ) then
            for window, adminOnly in pairs( windows ) do
                if ( adminOnly ) then
                    if ( LocalPlayer():IsAdmin() or LocalPlayer():IsSuperAdmin() ) then
                        table.insert( data_result, "open_clan_menu " .. window );
                    end;
                else
                    table.insert( data_result, "open_clan_menu " .. window );
                end;   
            end;
        else
            for window, adminOnly in pairs( windows ) do
                if ( string.find( "open_clan_menu " .. window, stringargs .. "*" ) ) then
                    if ( adminOnly ) then
                        if ( LocalPlayer():IsAdmin() or LocalPlayer():IsSuperAdmin() ) then
                            table.insert( data_result, "open_clan_menu " .. window );
                        end;
                    else
                        table.insert( data_result, "open_clan_menu " .. window );
                    end;  
                end;
            end;
        end;
        return data_result;
    end, 
    "Help text.", 
    FCVAR_USERINFO
);