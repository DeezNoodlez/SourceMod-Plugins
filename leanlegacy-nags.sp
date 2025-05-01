#pragma semicolon 1
#pragma newdecls required

#include <sourcemod>
// #include <morecolors>

#define DISCORD_TIMER g_cvarDiscordTimer.FloatValue
#define RTV_TIMER g_cvarRtvTimer.FloatValue

public Plugin myinfo = {
    name        = "LeanLegacy Nags",
    author      = "DeezNoodlez",
    description = "Reminds discord invite and rtv in chat periodically. Made from VIORA's Uncletopia Nags",
    version     = "0.1.0",
    url         = "https://github.com/DeezNoodlez/SourceMod-Plugins/leanlegacy-nags"
};

ConVar g_cvarDiscordTimer;
ConVar g_cvarRtvTimer;
Handle g_DiscordTimer;
Hangle g_RtvTimer;

public void OnPluginStart() {
    g_cvarDiscordTimer = CreateConVar(
        "ll_discord_nag_timer",
        "600.0", // 10 mins
        "How long between discord nags (seconds)"
    );
    
    g_cvarRtvTimer = CreateConVar(
        "ll_rtv_nag_timer",
        "900.0", // 15 mins
        "How long between rtv nags (seconds)"
    );
}

public void OnMapStart() {
    CleanupTimer(g_DiscordTimer);
    CleanupTimer(g_RtvTimer);

    g_DiscordTimer = CreateTimer(DISCORD_TIMER, DiscordNag);
    g_RtvTimer = CreateTimer(RTV_TIMER, RtvNag);
}

public Action DiscordNag(Handle timer) {
    MC_PrintToChatAll(
        "Join the community discord at https://discord.gg/d4hBPpd9mJ"
    );
    CleanupTimer(g_DiscordTimer);
    g_DiscordTimer = CreateTimer(DISCORD_TIMER, DiscordNag);
    return Plugin_Stop;
}

public Action RtvNag(Handle timer) {
    MC_PrintToChatAll(
        "If you dont want to play this map, type !rtv in chat to vote to change the map."
    );
    CleanupTimer(g_RtvTimer);
    g_RtvTimer = CreateTimer(RTV_TIMER, RtvNag);
    return Plugin_Stop;
}

void CleanupTimer(Handle &timer) {
    if (timer != null) {
        KillTimer(timer);
        timer = null;
    }
}