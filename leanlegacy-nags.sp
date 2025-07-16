#pragma semicolon 1
#pragma newdecls required

#include <sourcemod>
#include <morecolors>

#define DISCORD_TIMER g_cvarDiscordTimer.FloatValue
#define RTV_TIMER g_cvarRtvTimer.FloatValue
#define SCRAMBLE_TIMER g_cvarScrambleTimer.FloatValue

public Plugin myinfo = {
    name        = "LeanLegacy Nags",
    author      = "DeezNoodlez",
    description = "Reminds discord invite and rtv in chat periodically. Made from VIORA's Uncletopia Nags",
    version     = "0.1.2",
};

ConVar g_cvarDiscordTimer;
ConVar g_cvarRtvTimer;
ConVar g_cvarScrambleTimer;
Handle g_DiscordTimer;
Handle g_RtvTimer;
Handle g_ScrambleTimer;

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

    g_cvarScrambleTimer = CreateConVar(
        "ll_scramble_nag_timer",
        "480.0", // 8 mins
        "How long between scramble nags (seconds)"
    );
}

public void OnMapStart() {
    CleanupTimer(g_DiscordTimer);
    CleanupTimer(g_RtvTimer);
    CleanupTimer(g_ScrambleTimer);

    g_DiscordTimer = CreateTimer(DISCORD_TIMER, DiscordNag);
    g_RtvTimer = CreateTimer(RTV_TIMER, RtvNag);
    g_ScrambleTimer = CreateTimer(SCRAMBLE_TIMER, ScrambleNag);
}

public Action DiscordNag(Handle timer) {
    MC_PrintToChatAll(
        "Join the community discord at {green}discord.gg/le4nlegacy{default}"
    );
    CleanupTimer(g_DiscordTimer);
    g_DiscordTimer = CreateTimer(DISCORD_TIMER, DiscordNag);
    return Plugin_Stop;
}

public Action RtvNag(Handle timer) {
    MC_PrintToChatAll(
        "If you don't want to play this map, type {green}!rtv{default} in chat to vote to change the map."
    );
    CleanupTimer(g_RtvTimer);
    g_RtvTimer = CreateTimer(RTV_TIMER, RtvNag);
    return Plugin_Stop;
}

public Action ScrambleNag(Handle timer) {
    MC_PrintToChatAll(
        "If you want to scramble teams, type {green}!scramble{default}, {green}scramble{default}, or {green}scrimblo{default}."
    );
    CleanupTimer(g_ScrambleTimer);
    g_ScrambleTimer = CreateTimer(SCRAMBLE_TIMER, ScrambleNag);
    return Plugin_Stop;
}

void CleanupTimer(Handle &timer) {
    if (timer != null) {
        KillTimer(timer);
        timer = null;
    }
}