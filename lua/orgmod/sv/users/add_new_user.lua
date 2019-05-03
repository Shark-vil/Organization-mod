local function PlayerSpawn( ply )
    if ( IsValid( ply ) ) then
        ORGMOD:AddUserInSystem( ply );
    end;
end;
hook.Add( "PlayerSpawn", "ORGMOD.SV.users.add_new_user.PlayerSpawn", PlayerSpawn );