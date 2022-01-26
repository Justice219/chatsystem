--[[
    _________ .__            __      _________               __                  
    \_   ___ \|  |__ _____ _/  |_   /   _____/__.__. _______/  |_  ____   _____  
    /    \  \/|  |  \\__  \\   __\  \_____  <   |  |/  ___/\   __\/ __ \ /     \ 
    \     \___|   Y  \/ __ \|  |    /        \___  |\___ \  |  | \  ___/|  Y Y  \
     \______  /___|  (____  /__|   /_______  / ____/____  > |__|  \___  >__|_|  /
            \/     \/     \/               \/\/         \/            \/      \/ 

    This system is designed to allow gamemasters for multiple gamemodes to create
    simple RP style commands on the fly during events or even just on the server itself.

    This code was created by Justice#4956, but the code is not owned by me. It is owned
    by the respective purchaser of the addon itself.

    By purchasing and using this addon, you agree that you CANNOT remove this header
    or redistribute this code in any way. They must come to me and purchase
    their own individual copy of the addon.

    If you have any questions, please contact me at:
    https://steamcommunity.com/profiles/76561198271872638/home/
    or
    Justice#4956 on Discord.

]]--

if SERVER then
    AddCSLuaFile("base/net/chatsystem_cl_net.lua")   
    AddCSLuaFile("base/ui/chatsystem_ui_main.lua") 

    include("base/debug/chatsystem_sv_errors.lua")
    include("base/database/chatsystem_sv_db.lua")
    include("base/chat/chatsystem_sv_chat.lua")
    include("base/net/chatsystem_sv_net.lua")
end
if CLIENT then
    include("base/net/chatsystem_cl_net.lua")
    include("base/ui/chatsystem_ui_main.lua")
end