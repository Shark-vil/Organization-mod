--[[ Базовый стиль окна ]] --
local style = {};
style.window = function( title )
    title = title or "Menu";
    local window = vgui.Create( "DFrame" );
    window:SetPos( 0, 0 );
    window:SetSize( ScrW(), ScrH() );
    window:SetTitle( title );
    window:SetDraggable( false );
    window:MakePopup();
    return window;
end;
style.label_1 = function( text, list )
    local simpleLabel = vgui.Create( "DLabel" )
    simpleLabel:SetText( text );
    simpleLabel:SetTextColor( Color( 255, 255, 255 ) );
    simpleLabel:SetFont( "Trebuchet18" );
    list:AddItem( simpleLabel );
end;
style.colorBlockParentToPanelList = function(PanelList, x, y, w, h)
    --[[ Объект куба с тонами текущего RGB - (Первая вкладка) ]]--
    local color_cube = vgui.Create( "DColorCube" );
    color_cube:SetPos( x, y );
    color_cube:SetSize( w, h );
    PanelList:AddItem( color_cube );

    --[[ Объект столбца RGB - (Первая вкладка) ]]--
    local color_picker = vgui.Create( "DRGBPicker" );
    color_picker:SetPos( 5, 5 );
    color_picker:SetSize( 30, h );
    PanelList:AddItem( color_picker );
    return color_cube, color_picker;
end;
return style;