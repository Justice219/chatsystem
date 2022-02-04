chatsystem = chatsystem or {}
chatsystem.server = chatsystem.server or {}
chatsystem.server.db = chatsystem.server.db or {}
chatsystem.server.chat = chatsystem.server.chat or {}
chatsystem.server.net = chatsystem.server.net or {}
chatsystem.server.errors = chatsystem.server.errors or {}

chatsystem.server.data = chatsystem.server.data or {}
chatsystem.server.data.commands = chatsystem.server.data.commands or {}
chatsystem.server.data.main = chatsystem.server.data.main or {}

chatsystem.server.db.create("chatsystem_commands", {
    [1] = {
        name = "commands_tbl",
        type = "TEXT",
    }
})

function chatsystem.server.chat.format(name, data, tbl)
    tb = tbl or {}
    if data.type == "single" then
        tb[name] = {
            name = name,
            type = "single",
            color = data.color,
            jobs = {},
            ranks = {},
        }
    elseif data.type == "header" then
        tb[name] = {
            name = name,
            type = "header",
            header = data.header,
            color = data.color,
            color2 = data.color2,
            jobs = {},
            ranks = {},
        }
    elseif data.type == "player" then
        tb[name] = {
            name = name,
            type = "player",
            header = data.header,
            color = data.color,
            color2 = data.color2,
            jobs = {},
            ranks = {},
        }
    end
    return tb
end

function chatsystem.server.chat.create(name,data)
    if chatsystem.server.data.commands[name] then
        chatsystem.server.errors.severe("Command " .. name .. " already exists!")
    end

    local val = chatsystem.server.db.loadAll("chatsystem_commands", "commands_tbl")
    if val then
        local tbl = util.JSONToTable(val)

        -- Single is litterally just a one line command
        -- Normal is a command with a header and a msg
        -- Player is a command that shows the players name, header and msg
        local t = chatsystem.server.chat.format(name, data, tbl)

        chatsystem.server.data.commands = t
        chatsystem.server.db.updateAll("chatsystem_commands", "commands_tbl", util.TableToJSON(t))
        chatsystem.server.errors.change("Command " .. name .. " created!")
    else
        local t = chatsystem.server.chat.format(name, data)

        chatsystem.server.data.commands = t
        chatsystem.server.db.updateAll("chatsystem_commands", "commands_tbl", util.TableToJSON(t))
        chatsystem.server.errors.change("Created command " .. name)
    end
end
function chatsystem.server.chat.remove(name)
    if !chatsystem.server.data.commands[name] then
        chatsystem.server.errors.severe("Command " .. name .. " does not exist!")
    end

    local val = chatsystem.server.db.loadAll("chatsystem_commands", "commands_tbl")
    if val then
        local tbl = util.JSONToTable(val)
        tbl[name] = nil

        chatsystem.server.data.commands[name] = nil
        chatsystem.server.db.updateAll("chatsystem_commands", "commands_tbl", util.TableToJSON(tbl))
        chatsystem.server.errors.change("Command " .. name .. " has been removed!")
    else
        chatsystem.server.errors.severe("Data for this command litterally doesnt exist. THIS SHOULDNT HAPPEN!")
    end
end
function chatsystem.server.chat.addJob(name, job)
    if !chatsystem.server.data.commands[name] then
        chatsystem.server.errors.severe("Command " .. name .. " does not exist!")
    end

    local val = chatsystem.server.db.loadAll("chatsystem_commands", "commands_tbl")
    if val then
        local tbl = util.JSONToTable(val)
        tbl[name].jobs[job] = true

        chatsystem.server.data.commands[name].jobs[job] = true
        chatsystem.server.db.updateAll("chatsystem_commands", "commands_tbl", util.TableToJSON(tbl))
        chatsystem.server.errors.change("Command " .. job .. " has been added to the job list!")
    else
        chatsystem.server.errors.severe("Data for this command litterally doesnt exist. THIS SHOULDNT HAPPEN!")
    end
