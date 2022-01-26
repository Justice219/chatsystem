chatsystem = chatsystem or {}
chatsystem.server = chatsystem.server or {}
chatsystem.server.db = chatsystem.server.db or {}
chatsystem.server.chat = chatsystem.server.chat or {}
chatsystem.server.net = chatsystem.server.net or {}
chatsystem.server.errors = chatsystem.server.errors or {}

function chatsystem.server.db.query(query)
    chatsystem.server.errors.debug("Query: " .. query)
    sql.Query(query)
end

function chatsystem.server.db.create(name, values)
    local str = ""
    local i = 0
    local max = table.maxn(values)
    for k,v in pairs(values) do
        -- the string needs to look something like id NUMBER, name TEXT
        i = i + 1
        if i == max then 
            str = str .. v.name .. " " .. v.type
        else
            str = str .. v.name .. " " .. v.type .. ", "
        end
    end

    sql.Query("CREATE TABLE IF NOT EXISTS " .. name .. " ( " .. str .. " )")
    chatsystem.server.errors.change("Created new DB table: " .. name)
    if !sql.LastError() then return end
    chatsystem.server.errors.change("Printing last SQL Error for debugging purposes, ")
    print(sql.LastError())
end

function chatsystem.server.db.remove(name)
    sql.Query("DROP TABLE " .. name)

    chatsystem.server.errors.change("Removed DB table: " .. name)
    if !sql.LastError() then return end
    chatsystem.server.errors.change("Printing last SQL Error for debugging purposes, ")
end

function chatsystem.server.db.updateSpecific(name, row, method, value, key)
    local data = sql.Query("SELECT " .. row .. " FROM " .. name .. " WHERE " .. method .. " = " ..sql.SQLStr(key).. ";")
    if (data) then
        sql.Query("UPDATE " .. name .. " SET " .. row .. " = " .. sql.SQLStr(value) .. " WHERE " .. method .. " = " ..sql.SQLStr(key).. ";")
    else
        sql.Query("INSERT INTO " .. name .. " ( "..method..", "..row.." ) VALUES( "..sql.SQLStr(key)..", "..sql.SQLStr(value).." );")
    end
end

function chatsystem.server.db.updateAll(name, row, value)
    chatsystem.server.errors.change("Updating all entries in DB table: " .. name)
    value = sql.SQLStr(value)
    local data = sql.Query("SELECT * FROM " .. name .. ";")
    if (data) then
        sql.Query("UPDATE " .. name .. " SET " .. row .. " = " .. value .. ";")
    else
        sql.Query("INSERT INTO " .. name .. " ( "..row.." ) VALUES( "..value.." )") 
    end
end

function chatsystem.server.db.load(name, method)
    local val = sql.QueryValue("SELECT * FROM " .. name .. " WHERE " .. method .. " = " .. sql.SQLStr(method) .. ";")
    if !val then
        chatsystem.server.errors.severe("Could not load data from DB table: " .. name .. " with method: " .. method)    
        return false
    else
        return val
    end
end

function chatsystem.server.db.loadSpecific(name, row, method, key)
    local val = sql.QueryValue("SELECT " .. row .. " FROM " .. name .. " WHERE " .. method .. " = " .. sql.SQLStr(key) .. ";")
    if !val then
        chatsystem.server.errors.severe("Could not load data from DB table: " .. name .. " with method: " .. method)    
        return false
    else
        return val
    end
end

function chatsystem.server.db.loadAll(name, row)
    local val = sql.QueryValue("SELECT "..row.." FROM " .. name .. ";")
    if !val then
        chatsystem.server.errors.severe("Could not load data from DB table: " .. name)    
        return false
    else
        return val
    end
end