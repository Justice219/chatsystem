chatsystem = chatsystem or {}
chatsystem.server = chatsystem.server or {}
chatsystem.server.db = chatsystem.server.db or {}
chatsystem.server.chat = chatsystem.server.chat or {}
chatsystem.server.net = chatsystem.server.net or {}
chatsystem.server.errors = chatsystem.server.errors or {}

chatsystem.server.data = chatsystem.server.data or {}
chatsystem.server.data.commands = chatsystem.server.data.commands or {}

treasury.server.db.create("chatsystem_commands", {
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
            msg = data.msg,
            color = data.color,
        }
    elseif data.type == "normal" then
        tb[name] = {
            name = name,
            type = "normal",
            header = data.header,
            msg = data.msg,
            color = data.color,
            color2 = data.color2,
        }
    elseif data.type == "player" then
        tb[name] = {
            name = name,
            type = "player",
            header = data.header,
            msg = data.msg,
            color = data.color,
            color2 = data.color2,
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
        tbl[name] = {}

        -- Single is litterally just a one line command
        -- Normal is a command with a header and a msg
        -- Player is a command that shows the players name, header and msg
        local t = chatsystem.server.chat.format(name, data, tbl)

        chatsystem.server.data.commands = t
        chatsystem.server.db.updateAll("chatsystem_commands", "commands_tbl", util.TableToJSON(tbl))
        chatsystem.server.errors.change("Command " .. name .. " created!")
    else
        local t = chatsystem.server.chat.format(name, data)

        chatsystem.server.data.commands = t
        chatsystem.server.db.updateAll("chatsystem_commands", "commands_tbl", util.TableToJSON(tbl))
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