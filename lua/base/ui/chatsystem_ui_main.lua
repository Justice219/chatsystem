chatsystem = chatsystem or {}
chatsystem.client = chatsystem.client or {}
chatsystem.client.menus = chatsystem.client.menus or {}
chatsystem.client.data = chatsystem.client.data or {}
chatsystem.client.data.commands = chatsystem.client.data.commands or {}

function chatsystem.client.menus.main()
    local tabs = {}
    local data = {}
    local funcs = {}

    local function ScaleW(size)
        return ScrW() * size/1920
    end
    local function ScaleH(size)
        return ScrH() * size/1080        
    end

    surface.CreateFont("menu_title", {
        font = "Roboto",
        size = 20,
        weight = 500,
        antialias = true,
        shadow = false
    })
    surface.CreateFont("menu_button", {
        font = "Roboto",
        size = 22.5,
        weight = 500,
        antialias = true,
        shadow = false
    })

    local panel = vgui.Create("DPanel")
    panel:TDLib()
    panel:SetSize(ScaleW(960), ScaleH(540))
    panel:Center()
    panel:MakePopup()
    panel:ClearPaint()
        :Background(Color(40, 41, 40), 6)
        :Text("Chat System Panel", "DermaLarge", Color(255, 255, 255), TEXT_ALIGN_LEFT, ScaleW(410), ScaleH(-240))
        :Text("v1.0", "DermaLarge", Color(255, 255, 255), TEXT_ALIGN_LEFT, ScaleW(5),ScaleH(250))
        :CircleHover(Color(59, 59, 59), 5, 20)

    local panel2 = panel:Add("DPanel")
    panel2:TDLib()
    panel2:SetPos(ScaleW(0), ScaleH(60))
    panel2:SetSize(ScaleW(1920), ScaleH(5))
    panel2:ClearPaint()
        :Background(Color(255, 255, 255), 0)

    local panel3 = panel:Add("DPanel")
    panel3:TDLib()
    panel3:SetPos(ScaleW(275), ScaleH(60))
    panel3:SetSize(ScaleW(5), ScaleH(1000))
    panel3:ClearPaint()
        :Background(Color(255, 255, 255), 0)


    local close = panel:Add("DImageButton")
    close:SetPos(ScaleW(925),ScaleH(10))
    close:SetSize(ScaleW(20),ScaleH(20))
    close:SetImage("icon16/cross.png")
    close.DoClick = function()
        panel:Remove()
    end

    local scroll = panel:Add("DScrollPanel")
    scroll:SetPos(ScaleW(17.5), ScaleH(75))
    scroll:SetSize(ScaleW(240), ScaleW(425))
    scroll:TDLib()
    scroll:ClearPaint()
        --:Background(Color(0, 26, 255), 6)
        :CircleHover(Color(59, 59, 59), 5, 20)

      local function ChangeTab(name)
        print("Changing Tab")
        for k,v in pairs(data) do
            table.RemoveByValue(data, v)
            v:Remove()
            print("Removed")
        end

        local tbl = tabs[name]
        tbl.change()

    end
    
    local function CreateTab(name, tbl)
        local scroll = scroll:Add( "DButton" )
        scroll:SetText( name)
        scroll:Dock( TOP )
        scroll:SetTall( 50 )
        scroll:DockMargin( 0, 5, 0, 5 )
        scroll:SetTextColor(Color(255,255,255))
        scroll:TDLib()
        scroll:SetFont("menu_button")
        scroll:SetIcon(tbl.icon)
        scroll:ClearPaint()
            :Background(Color(59, 59, 59), 5)
            :BarHover(Color(255, 255, 255), 3)
            :CircleClick()
        scroll.DoClick = function()
            ChangeTab(name)
        end

        if tabs[name] then return end
        tabs[name] = tbl
    end

    CreateTab("Commands", {
        icon = "icon16/application_view_list.png",
        change = function()
            local d = {}
            local p = nil
            local sel = nil

            commands = panel:Add("DPanel")
            commands:SetPos(ScaleW(290), ScaleH(75))
            commands:SetSize(ScaleW(660), ScaleH(455))
            commands:TDLib()
            commands:ClearPaint()
                :Background(Color(59, 59, 59), 6)
                :Text("Command Management", "DermaLarge", Color(255, 255, 255), TEXT_ALIGN_LEFT, ScaleW(210),ScaleH(-202.5))
            table.insert(d, #d, commands)

            local scroll = commands:Add("DScrollPanel")
            scroll:SetPos(ScaleW(17.5), ScaleH(50))
            scroll:SetSize(ScaleW(240), ScaleW(390))
            scroll:TDLib()
            scroll:ClearPaint()
                :Background(Color(40,41,40), 5)

            local infop = commands:Add("DPanel")
            infop:SetPos(ScaleW(275), ScaleH(50))
            infop:SetSize(ScaleW(370), ScaleW(390))
            infop:TDLib()
            infop:ClearPaint()
                :Background(Color(40,41,40), 5)

            rank = infop:Add("DButton")
            rank:SetPos(ScaleW(15), ScaleH(230))
            rank:SetSize(ScaleW(337.5), ScaleH(30))
            rank:SetText("Rank Access")
            rank:SetFont("menu_button")
            rank:SetTextColor(Color(255,255,255))
            rank:TDLib()
            rank:ClearPaint()
                :Background(Color(59, 59, 59), 5)
                :BarHover(Color(255, 255, 255), 3)
                :CircleClick()
            rank.DoClick = function()
                if not sel then return end
                local j = {}
                panel:Remove()

                pop = vgui.Create("DFrame")
                pop:SetSize(ScaleW(600), ScaleH(200))
                pop:Center()
                pop:ShowCloseButton(false)
                pop:MakePopup()
                pop:SetTitle("Rank Access")
                pop:TDLib()
                pop:ClearPaint()
                    :Background(Color(40,41,40), 6)
                    :CircleHover(Color(59, 59, 59), 5, 20)

                local close = pop:Add("DImageButton")
                close:SetPos(ScaleW(575), ScaleH(15))
                close:SetSize(ScaleW(20), ScaleH(20))
                close:SetImage("icon16/cross.png")
                close:TDLib()
                close.DoClick = function()

                    pop:Remove()
                end

                local scroll = pop:Add("DScrollPanel")
                scroll:SetPos(ScaleW(15), ScaleH(65))
                scroll:SetSize(ScaleW(570), ScaleH(100))
                scroll:TDLib()
                scroll:ClearPaint()
                    :Background(Color(40,41,40), 5)
                    :CircleClick()

                local entry = pop:Add("DTextEntry")
                entry:SetPos(ScaleW(15), ScaleH(30))
                entry:SetSize(ScaleW(500), ScaleH(30))
                entry:SetFont("menu_button")
                entry:SetText("Test")
                entry:SetTextColor(Color(255,255,255))
                entry.Paint = function(self, w, h)
                    draw.RoundedBox( 6, 0, 0, w, h, Color(59, 59, 59))
                    self:DrawTextEntryText(Color(255, 255, 255), Color(255, 0, 0), Color(255, 255, 255))
                end

                local button = pop:Add("DButton")
                button:SetPos(ScaleW(510), ScaleH(30))
                button:SetSize(ScaleW(80), ScaleH(30))
                button:SetText("Add")
                button:SetFont("menu_button")
                button:SetTextColor(Color(255,255,255))
                button:TDLib()
                button:ClearPaint()
                    :Background(Color(59, 59, 59), 5)
                    :BarHover(Color(255, 255, 255), 3)
                    :CircleClick()
                button.DoClick = function()
                    if entry:GetValue() == "" then return end

                    t = scroll:Add("DCheckBoxLabel")
                    t:Dock(TOP)
                    t:DockMargin(5,5,5,5)
                    t:SetTall(25)
                    t:SetText(entry:GetValue())
                    t:SetFont("menu_button")
                    t:SetTextColor(Color(255,255,255))
                    t:TDLib()
                    t:ClearPaint()
                        :Background(Color(59, 59, 59), 5)
                        :BarHover(Color(255, 255, 255), 3)
                        :CircleClick()
                    function t:OnChange(val)
                        if val then
                            j[entry:GetValue()] = true
                        else
                            j[entry:GetValue()] = false
                        end
                    end
                end

                finish = pop:Add("DButton")
                finish:SetPos(ScaleW(15), ScaleH(175))
                finish:SetSize(ScaleW(570), ScaleH(20))
                finish:SetText("Finish")
                finish:SetFont("menu_title")
                finish:SetTextColor(Color(255,255,255))
                finish:TDLib()
                finish:ClearPaint()
                    :Background(Color(59, 59, 59), 5)
                    :BarHover(Color(255, 255, 255), 3)
                    :CircleClick()
                finish.DoClick = function()
                    if not sel then return end
                    net.Start("ChatSystem:Net:RankAccess")
                    net.WriteString(sel.name)
                    net.WriteTable(j)
                    net.SendToServer()
                    pop:Remove()
                end

                for k,v in pairs(sel.ranks) do
                    t = scroll:Add("DCheckBoxLabel")
                    t:Dock(TOP)
                    t:DockMargin(5,5,5,5)
                    t:SetTall(25)
                    t:SetText(k)
                    t:SetFont("menu_button")
                    t:SetTextColor(Color(255,255,255))
                    t:TDLib()
                    t:ClearPaint()
                        :Background(Color(59, 59, 59), 5)
                        :BarHover(Color(255, 255, 255), 3)
                        :CircleClick()
                    function t:OnChange(val)
                        if val then
                            j[k] = true
                        else
                            j[k] = false
                        end
                    end

                    if chatsystem.client.data.commands[sel.name].ranks[k] then
                        t:SetChecked(true)
                    end
                end
            end

            job = infop:Add("DButton")
            job:SetPos(ScaleW(15), ScaleH(270))
            job:SetSize(ScaleW(337.5), ScaleH(30))
            job:SetText("Job Access")
            job:SetFont("menu_button")
            job:SetTextColor(Color(255,255,255))
            job:TDLib()
            job:ClearPaint()
                :Background(Color(59, 59, 59), 5)
                :BarHover(Color(255, 255, 255), 3)
                :CircleClick()
            job.DoClick = function()
                if !sel then return end
                local j = {}
                panel:Remove()

                pop = vgui.Create("DFrame")
                pop:SetSize(ScaleW(600), ScaleH(200))
                pop:Center()
                pop:ShowCloseButton(false)
                pop:MakePopup()
                pop:SetTitle("Job Access")
                pop:TDLib()
                pop:ClearPaint()
                    :Background(Color(40,41,40), 6)
                    :CircleHover(Color(59, 59, 59), 5, 20)

                local close = pop:Add("DImageButton")
                close:SetPos(ScaleW(575), ScaleH(15))
                close:SetSize(ScaleW(20), ScaleH(20))
                close:SetImage("icon16/cross.png")
                close:TDLib()
                close.DoClick = function()

                    pop:Remove()
                end

                local scroll = pop:Add("DScrollPanel")
                scroll:SetPos(ScaleW(15), ScaleH(40))
                scroll:SetSize(ScaleW(570), ScaleH(130))
                scroll:TDLib()
                scroll:ClearPaint()
                    :Background(Color(40,41,40), 5)
                    :CircleClick()

                finish = pop:Add("DButton")
                finish:SetPos(ScaleW(15), ScaleH(175))
                finish:SetSize(ScaleW(570), ScaleH(20))
                finish:SetText("Finish")
                finish:SetFont("menu_title")
                finish:SetTextColor(Color(255,255,255))
                finish:TDLib()
                finish:ClearPaint()
                    :Background(Color(59, 59, 59), 5)
                    :BarHover(Color(255, 255, 255), 3)
                    :CircleClick()
                finish.DoClick = function()
                    net.Start("ChatSystem:Net:JobAccess")
                    net.WriteString(sel.name)
                    net.WriteTable(j)
                    net.SendToServer()

                    pop:Remove()
                end

                for k,v in pairs(RPExtraTeams) do
                    t = scroll:Add("DCheckBoxLabel")
                    t:Dock(TOP)
                    t:DockMargin(5,5,5,5)
                    t:SetTall(25)
                    t:SetText(v.name)
                    t:SetFont("menu_button")
                    t:SetTextColor(Color(255,255,255))
                    t:TDLib()
                    t:ClearPaint()
                        :Background(Color(59, 59, 59), 5)
                        :BarHover(Color(255, 255, 255), 3)
                        :CircleClick()
                    function t:OnChange(val)
                        if val then
                            j[v.command] = true
                        else
                            j[v.command] = false
                        end
                    end

                    if chatsystem.client.data.commands[sel.name].jobs[v.command] then
                        t:SetChecked(true)
                    end
                end
            end
            

            remove = infop:Add("DButton")
            remove:SetPos(ScaleW(15), ScaleH(310))
            remove:SetSize(ScaleW(337.5), ScaleH(30))
            remove:SetText("Remove Command")
            remove:SetFont("menu_button")
            remove:SetTextColor(Color(255,255,255))
            remove:TDLib()
            remove:ClearPaint()
                :Background(Color(59, 59, 59), 5)
                :BarHover(Color(255, 255, 255), 3)
                :CircleClick()
            remove.DoClick = function()
                if not sel then return end
                panel:Remove()

                net.Start("ChatSystem:Net:RemoveCommand")
                net.WriteString(sel.name)
                net.SendToServer()
            end

            name = infop:Add("DLabel")
            name:SetPos(ScaleW(15), ScaleH(15))
            name:SetSize(ScaleW(337.5), ScaleH(30))
            name:SetText("Name: ")
            name:SetFont("menu_button")
            name:SetTextColor(Color(255,255,255))

            typ = infop:Add("DLabel")
            typ:SetPos(ScaleW(15), ScaleH(50))
            typ:SetSize(ScaleW(337.5), ScaleH(30))
            typ:SetText("Type: ")
            typ:SetFont("menu_button")
            typ:SetTextColor(Color(255,255,255))

            new = infop:Add("DButton")
            new:SetPos(ScaleW(15), ScaleH(350))
            new:SetSize(ScaleW(337.5), ScaleH(30))
            new:SetText("Add Command")
            new:SetFont("menu_button")
            new:SetTextColor(Color(255,255,255))
            new:TDLib()
            new:ClearPaint()
                :Background(Color(59, 59, 59), 5)
                :BarHover(Color(255, 255, 255), 3)
                :CircleClick()
            new.DoClick = function()
                local things = {}
                local val = ""
                panel:Remove()

                pop = vgui.Create("DFrame")
                pop:SetSize(ScaleW(300), ScaleH(400))
                pop:Center()
                pop:MakePopup()
                pop:ShowCloseButton(false)
                pop:SetTitle("Create a command")
                pop:TDLib()
                pop:ClearPaint()
                    :Background(Color(40,41,40), 6)
                    :CircleHover(Color(59, 59, 59), 5, 20)

                local close = pop:Add("DImageButton")
                close:SetPos(ScaleW(275), ScaleH(10))
                close:SetSize(ScaleW(20), ScaleH(20))
                close:SetImage("icon16/cross.png")
                close:TDLib()
                close.DoClick = function()
                    pop:Remove()
                end

                local t = pop:Add("DComboBox")
                t:SetPos( 5, 30 )
                t:SetSize( 100, 20 )
                t:SetValue( "Command Types" )
                t:AddChoice( "Single Line" )
                t:AddChoice( "Header" )
                t:AddChoice( "Player" )
                t.OnSelect = function( self, index, value )
                    for k,v in pairs(things) do
                        v:Remove()
                    end
                    things = {}
                    PrintTable(things)
                    if value == "Single Line" then
                        val = "single"
                        local cmd = pop:Add("DTextEntry")
                        cmd:SetPos( ScaleW(5), ScaleH(60) )
                        cmd:SetSize( ScaleW(275), ScaleH(20) )
                        cmd:SetText( "Command Ex. !force" )
                        cmd:SetFont("menu_button")
                        cmd:SetTextColor(Color(255,255,255))
                        cmd.Paint = function(self, w, h)
                            draw.RoundedBox( 6, 0, 0, w, h, Color(59,59,59))
                            self:DrawTextEntryText(Color(255, 255, 255), Color(255, 0, 0), Color(255, 255, 255))
                        end
                        table.insert(things, #things, cmd)

                        local color = pop:Add("DTextEntry")
                        color:SetPos( ScaleW(5), ScaleH(90) )
                        color:SetSize( ScaleW(275), ScaleH(20) )
                        color:SetText( "Color Ex. 255,0,0" )
                        color:SetFont("menu_button")
                        color:SetTextColor(Color(255,255,255))
                        color.Paint = function(self, w, h)
                            draw.RoundedBox( 6, 0, 0, w, h, Color(59,59,59))
                            self:DrawTextEntryText(Color(255, 255, 255), Color(255, 0, 0), Color(255, 255, 255))
                        end
                        table.insert(things, #things, color)
        
                    elseif value == "Header" then
                        val = "header" 
                        local cmd = pop:Add("DTextEntry")
                        cmd:SetPos( ScaleW(5), ScaleH(60) )
                        cmd:SetSize( ScaleW(275), ScaleH(20) )
                        cmd:SetText( "Command Ex. !force" )
                        cmd:SetFont("menu_button")
                        cmd:SetTextColor(Color(255,255,255))
                        cmd.Paint = function(self, w, h)
                            draw.RoundedBox( 6, 0, 0, w, h, Color(59,59,59))
                            self:DrawTextEntryText(Color(255, 255, 255), Color(255, 0, 0), Color(255, 255, 255))
                        end
                        table.insert(things, #things, cmd)

                        local color = pop:Add("DTextEntry")
                        color:SetPos( ScaleW(5), ScaleH(90) )
                        color:SetSize( ScaleW(275), ScaleH(20) )
                        color:SetText( "Header Color Ex. 255,0,0" )
                        color:SetFont("menu_button")
                        color:SetTextColor(Color(255,255,255))
                        color.Paint = function(self, w, h)
                            draw.RoundedBox( 6, 0, 0, w, h, Color(59,59,59))
                            self:DrawTextEntryText(Color(255, 255, 255), Color(255, 0, 0), Color(255, 255, 255))
                        end
                        table.insert(things, #things, color)

                        local head = pop:Add("DTextEntry")
                        head:SetPos( ScaleW(5), ScaleH(120) )
                        head:SetSize( ScaleW(275), ScaleH(20) )
                        head:SetText( "Header Ex. [RP]" )
                        head:SetFont("menu_button")
                        head:SetTextColor(Color(255,255,255))
                        head.Paint = function(self, w, h)
                            draw.RoundedBox( 6, 0, 0, w, h, Color(59,59,59))
                            self:DrawTextEntryText(Color(255, 255, 255), Color(255, 0, 0), Color(255, 255, 255))
                        end
                        table.insert(things, #things, head)

                        local color = pop:Add("DTextEntry")
                        color:SetPos( ScaleW(5), ScaleH(150) )
                        color:SetSize( ScaleW(275), ScaleH(20) )
                        color:SetText( "Msg Color Ex. 255,255,255" )
                        color:SetFont("menu_button")
                        color:SetTextColor(Color(255,255,255))
                        color.Paint = function(self, w, h)
                            draw.RoundedBox( 6, 0, 0, w, h, Color(59,59,59))
                            self:DrawTextEntryText(Color(255, 255, 255), Color(255, 0, 0), Color(255, 255, 255))
                        end
                        table.insert(things, #things, color)

                        
                    elseif value == "Player" then
                        val = "player"

                        local cmd = pop:Add("DTextEntry")
                        cmd:SetPos( ScaleW(5), ScaleH(60) )
                        cmd:SetSize( ScaleW(275), ScaleH(20) )
                        cmd:SetText( "Command Ex. !force" )
                        cmd:SetFont("menu_button")
                        cmd:SetTextColor(Color(255,255,255))
                        cmd.Paint = function(self, w, h)
                            draw.RoundedBox( 6, 0, 0, w, h, Color(59,59,59))
                            self:DrawTextEntryText(Color(255, 255, 255), Color(255, 0, 0), Color(255, 255, 255))
                        end
                        table.insert(things, #things, cmd)

                        local color = pop:Add("DTextEntry")
                        color:SetPos( ScaleW(5), ScaleH(90) )
                        color:SetSize( ScaleW(275), ScaleH(20) )
                        color:SetText( "Header Color Ex. 255,0,0" )
                        color:SetFont("menu_button")
                        color:SetTextColor(Color(255,255,255))
                        color.Paint = function(self, w, h)
                            draw.RoundedBox( 6, 0, 0, w, h, Color(59,59,59))
                            self:DrawTextEntryText(Color(255, 255, 255), Color(255, 0, 0), Color(255, 255, 255))
                        end
                        table.insert(things, #things, color)

                        local head = pop:Add("DTextEntry")
                        head:SetPos( ScaleW(5), ScaleH(120) )
                        head:SetSize( ScaleW(275), ScaleH(20) )
                        head:SetText( "Header Ex. [RP]" )
                        head:SetFont("menu_button")
                        head:SetTextColor(Color(255,255,255))
                        head.Paint = function(self, w, h)
                            draw.RoundedBox( 6, 0, 0, w, h, Color(59,59,59))
                            self:DrawTextEntryText(Color(255, 255, 255), Color(255, 0, 0), Color(255, 255, 255))
                        end
                        table.insert(things, #things, head)

                        local color = pop:Add("DTextEntry")
                        color:SetPos( ScaleW(5), ScaleH(150) )
                        color:SetSize( ScaleW(275), ScaleH(20) )
                        color:SetText( "Msg Color Ex. 255,255,255" )
                        color:SetFont("menu_button")
                        color:SetTextColor(Color(255,255,255))
                        color.Paint = function(self, w, h)
                            draw.RoundedBox( 6, 0, 0, w, h, Color(59,59,59))
                            self:DrawTextEntryText(Color(255, 255, 255), Color(255, 0, 0), Color(255, 255, 255))
                        end
                        table.insert(things, #things, color)
                    end
                end


                local add = pop:Add("DButton")
                add:SetPos(ScaleW(15), ScaleH(350))
                add:SetSize(ScaleW(260), ScaleH(30))
                add:SetText("Create Command")
                add:SetFont("menu_button")
                add:SetTextColor(Color(255,255,255))
                add:TDLib()
                add:ClearPaint()
                    :Background(Color(59, 59, 59), 5)
                    :BarHover(Color(255, 255, 255), 3)
                    :CircleClick()
                add.DoClick = function()
                    PrintTable(things)
                    net.Start("ChatSystem:Net:CreateCommand")
                    if val == "single" then
                        net.WriteString("single")
                        net.WriteString(things[1]:GetValue())
                        net.WriteString(things[0]:GetValue())
                    elseif val == "header" then
                        net.WriteString("header")
                        net.WriteString(things[3]:GetValue())
                        net.WriteString(things[2]:GetValue())
                        net.WriteString(things[1]:GetValue())
                        net.WriteString(things[0]:GetValue())
                    elseif val == "player" then
                        net.WriteString("player")
                        net.WriteString(things[3]:GetValue())
                        net.WriteString(things[2]:GetValue())
                        net.WriteString(things[1]:GetValue())
                        net.WriteString(things[0]:GetValue())
                    end
                    net.SendToServer()
                    pop:Remove()
                end
            end

            local elements = {}
            for k,v in pairs(chatsystem.client.data.commands) do
                local t = scroll:Add("DButton")
                t:SetText(v.name)
                t:Dock( TOP )
                t:SetTall( 50 )
                t:DockMargin( 5, 5, 5, 5 )
                t:SetTextColor(Color(255,255,255))
                t:SetFont("menu_button")
                t:TDLib()
                t:ClearPaint()
                    :Background(Color(59, 59, 59), 5)
                    :BarHover(Color(255, 255, 255), 3)
                    :CircleClick()
                t.DoClick = function()
                    for k,v in pairs(elements) do
                        k = nil
                        v:Remove()
                    end

                    sel = v
                    name:SetText("Name: " .. v.name)
                    typ:SetText("Type: " .. v.type)

                    if v.type == "single" then
                        local msg = infop:Add("DLabel")
                        msg:SetPos( ScaleW(15), ScaleH(90) )
                        msg:SetSize( ScaleW(300), ScaleH(20) )
                        msg:SetText( "This is a single line message!" )
                        msg:SetFont("menu_button")
                        msg:SetTextColor(Color(v.color.r, v.color.g, v.color.b))
                        table.insert(elements, #elements, msg)
                    elseif v.type == "header" then
                        local head = infop:Add("DLabel")
                        head:SetPos( ScaleW(15), ScaleH(90) )
                        head:SetSize( ScaleW(300), ScaleH(20) )
                        head:SetText( v.header )
                        head:SetFont("menu_button")
                        head:SetTextColor(Color(v.color.r, v.color.g, v.color.b))
                        table.insert(elements, #elements, head)

                        local msg = infop:Add("DLabel")
                        msg:SetPos( ScaleW(15), ScaleH(120) )
                        msg:SetSize( ScaleW(300), ScaleH(20) )
                        msg:SetText( "This is a header message!" )
                        msg:SetFont("menu_button")
                        msg:SetTextColor(Color(v.color2.r, v.color2.g, v.color2.b))
                        table.insert(elements, #elements, msg)
                    elseif v.type == "player" then
                        local head = infop:Add("DLabel")
                        head:SetPos( ScaleW(15), ScaleH(90) )
                        head:SetSize( ScaleW(300), ScaleH(20) )
                        head:SetText( v.header )
                        head:SetFont("menu_button")
                        head:SetTextColor(Color(v.color.r, v.color.g, v.color.b))
                        table.insert(elements, #elements, head)

                        local msg = infop:Add("DLabel")
                        msg:SetPos( ScaleW(15), ScaleH(120) )
                        msg:SetSize( ScaleW(300), ScaleH(20) )
                        msg:SetText( "CT 2421: This is a player message!" )
                        msg:SetFont("menu_button")
                        msg:SetTextColor(Color(v.color2.r, v.color2.g, v.color2.b))
                        table.insert(elements, #elements, msg)
                    end
                end
            end

            for k,v in pairs(d) do
                table.insert(data, #data, v)
            end
        end
    })
    CreateTab("Config", {
        icon = "icon16/cog.png",
        change = function()
            local d = {}
            local p = nil

            config = panel:Add("DPanel")
            config:SetPos(ScaleW(290), ScaleH(75))
            config:SetSize(ScaleW(660), ScaleH(455))
            config:TDLib()
            config:ClearPaint()
                :Background(Color(59, 59, 59), 6)
                :Text("Addon Configuration", "DermaLarge", Color(255, 255, 255), TEXT_ALIGN_LEFT, ScaleW(210),ScaleH(-202.5))
            table.insert(d, #d, config)

            infop = config:Add("DPanel")
            infop:SetPos(ScaleW(15), ScaleH(50))
            infop:SetSize(ScaleW(630), ScaleH(385))
            infop:TDLib()
            infop:ClearPaint()
                :Background(Color(40,41,40), 5)
                :Text("Information", "DermaLarge", Color(255, 255, 255), TEXT_ALIGN_LEFT, ScaleW(210),ScaleH(-202.5))

            r = infop:Add("DButton")
            r:SetText("Panel Rank Access")
            r:SetSize(ScaleW(600), ScaleH(50))
            r:SetPos(ScaleW(15), ScaleH(30))
            r:SetFont("menu_button")
            r:SetTextColor(Color(255,255,255))
            r:TDLib()
            r:ClearPaint()
                :Background(Color(59, 59, 59), 5)
                :BarHover(Color(255, 255, 255), 3)
                :CircleClick()
            r.DoClick = function()
                local j = {}
                panel:Remove()

                pop = vgui.Create("DFrame")
                pop:SetSize(ScaleW(600), ScaleH(200))
                pop:Center()
                pop:ShowCloseButton(false)
                pop:MakePopup()
                pop:SetTitle("Job Access")
                pop:TDLib()
                pop:ClearPaint()
                    :Background(Color(40,41,40), 6)
                    :CircleHover(Color(59, 59, 59), 5, 20)

                local close = pop:Add("DImageButton")
                close:SetPos(ScaleW(575), ScaleH(15))
                close:SetSize(ScaleW(20), ScaleH(20))
                close:SetImage("icon16/cross.png")
                close:TDLib()
                close.DoClick = function()

                    pop:Remove()
                end

                local scroll = pop:Add("DScrollPanel")
                scroll:SetPos(ScaleW(15), ScaleH(65))
                scroll:SetSize(ScaleW(570), ScaleH(100))
                scroll:TDLib()
                scroll:ClearPaint()
                    :Background(Color(40,41,40), 5)
                    :CircleClick()

                local entry = pop:Add("DTextEntry")
                entry:SetPos(ScaleW(15), ScaleH(30))
                entry:SetSize(ScaleW(500), ScaleH(30))
                entry:SetFont("menu_button")
                entry:SetText("Test")
                entry:SetTextColor(Color(255,255,255))
                entry.Paint = function(self, w, h)
                    draw.RoundedBox( 6, 0, 0, w, h, Color(59, 59, 59))
                    self:DrawTextEntryText(Color(255, 255, 255), Color(255, 0, 0), Color(255, 255, 255))
                end

                local button = pop:Add("DButton")
                button:SetPos(ScaleW(510), ScaleH(30))
                button:SetSize(ScaleW(80), ScaleH(30))
                button:SetText("Add")
                button:SetFont("menu_button")
                button:SetTextColor(Color(255,255,255))
                button:TDLib()
                button:ClearPaint()
                    :Background(Color(59, 59, 59), 5)
                    :BarHover(Color(255, 255, 255), 3)
                    :CircleClick()
                button.DoClick = function()
                    if entry:GetValue() == "" then return end

                    t = scroll:Add("DCheckBoxLabel")
                    t:Dock(TOP)
                    t:DockMargin(5,5,5,5)
                    t:SetTall(25)
                    t:SetText(entry:GetValue())
                    t:SetFont("menu_button")
                    t:SetTextColor(Color(255,255,255))
                    t:TDLib()
                    t:ClearPaint()
                        :Background(Color(59, 59, 59), 5)
                        :BarHover(Color(255, 255, 255), 3)
                        :CircleClick()
                    function t:OnChange(val)
                        if val then
                            j[entry:GetValue()] = true
                        else
                            j[entry:GetValue()] = false
                        end
                    end
                end

                finish = pop:Add("DButton")
                finish:SetPos(ScaleW(15), ScaleH(175))
                finish:SetSize(ScaleW(570), ScaleH(20))
                finish:SetText("Finish")
                finish:SetFont("menu_title")
                finish:SetTextColor(Color(255,255,255))
                finish:TDLib()
                finish:ClearPaint()
                    :Background(Color(59, 59, 59), 5)
                    :BarHover(Color(255, 255, 255), 3)
                    :CircleClick()
                finish.DoClick = function()
                    net.Start("ChatSystem:Net:PanelAccess")
                    net.WriteTable(j)
                    net.SendToServer()

                    pop:Remove()
                end

                for k,v in pairs(chatsystem.client.data.main.ranks) do
                    t = scroll:Add("DCheckBoxLabel")
                    t:Dock(TOP)
                    t:DockMargin(5,5,5,5)
                    t:SetTall(25)
                    t:SetText(k)
                    t:SetFont("menu_button")
                    t:SetTextColor(Color(255,255,255))
                    t:TDLib()
                    t:ClearPaint()
                        :Background(Color(59, 59, 59), 5)
                        :BarHover(Color(255, 255, 255), 3)
                        :CircleClick()
                    function t:OnChange(val)
                        if val then
                            j[k] = true
                        else
                            j[k] = false
                        end
                    end

                    if chatsystem.client.data.main.ranks[k] then
                        t:SetChecked(true)
                    end
                end
            end

            

            for k,v in pairs(d) do
                table.insert(data, #data, v)
            end
        end
    })

    ChangeTab("Commands")
end