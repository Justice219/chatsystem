chatsystem = chatsystem or {}
chatsystem.server = chatsystem.server or {}
chatsystem.server.db = chatsystem.server.db or {}
chatsystem.server.chat = chatsystem.server.chat or {}
chatsystem.server.net = chatsystem.server.net or {}
chatsystem.server.errors = chatsystem.server.errors or {}
chatsystem.server.main = chatsystem.server.main or {}

util.AddNetworkString("ChatSystem:Net:Command")
util.AddNetworkString("ChatSystem:Net:Menus:Main")
util.AddNetworkString("ChatSystem:Net:CreateCommand")
util.AddNetworkString("ChatSystem:Net:RemoveCommand")
util.AddNetworkString("ChatSystem:Net:JobAccess")
util.AddNetworkString("ChatSystem:Net:RankAccess")
util.AddNetworkString("ChatSystem:Net:PanelAccess")

net.Receive("ChatSystem:Net:CreateCommand", function(len, ply)
    local r = chatsystem.server.data.main.ranks
    local pr = ply:GetUserGroup()

    if ply:GetUserGroup() == "superadmin" or r[pr] then
        local t = net.ReadString()
        local cmd = net.ReadString()
        print(t,cmd)
        if t == "single" then
            local col = string.Explode(",", net.ReadString())
            chatsystem.server.chat.create(cmd, {
                type = "single",
                color = Color(col[1], col[2], col[3]),
            })
        elseif t == "header" then
            local col2 = string.Explode(",", net.ReadString())
            local head = net.ReadString()
            local col = string.Explode(",", net.ReadString())
            chatsystem.server.chat.create(cmd, {
                type = "header",
                header = head,
                color = Color(col[1], col[2], col[3]),
                color2 = Color(col2[1], col2[2], col2[3]),
            })
        elseif t == "player" then
            local col2 = string.Explode(",", net.ReadString())
            local head = net.ReadString()
            local col = string.Explode(",", net.ReadString())
            chatsystem.server.chat.create(cmd, {
                type = "player",
                header = head,
                color = Color(col[1], col[2], col[3]),
                color2 = Color(col2[1], col2[2], col2[3]),
            })
        end 
    end
end)
net.Receive("ChatSystem:Net:RemoveCommand", function(len, ply)
    local r = chatsystem.server.data.main.ranks
    local pr = ply:GetUserGroup()

    if ply:GetUserGroup() == "superadmin" or r[pr] then
        chatsystem.server.chat.remove(net.ReadString())
    end
end)
net.Receive("ChatSystem:Net:JobAccess", function(len, ply)
    local r = chatsystem.server.data.main.ranks
    local pr = ply:GetUserGroup()
        if ply:GetUserGroup() == "superadmin" or r[pr] then

        local name = net.ReadString()
        chatsystem.server.errors.debug("name " .. name)
        local job = net.ReadTable()

        for k,v in pairs(job) do
            if v == true then
                chatsystem.server.chat.addJob(name, k)
            else
                chatsystem.server.chat.removeJob(name, k)
            end
        end
    end
end)
net.Receive("ChatSystem:Net:RankAccess", function(len, ply)
    local r = chatsystem.server.data.main.ranks
    local pr = ply:GetUserGroup()

    if ply:GetUserGroup() == "superadmin" or r[pr] then
        local name = net.ReadString()
        chatsystem.server.errors.debug("name " .. name)
        local job = net.ReadTable()

        for k,v in pairs(job) do
            if v == true then
                chatsystem.server.chat.addRank(name, k)
            else
                chatsystem.server.chat.removeRank(name, k)
            end
        end
    end
end)
net.Receive("ChatSystem:Net:PanelAccess", function(len, ply)
    local r = chatsystem.server.data.main.ranks
    local pr = ply:GetUserGroup()

    if ply:GetUserGroup() == "superadmin" or r[pr] then
        local rank= net.ReadTable()
        PrintTable(rank)

        for k,v in pairs(rank) do
            if v == true then
                chatsystem.server.main.addRank(k)
            else
                chatsystem.server.main.removeRank(k)
            end
        end
    end
end)

--[[    if data.type == "single" then
    tb[name] = {
        name = name,
        type = "single",
        color = data.color,
    }
elseif data.type == "normal" then
    tb[name] = {
        name = name,
        type = "normal",
        header = data.header,
        color = data.color,
        color2 = data.color2,
    }
elseif data.type == "player" then
    tb[name] = {
        name = name,
        type = "player",
        header = data.header,
        color = data.color,
        color2 = data.color2,
    }
end]]