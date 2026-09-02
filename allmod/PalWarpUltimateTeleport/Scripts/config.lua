-- =============================================================================
-- PalWarpMod Configuration File
-- =============================================================================

local config = {
    -- Chat command settings
    ChatPrefix          = "!",                  -- Command prefix (e.g. !set, !warp, !home)
    
    -- Hotkeys & Modifiers ("SHIFT", "ALT", "CTRL", "NONE")
    ModSave             = "SHIFT",              -- Modifier for saving points (Shift + 1..3)
    ModWarp             = "ALT",                -- Modifier for warping (Alt + 1..3)
    BindNumpad          = true,                 -- Also bind NumPad 1..3 for hotkeys (true / false)
    
    -- Map Click Teleport
    MapTpKey            = "LEFT_MOUSE_BUTTON",  -- Mouse button to click on the map
    MapTpModifier       = "ALT",                -- Modifier key while clicking map ("ALT", "SHIFT", "CTRL", "NONE")
    MapTpCloseMap       = true,                 -- Automatically close map on teleport (true / false)
    
    -- Waypoint Limits
    MaxSlot             = 50,                   -- Maximum numbered slots available (1 to MaxSlot)
    
    -- Teleportation Engine & Safety
    DirectRange         = 9000.0,               -- Distance threshold for instant TP without staging height
    StagingZ            = 100000.0,             -- Safe height in air while waiting for terrain to load
    TraceTop            = 200000.0,             -- Raycast start height for ground detection
    TraceBottom         = -200000.0,            -- Raycast end height
    SurfaceOffset       = 150.0,                -- Height offset above traced ground (prevents getting stuck)
    
    -- Terrain Streaming Timings (in milliseconds)
    StreamingPollMs     = 100,                  -- How often to check if terrain is loaded
    StreamingMinMs      = 250,                  -- Minimum delay to wait for streaming
    StreamingMaxMs      = 6000,                 -- Maximum wait timeout before landing
    CooldownMs          = 500,                  -- Debounce delay between warps (prevents double clicks)
    
    -- Feedback & Notifications
    ChatFeedback        = true,                 -- Show status messages in local chat
    AnnounceFeedback    = false,                -- Show large on-screen game banner announcement
    Debug               = false,                -- Print debug traces to UE4SS console/log
    
    -- Advanced / Calibration
    MapConvScaleX       = 459.0,                -- Fallback cursor calibration X
    MapConvScaleY       = 459.0,                -- Fallback cursor calibration Y
    MapConvOffX         = -123509.0,            -- Fallback cursor offset X
    MapConvOffY         = 159622.0,             -- Fallback cursor offset Y
    DataFile            = "",                   -- Explicit points file path (empty = default auto-detect)
}

return config