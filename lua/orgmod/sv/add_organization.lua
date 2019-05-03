util.AddNetworkString( "ORGMOD.SV.AddOrganization" );

local function func( len, ply )
    if ( IsValid( ply ) and ( ply:IsAdmin() or ply:IsSuperAdmin() ) ) then
        local title, owner, userid, access, rank_name, rank_color, cash, errorPrint;

        title = net.ReadString();
        owner = Player( net.ReadInt( 32 ) );
        access = net.ReadString();
        rank_name = net.ReadString();
        rank_color = string.ToColor( net.ReadString() );
        
        cash = net.ReadInt(32);

        errorPrint = function()
            ORGMOD:PrintNotification( ply, "Ошибка добавления организации!" );
        end;

        if ( 
            owner == nil or 
            not isentity( owner ) or 
            not IsValid( owner ) or 
            not owner:IsPlayer() 
        ) then
            errorPrint();
            return;
        end;

        if ( title == nil or not isstring( title ) ) then
            errorPrint();
            return;
        end;
        
        if ( access == nil or not isstring( access ) ) then
            errorPrint();
            return;
        end;
        
        if ( rank_name == nil or not isstring( rank_name ) ) then
            errorPrint();
            return;
        end;
        
        if ( rank_color == nil or not IsColor( rank_color ) ) then
            errorPrint();
            return;
        end;
        
        if ( cash == nil or not isnumber( cash ) ) then
            errorPrint();
            return;
        end;

        ORGMOD:PrintNotification( ply, HUD_PRINTTALK, "Появилась новая организация." );
        ORGMOD:AddPMC( title, owner, access, rank_name, rank_color, cash );
    end;
end;
net.Receive( "ORGMOD.SV.AddOrganization", func );