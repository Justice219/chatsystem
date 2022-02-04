chatsystem = chatsystem or {}
chatsystem.client = chatsystem.client or {}
chatsystem.client.menus = chatsystem.client.menus or {}
chatsystem.client.data = chatsystem.client.data or {}

net.Receive("ChatSystem:Net:Command", function(len, ply)
    d = net.ReadTable()
    msg = net.ReadString()

    if d.type == "single" then
        chat.AddText(Color(d.color.r, d.color.g, d.color.b), msg)
    elseif d.type == "header" then
        chat.AddText(Color(d.color.r, d.color.g, d.color.b), d.header, " ", Color(d.color2.r, d.color2.g, d.color2.b), msg)
    elseif d.type == "player" then
        local p = net.ReadString()
        chat.AddText(Color(d.color.r, d.color.g, d.color.b), d.header, " ", p, ": ", Color(d.color2.r, d.color2.g, d.color2.b), msg)
    end
end)
net.Receive("ChatSystem:Net:Menus:Main", function(len, ply)
    chatsystem.client.data.commands = net.ReadTable()
    chatsystem.client.data.main = net.ReadTable() 

    chatsystem.client.menus.main()
end)