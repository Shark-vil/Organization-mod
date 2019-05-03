local function getChatCommands( ply, text, team )
    if ( IsValid( ply ) and ( ply:IsAdmin() or ply:IsSuperAdmin() ) ) then
        if ( string.lower( text ) == "/orgadmin" ) then
            ply:ConCommand( "open_clan_menu clan_admin_menu" );
            return "";
        end;
        if ( string.lower( text ) == "/org" ) then
            ply:ConCommand( "open_clan_menu my_organizations" );
            return "";
        end;
    end;
end;
hook.Add( "PlayerSay", "ORGMOD.SV.console_commands.getChatCommands", getChatCommands );