--[[ База стилей ]] --
local style = include( "orgmod/cl/menu/base.lua" );
--[[ Список переменных ]] --
local windows = {};
windows.MainMenu = function()
    local Page              = 1;
    local left              = 25;
    local bottom            = 50;
    local sizeH             = 2;
    local sizeW             = ScrW() - ( 25 * 2 );
    local division3         = sizeW / 3;
    local indentation       = division3 - 40;
    local BittonListPage    = {};
    
    local Body = vgui.Create( "DFrame" );
    Body:SetTitle( "" );
    Body:SetPos( 0, 0 );
    Body:SetSize( ScrW(), ScrH() );
    Body:SetDraggable( false );
    Body:MakePopup();
    Body:ShowCloseButton( false );
    Body.Paint = function( w, h )
        surface.SetDrawColor( 255, 255, 255, 255 );
        surface.SetMaterial( Material( "orgmod/background.png" ) );
        surface.DrawTexturedRect( 0, 0, ScrW(), ScrH() );

        for k, v in pairs( BittonListPage ) do
            if ( v.page == Page ) then
                if ( not v:IsVisible() ) then
                    v:SetVisible( true );
                end;
            else
                if ( v:IsVisible() ) then
                    v:SetVisible( false );
                end;
            end;
        end;
    end;
    Body.OnMouseReleased = function( pnl, key )
        local mx, my = gui.MousePos();

        if ( mx >= left + 30 and mx <= ( left + 30 ) + indentation and my <= bottom and my >= bottom - 30 ) then
            if ( key == 107 ) then
                Page = 1;
            end;
        elseif ( mx >= left + 60 + indentation and mx <= ( left + 60 + indentation * 2 ) and my <= bottom and my >= bottom - 30 ) then
            if ( key == 107 ) then
                Page = 2;
            end;
        elseif ( mx >= left + 90 + indentation * 2 and mx <= ( left + 90 + indentation * 3 ) and my <= bottom and my >= bottom - 30 ) then
            if ( key == 107 ) then
                Page = 3;
            end;
        end;
    end;
    Body.OnKeyCodeReleased = function( pnl, key )
        if ( key == 67 or key == 70 ) then
            Body:Close();
        end;

        if ( key == 14 or key == 91 ) then
            if ( Page == 1 ) then 
                Page = 2;
            elseif ( Page == 2 ) then 
                Page = 3;
            elseif ( Page == 3 ) then 
                Page = 1;
            end;
        end;

        if ( key == 11 or key == 89 ) then
            if ( Page == 3 ) then
                Page = 2; 
            elseif ( Page == 2 ) then 
                Page = 1;
            elseif ( Page == 1 ) then 
                Page = 3;
            end;
        end;
    end;

    local TableMenu = vgui.Create( "DSprite", Body );
    TableMenu:SetPos( 0, 0 );
    TableMenu:SetSize( ScrW(), ScrH() );
    TableMenu.Paint = function( w, h )
        if ( Page == 1 ) then
            surface.SetDrawColor( 255, 255, 255, 230 );
            surface.DrawRect( left, bottom, 30 + sizeH, sizeH );
            surface.DrawRect( left + 30 + indentation, bottom, sizeW - left - indentation - sizeH, sizeH );

            surface.DrawRect( left, bottom, sizeH, 10 );
            surface.DrawRect( left+sizeW, bottom, sizeH, 10 );
            
            surface.DrawRect( left + 30, bottom - 30, indentation, sizeH );
            surface.DrawRect( left + 30, bottom - 30, sizeH, 30 );
            surface.DrawRect( left + 30 + indentation, bottom - 30, sizeH, 30 );

            surface.SetDrawColor( 160, 160, 160, 230 );
            surface.DrawRect( left + 60 + indentation, bottom - 30, indentation, sizeH );
            surface.DrawRect( left + 60 + indentation, bottom - 30, sizeH, 30 );
            surface.DrawRect( left + 60 + indentation * 2, bottom - 30, sizeH, 30 );

            surface.DrawRect( left + 90 + indentation * 2, bottom - 30, indentation, sizeH );
            surface.DrawRect( left + 90 + indentation * 2, bottom - 30, sizeH, 30 );
            surface.DrawRect( left + 90 + indentation * 3, bottom - 30, sizeH, 30 );
        end;

        if ( Page == 2 ) then
            surface.SetDrawColor( 255, 255, 255, 230 );
            surface.DrawRect( left, bottom, 60 + indentation+sizeH, sizeH );
            surface.DrawRect( left + 60 + indentation * 2, bottom, sizeW - indentation * 2 - 58, sizeH );

            surface.DrawRect( left, bottom, sizeH, 10 );
            surface.DrawRect( left + sizeW, bottom, sizeH, 10 );
            
            surface.SetDrawColor( 160, 160, 160, 230 );
            surface.DrawRect( left + 30, bottom - 30, indentation, sizeH );
            surface.DrawRect( left + 30, bottom - 30, sizeH, 30 );
            surface.DrawRect( left + 30 + indentation, bottom - 30, sizeH, 30 );

            surface.SetDrawColor( 255, 255, 255, 230 );
            surface.DrawRect( left + 60 + indentation, bottom - 30, indentation, sizeH );
            surface.DrawRect( left + 60 + indentation, bottom - 30, sizeH, 30 );
            surface.DrawRect( left + 60 + indentation * 2, bottom - 30, sizeH, 30 );

            surface.SetDrawColor( 160, 160, 160, 230 );
            surface.DrawRect( left + 90 + indentation * 2, bottom - 30, indentation, sizeH );
            surface.DrawRect( left + 90 + indentation * 2, bottom - 30, sizeH, 30 );
            surface.DrawRect( left + 90 + indentation * 3, bottom - 30, sizeH, 30 );
        end;

        if ( Page == 3 ) then
            surface.SetDrawColor( 255, 255, 255, 230 )
            surface.DrawRect( left, bottom, 90 + indentation * 2 + sizeH, sizeH )
            surface.DrawRect( left + 90 + indentation * 3, bottom, sizeW - indentation * 3 - 90, sizeH )

            surface.DrawRect( left, bottom, sizeH, 10 )
            surface.DrawRect( left + sizeW, bottom, sizeH, 10 )
            
            surface.SetDrawColor( 160, 160, 160, 230 )
            surface.DrawRect( left + 30, bottom - 30, indentation, sizeH )
            surface.DrawRect( left + 30, bottom - 30, sizeH, 30 )
            surface.DrawRect( left + 30 + indentation, bottom - 30, sizeH, 30 )

            surface.DrawRect( left + 60 + indentation, bottom - 30, indentation, sizeH );
            surface.DrawRect( left + 60 + indentation, bottom - 30, sizeH, 30 );
            surface.DrawRect( left + 60 + indentation * 2, bottom - 30, sizeH, 30 );

            surface.SetDrawColor( 255, 255, 255, 230 );
            surface.DrawRect( left + 90 + indentation * 2, bottom - 30, indentation, sizeH );
            surface.DrawRect( left + 90 + indentation * 2, bottom - 30, sizeH, 30 );
            surface.DrawRect( left + 90 + indentation * 3, bottom - 30, sizeH, 30 );
        end;
    end;

    local text = "ORGANIZATIONS";
    local TextMenu = vgui.Create( "DLabel", TableMenu );
    TextMenu:SetPos( ( left + 30 + indentation / 2 ) - ( string.len( text ) * 5.2 ), 0 );
    TextMenu:SetSize( 300, bottom+25 );
    TextMenu:SetWrap( true );
    TextMenu:SetFont( "GModNotify" );
    TextMenu:SetText( text );
    TextMenu.Think = function()
        if ( Page == 1 ) then
            TextMenu:SetColor( Color( 255, 255, 255, 230 ) );
        else
            TextMenu:SetColor( Color( 160, 160, 160, 230 ) );
        end;
    end;

    local text = "PERKS";
    local TextMenu = vgui.Create( "DLabel", TableMenu );
    TextMenu:SetPos( ( left + 60 + indentation * 1.53 ) - ( string.len( text ) * 5.2 ), 0 );
    TextMenu:SetSize( 300, bottom+25 );
    TextMenu:SetWrap( true );
    TextMenu:SetFont( "GModNotify" );
    TextMenu:SetText( text );
    TextMenu.Think = function()
        if ( Page == 2 ) then
            TextMenu:SetColor( Color( 255, 255, 255, 230 ) );
        else
            TextMenu:SetColor( Color( 160, 160, 160, 230 ) );
        end;
    end;

    local text = "BASE MANAGEMENT";
    local TextMenu = vgui.Create( "DLabel", TableMenu );
    TextMenu:SetPos( ( left + 90 + indentation * 2.53 ) - ( string.len( text ) * 5.2 ), 0 );
    TextMenu:SetSize( 300, bottom + 25 );
    TextMenu:SetWrap( true );
    TextMenu:SetFont( "GModNotify" );
    TextMenu:SetText( text );
    TextMenu.Think = function()
        if ( Page == 3 ) then
            TextMenu:SetColor( Color( 255, 255, 255, 230 ) );
        else
            TextMenu:SetColor( Color( 160, 160, 160, 230 ) );
        end;
    end;

    --[[
        Page 1
    ]]
    local BtnPage = vgui.Create( "DButton", Body );
    BtnPage:SetText( "" );		
    BtnPage:SetPos( 25, 100 );
    BtnPage:SetSize( indentation + 30, 60 );
    BtnPage.page = 1;
    BtnPage.Paint = function( w, h )
        local x, y = gui.MousePos();
        surface.SetFont( "Trebuchet24" );
        
        if ( x >= 25 and x <= ( indentation + 30 + 25 ) and y >= 100 and y <= 100 + 60 ) then
            surface.SetTextColor( 255, 255, 255, 255 );
            surface.SetDrawColor( 255, 255, 255, 255 );
        else
            surface.SetTextColor( 255, 255, 255, 200 );
            surface.SetDrawColor( 255, 255, 255, 200 );
        end;

        surface.SetMaterial( Material( "orgmod/shield.png" ) );
        surface.DrawTexturedRect( 0, 0, 50, 50 );

        surface.SetTextPos( 70, 10 );
        surface.DrawText( "Choice of organization" );

        surface.SetFont( "Trebuchet18" );
        surface.SetTextPos( 72, 30 );
        surface.DrawText( "View and manage organizations." );
    end;
    BtnPage.DoClick = function()
        include( "orgmod/cl/menu/organization_control/orgs/orgs_tab.lua" ).MainMenu();
        Body:Close();
    end;
    table.insert( BittonListPage, BtnPage );

    --[[
        Page 2
    ]]
    local BtnPage = vgui.Create( "DButton", Body );
    BtnPage:SetText( "" );		
    BtnPage:SetPos( 25, 100 );		
    BtnPage:SetSize( indentation + 30, 60 );
    BtnPage.page = 2;
    BtnPage.Paint = function( w, h )
        local x, y = gui.MousePos();
        surface.SetFont( "Trebuchet24" );
        
        if ( x >= 25 and x <= ( indentation + 30 + 25 ) and y >= 100 and y <= 100 + 60 ) then
            surface.SetTextColor( 255, 255, 255, 255 );
            surface.SetDrawColor( 255, 255, 255, 255 );
        else
            surface.SetTextColor( 255, 255, 255, 200 );
            surface.SetDrawColor( 255, 255, 255, 200 );
        end;

        surface.SetMaterial( Material( "orgmod/dress.png" ) );
        surface.DrawTexturedRect( 0, 0, 50, 50 );

        surface.SetTextPos( 70, 10 );
        surface.DrawText( "Use perks" );

        surface.SetFont( "Trebuchet18" );
        surface.SetTextPos( 72, 30 );
        surface.DrawText( "The use of special features of the organization." );
    end;
    BtnPage.DoClick = function()		
        RunConsoleCommand( "say", "/storage" );
        Body:Close();
    end;
    table.insert( BittonListPage, BtnPage );

    --[[
        Page 3
    ]]
    local BtnPage = vgui.Create( "DButton", Body );
    BtnPage:SetText( "" );
    BtnPage:SetPos( 25, 100 );
    BtnPage:SetSize( indentation + 30, 60 );
    BtnPage.page = 3;
    BtnPage.Paint = function( w, h )
        local x, y = gui.MousePos();
        surface.SetFont( "Trebuchet24" );
        
        if ( x >= 25 and x <= ( indentation + 30 + 25 ) and y >= 100 and y <= 100 + 60 ) then
            surface.SetTextColor( 255, 255, 255, 255 );
            surface.SetDrawColor( 255, 255, 255, 255 );
        else
            surface.SetTextColor( 255, 255, 255, 200 );
            surface.SetDrawColor( 255, 255, 255, 200 );
        end;

        surface.SetMaterial( Material( "orgmod/gear.png" ) );
        surface.DrawTexturedRect( 0, 0, 50, 50 );

        surface.SetTextPos( 70, 10 );
        surface.DrawText( "Mother bases" );

        surface.SetFont( "Trebuchet18" );
        surface.SetTextPos( 72, 30 );
        surface.DrawText( "View and manage current mother bases status." );
    end;
    table.insert( BittonListPage, BtnPage );
end;
return windows;