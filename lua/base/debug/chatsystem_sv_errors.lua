chatsystem = chatsystem or {}
chatsystem.server = chatsystem.server or {}
chatsystem.server.db = chatsystem.server.db or {}
chatsystem.server.chat = chatsystem.server.chat or {}
chatsystem.server.net = chatsystem.server.net or {}
chatsystem.server.errors = chatsystem.server.errors or {}

function chatsystem.server.errors.severe(message)
    MsgC(Color(189, 77, 77), "[CHAT SYSTEM SEVERE] ", Color(255, 255, 255), message, "\n")
end
function chatsystem.server.errors.normal(message)
    MsgC(Color(189, 77, 77), "[CHAT SYSTEM] ", Color(255, 255, 255), message, "\n")
end
function chatsystem.server.errors.debug(message)
    MsgC(Color(189, 77, 77), "[CHAT SYSTEM DEBUG] ", Color(255, 255, 255), message, "\n")
end
function chatsystem.server.errors.change(message)
    MsgC(Color(189, 77, 77), "[CHAT SYSTEM CHANGE] ", Color(255, 255, 255), message, "\n")
end