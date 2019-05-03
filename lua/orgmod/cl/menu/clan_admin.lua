--[[ База стилей ]] --
local style = include( "orgmod/cl/menu/base.lua" );
--[[ Список переменных ]] --
local windows = {};
--[[ Функции ]] --
windows.AddOrganizationMenu = function()
    --[[ Переменные ]]--
    local window = style.window("Добавление организации");
    window.Paint = function() draw.RoundedBox( 0, 0, 0, window:GetWide(), window:GetTall(), Color( 0, 0, 0, 200 ) ); end;
    window.OnClose = function() windows.MainMenu(); end;
    local tabControl, groupList, mainSettings, mainSettingsList, titleTextBox, playerList, accessListMenu, accessList, rankName, rankStyleMenu,
    rankStyleList, colorList, color_label, UpdateColors, color_cube, color_picker, startOrganizationCash, confirmation, AddOrganization,
    warningList, ownerSelected, a_access, b_access, c_access, d_access, e_access, f_access, g_access, h_access, i_access, j_access, k_access, 
    l_access, m_access, n_access, o_access, p_access, q_access, r_access, s_access, t_access, u_access, v_access, w_access, x_access, y_access, 
    z_access;
    --[[ Объект вкладок ]]--
    tabControl = vgui.Create( "DPropertySheet", window );
    tabControl:SetPos( 5, 30 );
    tabControl:SetSize( ScrW() - 10, ScrH() - 60 );
    tabControl.OnActiveTabChanged = function( old_tab, new_tab )
        if ( new_tab == tabControl:GetItems()[1].Tab ) then
            warningList:Clear();
        end;
    end;
    --[[ Первая вкладка: Параметры ]]--
    groupList = vgui.Create( "DPanelList" );
    groupList:SetSpacing( 5 );
    groupList:EnableHorizontal( false );
    groupList:EnableVerticalScrollbar( true );
    tabControl:AddSheet( "Параметры", groupList, nil, false, false, "Настройка базовых параметров." );
    --[[ Первый пункт настройки: Нсновное - (Первая вкладка) ]]--
    mainSettings = vgui.Create( "DCollapsibleCategory" );
    mainSettings:SetExpanded( 0 );
    mainSettings:SetLabel( "Основное" );
    groupList:AddItem( mainSettings );
    --[[ Объект панели списка - (Первая вкладка) ]]--
    mainSettingsList = vgui.Create( "DPanelList" );
    mainSettingsList:SetSpacing( 2 );
    mainSettingsList:EnableHorizontal( false );
    mainSettingsList:EnableVerticalScrollbar( true );
    mainSettings:SetContents( mainSettingsList );
    --[[ Объект поля ввода: Название организации - (Первая вкладка) ]]--
    style.label_1( "Название организации", mainSettingsList );
    titleTextBox = vgui.Create( "DTextEntry" );
    titleTextBox:SetSize( 0, 20 );
    mainSettingsList:AddItem( titleTextBox );
    --[[ Объект поля ввода: Стартовый капитал организации - (Первая вкладка) ]]--
    style.label_1( "Стартовый капитал организации", mainSettingsList );
    startOrganizationCash = vgui.Create( "DTextEntry" );
    startOrganizationCash:SetSize( 0, 20 );
    startOrganizationCash:SetNumeric( true );
    mainSettingsList:AddItem( startOrganizationCash );
    --[[ Объект списка: Владелец организации - (Первая вкладка) ]]--
    style.label_1( "Выбор владельца", mainSettingsList );
    playerList = vgui.Create( "DListView" );
    playerList:SetSize( 0, 150 );
    playerList:SetMultiSelect( false );
    playerList:AddColumn( "UserID" );
    playerList:AddColumn( "Никнейм" );
    playerList:AddColumn( "SteamID" );
    playerList:AddColumn( "SteamID64" );
    for _, ply in pairs( player.GetAll() ) do
        playerList:AddLine( ply:UserID(), ply:Nick(), ply:SteamID(), ply:SteamID64() );
    end;
    playerList.OnRowSelected = function( panel, index, row )
        ownerSelected = Player( tonumber( row:GetValue( 1 ), 32 ) );
    end;
    mainSettingsList:AddItem( playerList );
    --[[ Второй пункт настройки: Список прав - (Первая вкладка) ]]--
    accessListMenu = vgui.Create( "DCollapsibleCategory" );
    accessListMenu:SetExpanded( 0 );
    accessListMenu:SetLabel( "Список прав" );
    groupList:AddItem( accessListMenu );
    --[[ Объект панели списка - (Первая вкладка) ]]--
    accessList = vgui.Create( "DPanelList" );
    accessList:SetSpacing( 2 );
    accessList:EnableHorizontal( false );
    accessList:EnableVerticalScrollbar( true );
    accessListMenu:SetContents( accessList );
    --[[ Объект чекбокса: Установка прав владельца (A) - (Первая вкладка) ]]--
    style.label_1( "Выбор необходимых разрешений", accessList );
    a_access = vgui.Create( "DCheckBoxLabel" );
    a_access:SetText( "A - Полный доступ." );
    a_access:SetValue( 0 );
    a_access:SizeToContents();
    a_access:SetTextColor( Color( 255, 255, 255 ) );
    accessList:AddItem( a_access );
    --[[ Объект чекбокса: Установка прав владельца (B) - (Первая вкладка) ]]--
    b_access = vgui.Create( "DCheckBoxLabel" );
    b_access:SetText( "B - Управление совладельцами." );
    b_access:SetValue( 0 );
    b_access:SizeToContents();
    b_access:SetTextColor( Color( 255, 255, 255 ) );
    accessList:AddItem( b_access );
    --[[ Объект чекбокса: Установка прав владельца (C) - (Первая вкладка) ]]--
    c_access = vgui.Create( "DCheckBoxLabel" );
    c_access:SetText( "С - Покупка транспорта." );
    c_access:SetValue( 0 );
    c_access:SizeToContents();
    c_access:SetTextColor( Color( 255, 255, 255 ) );
    accessList:AddItem( c_access );
    --[[ Объект чекбокса: Установка прав владельца (D) - (Первая вкладка) ]]--
    d_access = vgui.Create( "DCheckBoxLabel" );
    d_access:SetText( "D - Покупка оружия." );
    d_access:SetValue( 0 );
    d_access:SizeToContents();
    d_access:SetTextColor( Color( 255, 255, 255 ) );
    accessList:AddItem( d_access );
    --[[ Объект чекбокса: Установка прав владельца (E) - (Первая вкладка) ]]--
    e_access = vgui.Create( "DCheckBoxLabel" );
    e_access:SetText( "E - Создания точек быстрого перемещения." );
    e_access:SetValue( 0 );
    e_access:SizeToContents();
    e_access:SetTextColor( Color( 255, 255, 255 ) );
    accessList:AddItem( e_access );
    --[[ Объект чекбокса: Установка прав владельца (F) - (Первая вкладка) ]]--
    f_access = vgui.Create( "DCheckBoxLabel" );
    f_access:SetText( "F - Управление общими миссиями." );
    f_access:SetValue( 0 );
    f_access:SizeToContents();
    f_access:SetTextColor( Color( 255, 255, 255 ) );
    accessList:AddItem( f_access );
    --[[ Объект чекбокса: Установка прав владельца (G) - (Первая вкладка) ]]--
    g_access = vgui.Create( "DCheckBoxLabel" );
    g_access:SetText( "G - Управление рангами." );
    g_access:SetValue( 0 );
    g_access:SizeToContents();
    g_access:SetTextColor( Color( 255, 255, 255 ) );
    accessList:AddItem( g_access );
    --[[ Объект чекбокса: Установка прав владельца (H) - (Первая вкладка) ]]--
    h_access = vgui.Create( "DCheckBoxLabel" );
    h_access:SetText( "H - Управление оповещениями." );
    h_access:SetValue( 0 );
    h_access:SizeToContents();
    h_access:SetTextColor( Color( 255, 255, 255 ) );
    accessList:AddItem( h_access );
    --[[ Объект чекбокса: Установка прав владельца (I) - (Первая вкладка) ]]--
    i_access = vgui.Create( "DCheckBoxLabel" );
    i_access:SetText( "I - Управление общим капиталом." );
    i_access:SetValue( 0 );
    i_access:SizeToContents();
    i_access:SetTextColor( Color( 255, 255, 255 ) );
    accessList:AddItem( i_access );
    --[[ Объект чекбокса: Установка прав владельца (J) - (Первая вкладка) ]]--
    j_access = vgui.Create( "DCheckBoxLabel" );
    j_access:SetText( "J - Управление базой." );
    j_access:SetValue( 0 );
    j_access:SizeToContents();
    j_access:SetTextColor( Color( 255, 255, 255 ) );
    accessList:AddItem( j_access );
    --[[ Объект чекбокса: Установка прав владельца (K) - (Первая вкладка) ]]--
    k_access = vgui.Create( "DCheckBoxLabel" );
    k_access:SetText( "K - Перки организации." );
    k_access:SetValue( 0 );
    k_access:SizeToContents();
    k_access:SetTextColor( Color( 255, 255, 255 ) );
    accessList:AddItem( k_access );
    --[[ Третий пункт настройки: Список прав - (Первая вкладка) ]]--
    rankStyleMenu = vgui.Create( "DCollapsibleCategory" );
    rankStyleMenu:SetExpanded( 0 );
    rankStyleMenu:SetLabel( "Настройка ранга" );
    groupList:AddItem( rankStyleMenu );
    --[[ Объект панели - (Первая вкладка) ]]--
    rankStyleList = vgui.Create( "DPanelList" );
    rankStyleList:SetSpacing( 2 );
    rankStyleList:EnableHorizontal( false );
    rankStyleList:EnableVerticalScrollbar( true );
    rankStyleMenu:SetContents( rankStyleList );
    --[[ Объект текстбокса: Название ранга - (Первая вкладка) ]]--
    style.label_1( "Название ранга", rankStyleList );
    rankName = vgui.Create( "DTextEntry" );
    rankName:SetSize( 0, 20 );
    rankStyleList:AddItem( rankName );
    --[[ Объект панели списка - (Первая вкладка) ]]--
    style.label_1( "Цвет ранга", rankStyleList );
    colorList = vgui.Create( "DPanelList" );
    colorList:SetSpacing( 2 );
    colorList:SetSize( 0, 500 );
    colorList:EnableHorizontal( true );
    colorList:EnableVerticalScrollbar( true );
    rankStyleList:AddItem( colorList );
    --[[ Объект текста: Обозначение текущего RGB - (Первая вкладка) ]]--
    color_label = vgui.Create( "DLabel" );
    color_label:SetText( "Color( 255, 0, 0 )" );
    color_label:SetPos( 40, 160 );
    color_label:SetSize( 150, 20 );
    color_label:SetFont( "Trebuchet18" );
    color_label:SetHighlight( true );
    color_label:SetColor( Color( 255, 0, 0 ) );
    colorList:AddItem( color_label );
    --[[ Процедура обновления цвета - (Первая вкладка) ]]--
    UpdateColors = function ( col )
        color_label:SetText( "Color( "..col.r..", "..col.g..", "..col.b.." )" );
        color_label:SetColor( Color( ( col.r ), ( col.g ), ( col.b ) ) );
        -- SetClipboardText( color_label:GetText() );
    end;
    --[[ Объект куба RGB: с тонами текущего color_picker - (Первая вкладка) ]]--
    color_cube, color_picker = style.colorBlockParentToPanelList( colorList, 40, 5, 155, 155 );
    color_cube.OnUserChanged = function()
        UpdateColors( color_cube:GetRGB() );
    end;
    --[[ Объект столбца RGB: - (Первая вкладка) ]]--
    color_picker.OnChange = function( col )
        color_cube:SetColor( color_picker:GetRGB() );
        UpdateColors( color_cube:GetRGB() );
    end;
    --[[ Вторая вкладка: Параметры ]]--
    confirmation = vgui.Create( "DPanelList" );
    confirmation:SetSpacing( 5 );
    confirmation:EnableHorizontal( false );
    confirmation:EnableVerticalScrollbar( true );
    tabControl:AddSheet( "Завершение", confirmation, nil, false, false, "Подтверждение добавления организации." );
    --[[ Объект кнопки: Подтверждение добавления организации - (Вторая вкладка) ]]--
    style.label_1( "Подтверждение добавления", confirmation );
    AddOrganization = vgui.Create( "DButton" )
    AddOrganization:SetText( "Добавить организацию" );
    AddOrganization:SetPos( 25, 50 );
    AddOrganization:SetSize( 300, 30 );
    AddOrganization.DoClick = function()
        warningList:Clear();
        local title, owner, access, rank, rankColor, cash, error_stat;
        error_stat = false;
        title = titleTextBox:GetValue();
        cash = startOrganizationCash:GetValue();
        owner = ownerSelected;
        rank = rankName:GetValue();
        rankColor = color_cube:GetRGB();
        access = "";

        if ( a_access:GetChecked() ) then access = access .. "a"; end;
        if ( b_access:GetChecked() ) then access = access .. "b"; end;
        if ( c_access:GetChecked() ) then access = access .. "c"; end;
        if ( d_access:GetChecked() ) then access = access .. "d"; end;
        if ( e_access:GetChecked() ) then access = access .. "e"; end;
        if ( f_access:GetChecked() ) then access = access .. "f"; end;
        if ( g_access:GetChecked() ) then access = access .. "g"; end;
        if ( h_access:GetChecked() ) then access = access .. "h"; end;
        if ( i_access:GetChecked() ) then access = access .. "i"; end;
        if ( j_access:GetChecked() ) then access = access .. "j"; end;
        if ( k_access:GetChecked() ) then access = access .. "k"; end;

        if ( string.len( title ) == 0 ) then
            warningList:AddLine( "Не заполнена строка с названием организации!" );
            if ( not error_stat ) then error_stat = true; end;
        end;
        if ( owner == nil or not IsValid( owner ) or not owner:IsPlayer() ) then
            warningList:AddLine( "Не выбран владелец организации!" );
            if ( not error_stat ) then error_stat = true; end;
        end;
        if ( string.len( access ) == 0 ) then
            warningList:AddLine( "Не выбраны права владельца организации!" );
            if ( not error_stat ) then error_stat = true; end;
        end;
        if ( string.len( rank ) == 0 ) then
            warningList:AddLine( "Не заполнена строка с названием ранга владельца!" );
            if ( not error_stat ) then error_stat = true; end;
        end;
        if ( rankColor == nil and not IsColor( rankColor ) ) then
            warningList:AddLine( "Не выбран цвет ранга владельца организации!" );
            if ( not error_stat ) then error_stat = true; end;
        end;
        if ( string.len( cash ) == 0 ) then
            warningList:AddLine( "Не выбран стартовый капитал организации!" );
            if ( not error_stat ) then error_stat = true; end;
        end;

        if ( not error_stat ) then
            ORGMOD:PrintNotification( LocalPlayer(), HUD_PRINTTALK, "Добавление новой организации..." );

            net.Start( "ORGMOD.SV.AddOrganization" );
                net.WriteString( title );
                net.WriteInt( owner:UserID(), 32 );
                net.WriteString( access );
                net.WriteString( rank );
                net.WriteString( 
                    tostring( rankColor.r ) .. " " .. tostring( rankColor.g ) ..
                    " " .. tostring( rankColor.b ) .. " " .. tostring( rankColor.a ) 
                );
                net.WriteInt( cash, 32 );
            net.SendToServer()

            window:Close();
        end;
    end;
    confirmation:AddItem( AddOrganization );
    --[[ Объект списка: Ошибки - (Вторая вкладка) ]]--
    style.label_1( "Список ошибок", confirmation );
    warningList = vgui.Create( "DListView" );
    warningList:SetSize( 0, 400 );
    warningList:SetMultiSelect( false );
    warningList:AddColumn( "Ошибка" );
    confirmation:AddItem( warningList );
end;
windows.MainMenu = function()
    local window = style.window("Управление организациями");
    window.Paint = function() draw.RoundedBox( 0, 0, 0, window:GetWide(), window:GetTall(), Color( 0, 0, 0, 200 ) ); end;
    local AddOrganization;
    AddOrganization = vgui.Create( "DButton", window )
    AddOrganization:SetText( "Добавить организацию" );
    AddOrganization:SetPos( 25, 50 );
    AddOrganization:SetSize( 300, 30 );
    AddOrganization.DoClick = function()
        windows.AddOrganizationMenu();
        window:Close();
    end;
end;
return windows;