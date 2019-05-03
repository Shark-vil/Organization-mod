AddCSLuaFile();
file.CreateDir("orgmod");
file.CreateDir("orgmod/pmc");
file.CreateDir("orgmod/users");

ORGMOD = ORGMOD or {};

local files = {
    cl = {
        ["menu/base.lua"] = false,
        ["menu/clan_admin.lua"] = false,
        ["menu/console_commands.lua"] = true,
        ["menu/organization_control/main_menu.lua"] = false,
        ["menu/organization_control/orgs/orgs_tab.lua"] = false,
    },
    sh = {
        ["meta.lua"] = true,
    },
    sv = {
        ["users/add_new_user.lua"] = true,
        ["add_organization.lua"] = true,
        ["open_clan_menu.lua"] = true,
    }
};

local function initial_scripts()
    if ( CLIENT ) then MsgN( "Orgmod connect shared files." ); 
    else ServerLog( "Orgmod connect shared files.\n" ); end;

    for file, inc in pairs( files.sh ) do
        if ( SERVER ) then AddCSLuaFile( "orgmod/sh/" .. file ); end;
        if ( inc ) then include( "orgmod/sh/" .. file ); end;
        
        if ( CLIENT ) then MsgN( "Orgmod load file - \"orgmod/sh/" .. file .. "\"" ); 
        else ServerLog( "Orgmod load file - \"orgmod/sh/" .. file .. "\"\n" ); end;
    end;

    if ( CLIENT ) then MsgN( "Orgmod connect client files." ); 
    else ServerLog( "Orgmod connect client files.\n" ); end;

    for file, inc in pairs( files.cl ) do
        if ( SERVER ) then AddCSLuaFile( "orgmod/cl/" .. file ); end;
        if ( CLIENT ) then if ( inc ) then include( "orgmod/cl/" .. file ); end; end;

        if ( CLIENT ) then MsgN( "Orgmod load file - \"orgmod/cl/" .. file .. "\"" ); 
        else ServerLog( "Orgmod load file - \"orgmod/cl/" .. file .. "\"\n" ); end;
    end;

    if ( SERVER ) then
        ServerLog( "Orgmod connect server files.\n" );

        for file, inc in pairs( files.sv ) do
            AddCSLuaFile( "orgmod/sv/" .. file );
            if ( inc ) then include( "orgmod/sv/" .. file ); end;

            ServerLog( "Orgmod load file - \"orgmod/sv/" .. file .. "\"\n" );
        end;
    end;
end;
initial_scripts();

local function orgmod_reload( ply )
    if ( CLIENT ) then
        initial_scripts();
        MsgN( "Orgmod reload procedure - 1" );
    else
        if ( IsValid( ply ) and ( ply:IsAdmin() or ply:IsSuperAdmin() ) ) then
            initial_scripts();
            ServerLog( "Orgmod reload procedure - 2\n" );
        elseif ( not IsValid( ply ) ) then
            initial_scripts();
            ServerLog( "Orgmod reload procedure - 3\n" );
        end;
    end;
end;
concommand.Add( "orgmod_reload", orgmod_reload );