end
function chatsystem.server.chat.removeJob(name, job)
    if !chatsystem.server.data.commands[name] then
        chatsystem.server.errors.severe("Command " .. name .. " does not exist!")
    end

    local val = chatsystem.server.db.loadAll("chatsystem_commands", "commands_tbl")
    if val then
        local tbl = util.JSONToTable(val)
        tbl.jobs = tbl.jobs or {}
        tbl.jobs[job] = nil

        chatsystem.server.data.commands[name].jobs[job] = nil
        chatsystem.server.db.updateAll("chatsystem_commands", "commands_tbl", util.TableToJSON(tbl))
        chatsystem.server.errors.change("Command " .. name .. " has been added to the job list!")
    else
        chatsystem.server.errors.severe("Data for this command litterally doesnt exist. THIS SHOULDNT HAPPEN!")
    end
end
function chatsystem.server.chat.addRank(name, rank)
    if !chatsystem.server.data.commands[name] then
        chatsystem.server.errors.severe("Command " .. name .. " does not exist!")
    end

    local val = chatsystem.server.db.loadAll("chatsystem_commands", "commands_tbl")
    if val then
        local tbl = util.JSONToTable(val)
        tbl[name].ranks[rank] = true

        chatsystem.server.data.commands[name].ranks[rank] = true
        chatsystem.server.db.updateAll("chatsystem_commands", "commands_tbl", util.TableToJSON(tbl))
        chatsystem.server.errors.change("Command " .. rank .. " has been added to the job list!")
    else
        chatsystem.server.errors.severe("Data for this command litterally doesnt exist. THIS SHOULDNT HAPPEN!")
    end
end
function chatsystem.server.chat.removeRank(name, rank)
    if !chatsystem.server.data.commands[name] then
        chatsystem.server.errors.severe("Command " .. name .. " does not exist!")
    end

    local val = chatsystem.server.db.loadAll("chatsystem_commands", "commands_tbl")
    if val then
        local tbl = util.JSONToTable(val)
        tbl[name].ranks[rank] = nil 

        chatsystem.server.data.commands[name].ranks[rank] = nil
        chatsystem.server.db.updateAll("chatsystem_commands", "commands_tbl", util.TableToJSON(tbl))
        chatsystem.server.errors.change("Command " .. rank .. " has been added to the job list!")
    else
        chatsystem.server.errors.severe("Data for this command litterally doesnt exist. THIS SHOULDNT HAPPEN!")
    end
end
function chatsystem.server.chat.load()
    local val = chatsystem.server.db.loadAll("chatsystem_commands", "commands_tbl")
    if val then
        local tbl = util.JSONToTable(val)
        chatsystem.server.data.commands = tbl
    else
        chatsystem.server.errors.severe("Data for this command litterally doesnt exist. THIS SHOULDNT HAPPEN!")
    end
end

hook.Add("PlayerSay", "ChatSystemCommands", function(ply, text)
    local str = string.Explode(" ", text)
    if !chatsystem.server.data.commands[str[1]] then return end

    -- Lets check if the player has access to this command
    local t = RPExtraTeams[ply:Team()].command
    local j = chatsystem.server.data.commands[str[1]].jobs

    local r = chatsystem.server.data.commands[str[1]].ranks
    local ur = ply:GetUserGroup()

    if ply:GetUserGroup() == "superadmin" or j[t] or r[ur] then
        local fix = ""
        for k,v in pairs(str) do
            if k == 1 then continue end
            fix = fix .. " " .. v
        end
    
        net.Start("ChatSystem:Net:Command")
        net.WriteTable(chatsystem.server.data.commands[str[1]])
        net.WriteString(fix)
        net.WriteString(ply:Nick())
        net.Broadcast()
    
        return "" 
    else

        PrintMessage(HUD_PRINTTALK, "You do not have access to this command!")
        return ""
    end
end)

hook.Add("PlayerSay", "ChatSystemMenus", function(ply, text)
    local r = chatsystem.server.data.main.ranks
    local pr = ply:GetUserGroup()

    if ply:GetUserGroup() == "superadmin" or r[pr] then
        if text == "!chatsystem" then
            net.Start("ChatSystem:Net:Menus:Main")
            if chatsystem.server.data.commands then
                net.WriteTable(chatsystem.server.data.commands)
            else
                net.WriteTable({})
            end
            if chatsystem.server.data.main then
                net.WriteTable(chatsystem.server.data.main)
            else
                net.WriteTable({})
            end
            net.Send(ply)
        end
    end
end)

chatsystem.server.chat.load()