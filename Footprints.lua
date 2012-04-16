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
local F = Footsteps.Footprints  -- Localize module table for easy access
local REMEMBERED = 5            -- TODO: Store in db
local FREQ = 5                  -- TODO: Store in db

-------------------------------------------------------------------------------------
-- Initiallize()            Initiallizes footprints module
-- Arguments                nil
-- Returns                  nil
-------------------------------------------------------------------------------------
function F:Initiallize()
    F.Freq = FREQ                   -- Number of seconds between footprint drops
    F.Remembered = REMEMBERED       -- Number of footprints the addon will remember
    F.Coords = {}                   -- Array to hold footprints
    F.Frames = {}                   -- Array to hold texture for footprints
    F.Timer = F.Freq     	        -- Timer for footprint drop
end
F:Initiallize() -- TODO: Move to central location
    
-------------------------------------------------------------------------------------
-- Coords Queue-Array
-------------------------------------------------------------------------------------
F.Coords.Size = 0          -- Size of Queue
F.Coords.First = 1         -- Index of first item in Queue
F.Coords.Last = 0          -- Index of last item in Queue
function F.Coords:Push(value)
    self.Last = self.Last + 1
    self[self.Last] = value
    self.Size = self.Size+1
end
function F.Coords:Pop()
    local first = self.First
    if first > self.Last then error("Coordinate queue empty") end
    local value = self[first]
    self[first] = nil
    self.First = first + 1
    self.Size = self.Size-1
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
    
    -- If the timer value less than the frequency, it's not time to print yet
    if F.Timer < F.Freq then return end
    
    -- Reset timer
    F.Timer = 0
    
    -- Create coordinate object
    local coord = {}
    coord.zone = GetZoneText()
    coord.x, coord.y = GetPlayerMapPosition("player")
    F.Coords:Push(coord)
    
    -- Remove old coordinate object if necessary
    if F.Coords.Size > F.Remembered then F.Coords:Pop() end
    
    -- TODO: Remove
    -- Print the current coordinates to the chat window
    DEFAULT_CHAT_FRAME:AddMessage("Coord List:")
    for i = F.Coords.First, F.Coords.Last do
        coord = F.Coords[i]
        DEFAULT_CHAT_FRAME:AddMessage(
            format("( %s ) %d,%d", coord.zone,coord.x*100,coord.y*100))
    end

end
Footsteps.Listener:SetScript("OnUpdate", F.DropFootprints)  -- TODO: Move to central location