-------------------------------------------------------------------------------------
-- Footprints.lua   Footprints module tracks where you've been
-- Project          Footsteps - an addon that tracks where you're going and 
--                  where you've been.
-- Authors          Jiyambi, Taellis, Phaedra
-- Version          0.1
-- Licesnse         Creative Commons Attribution-NonCommercial-NoDerivs 3.0 
--                  Unported License
-------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------
-- Initialization 
-------------------------------------------------------------------------------------
Footsteps.Footprints = {}       -- Table for holding footprint related values 
local F = Footsteps.Footprints  -- Localize this section for easy access
F.Rate = 5                      -- Number of seconds between footprint drops
F.Remembered = 5                -- Number of footprints the addon will remember
F.Coords = {}                   -- Array to hold footprints
F.Frames = {}                   -- Array to hold texture for footprints
F.Timer = F.Rate 	            -- Timer for footprint drop
    
-------------------------------------------------------------------------------------
-- Coords Queue-Array
-------------------------------------------------------------------------------------
local C = F.Coords  -- Localize Coords for easy access
C.Size = 0          -- Size of Queue
C.First = 1         -- Index of first item in Queue
C.Last = 0          -- Index of last item in Queue
function C:Push(value)
    local last = C.Last
    C.Last = last + 1
    C[last] = value
end
function C:Pop()
    local first = C.First
    if first > C.Last then error("Coordinate queue empty") end
    local value = C[first]
    C[first] = nil
    C.First = first + 1
    return value
end

-------------------------------------------------------------------------------------
-- DrawFootprints()         Adds a footprint to the array and bumps old ones out
-- Arguments                elapsed - time since last called
-- Returns                  nil
-------------------------------------------------------------------------------------
function F:DropFootprints(elapsed)
    -- Add the timesince last update to the timer
    F.Timer = F.Timer + elapsed	
    
    -- If the timer value is greater than our rate, it's time to print.
    if F.Timer >= F.Rate then
        -- Reset timer
        F.Timer = 0
        
        -- Create coordinate object
        local coord = {}
        coord.zone = GetZoneText()
        coord.x, coord.y = GetPlayerMapPosition("player")
        F.Coords.Push(coord)
        
        -- Remove old coordinate object if necessary
        if F.Coords.Size > F.Remembered then F.Coords.Pop() end
        
        -- TODO: Remove
        -- Print the current coordinates to the chat window
        DEFAULT_CHAT_FRAME:AddMessage(format("( %s ) %d,%d", coord.zone,coord.x*100,coord.y*100))
    end
end
Footsteps.Listener:SetScript("OnUpdate", F.DropFootprints)