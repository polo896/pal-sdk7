-- ================= By Wol4ara896 =================
--          OpenAllChests - Configuration
-- ===================================================

return {
    ChatCommand        = "!chest", -- Chat command
    EnableChatToast    = true,     -- Chat notifications
    IgnoreOpenItem     = true,     -- Ignore keys when opening chests
    Debug              = false,

    -- ================= HOTKEYS =================
    EnableKeybind      = false,    -- Disabled by default
    KeybindKey         = "F7",     -- Activation key
    -- ===========================================

    -- ================= ACTION RADIUS =================
    EnableRadiusFilter = true,     -- true = within radius, false = entire map
    CollectionRadius   = 100000,   -- 100,000 = 1 km
    -- =================================================

    -- ================= INVENTORY CHECK ===============
    -- Stops opening chests as soon as the player's inventory has no free
    -- slot. Re-run !chest to continue with the remaining chests.
    -- Uses a single native call (TryGetEmptySlot) per chest, so it stays
    -- cheap even with thousands of chests on the map.
    EnableInventorySpaceCheck = true,
    -- =================================================

    -- ================= PERFORMANCE ==================
    BatchSize          = 25,       -- Chests per tick
    BatchDelayMs       = 20,       -- Delay (ms)
    -- =================================================
}
