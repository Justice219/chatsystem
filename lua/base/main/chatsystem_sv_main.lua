chatsystem = chatsystem or {}
chatsystem.server = chatsystem.server or {}
chatsystem.server.db = chatsystem.server.db or {}
chatsystem.server.chat = chatsystem.server.chat or {}
chatsystem.server.net = chatsystem.server.net or {}
chatsystem.server.errors = chatsystem.server.errors or {}
chatsystem.server.main = chatsystem.server.main or {}

chatsystem.server.data = chatsystem.server.data or {}
chatsystem.server.data.main = chatsystem.server.data.main or {}

chatsystem.server.db.create("chatsystem", {
    [1] = {
        name = "config_tbl",
        type = "TEXT",
    }
})

function chatsystem.server.main.addRank(rank)
    if chatsystem.server.data.main.ranks[rank] then
        chatsystem.server.errors.severe("Rank: " .. rank .. "already exists")   
    return end

    local val = chatsystem.server.db.loadAll("chatsystem", "config_tbl")
    if val then
        local tbl = util.JSONToTable(val)
        tbl.ranks[rank] = true
        
        chatsystem.server.data.main.ranks[rank] = true
        chatsystem.server.db.updateAll("chatsystem", "config_tbl", util.TableToJSON(tbl))
        chatsystem.server.errors.change("Rank: " .. rank .. " added")
    else
        local tbl = {}
        tbl.ranks = {}
        tbl.ranks[rank] = true

        chatsystem.server.data.main.ranks[rank] = true
        chatsystem.server.db.updateAll("chatsystem", "config_tbl", util.TableToJSON(tbl))
        chatsystem.server.errors.change("Rank: " .. rank .. " added")
    end
end
function chatsystem.server.main.removeRank(rank)
    if !chatsystem.server.data.main.ranks[rank] then
        chatsystem.server.errors.severe("Rank: " .. rank .. "does not exist")
    return end

    local val = chatsystem.server.db.loadAll("chatsystem", "config_tbl")
    if val then
        local tbl = util.JSONToTable(val)
        tbl.ranks[rank] = nil

        chatsystem.server.data.main.ranks[rank] = nil
        chatsystem.server.db.updateAll("chatsystem", "config_tbl", util.TableToJSON(tbl))
        chatsystem.server.errors.change("Rank: " .. rank .. " removed")
    else
        chatsystem.server.errors.severe("There is no config table")
    end
end
function chatsystem.server.main.load()
    local val = chatsystem.server.db.loadAll("chatsystem", "config_tbl")
    if val then
        chatsystem.server.data.main = util.JSONToTable(val)
    else
        chatsystem.server.data.main = {}
        chatsystem.server.data.main.ranks = {}
        chatsystem.server.errors.severe("No config table found, save some data first")
    end
end

chatsystem.server.main.load()