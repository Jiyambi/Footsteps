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
local A = Footsteps             -- Localize reference to addon table for easy access
local M = A.Footprints          -- Localize reference to module table for easy access
local REMEMBERED = 5            -- TODO: Store in db
local FREQ = 5                  -- TODO: Store in db
local SIZE = 5

-------------------------------------------------------------------------------------
-- Initiallize()            Initiallizes footprints module
-- Arguments                nil
-- Returns                  nil
-------------------------------------------------------------------------------------
function M:Initiallize()
    M.Freq = FREQ                   -- Number of seconds between footprint drops
    M.Remembered = REMEMBERED       -- Number of footprints the addon will remember
    M.Size = SIZE                   -- Size of the dropped footprints
    M.Coords = {}                   -- Array to hold footprints
    M.Frames = {}                   -- Array to hold texture for footprints
    M.Timer = M.Freq     	        -- Timer for footprint drop
    
    -- Create Frames
    for i=1,M.Remembered do
        local frame = CreateFrame("Frame", "Footsteps.Listener", UIParent)
        frame:SetHeight(M.Size)
        frame:SetWidth(M.Size)
        frame:SetBackdrop( {
            bgFile = [[Interface\Tooltips\UI-Tooltip-Background]]
        })
        frame:SetBackdropColor(0.2, 0.2, 0.2, 0.7)
        frame:SetPoint("CENTER", 0, 0)
        M.Frames[i] = frame
    end
end
M:Initiallize() -- TODO: Move to central location
    
-------------------------------------------------------------------------------------
-- Coords Queue-Array
-------------------------------------------------------------------------------------
M.Coords.Size = 0          -- Size of Queue
M.Coords.First = 1         -- Index of first item in Queue
M.Coords.Last = 0          -- Index of last item in Queue
-------------------------------------------------------------------------------------
-- M.Coords:Push()          Adds a coordinate at the front of the queue
-- Arguments                Coordinate to be added
-- Returns                  nil
-------------------------------------------------------------------------------------
function M.Coords:Push(value)
    self.Last = self.Last + 1
    self[self.Last] = value
    self.Size = self.Size+1
end
-------------------------------------------------------------------------------------
-- M.Coords:Pop()           Removes the oldest coordinate from the queue
-- Arguments                nil
-- Returns                  Coordinate that was removed
-------------------------------------------------------------------------------------
function M.Coords:Pop()
    local first = self.First
    if first > self.Last then error("Coordinate queue empty") end
    local value = self[first]
    self[first] = nil
    self.First = first + 1
    self.Size = self.Size-1
    return value
end

-------------------------------------------------------------------------------------
-- M:DropFootprints()       Adds a footprint to the array and bumps old ones out
-- Arguments                elapsed - time since last called
-- Returns                  nil
-------------------------------------------------------------------------------------
function M:DropFootprints(elapsed)
    -- Add the timesince last update to the timer
    M.Timer = M.Timer + elapsed	
    
    -- If the timer value less than the frequency, it's not time to print yet
    if M.Timer < M.Freq then return end
    
    -- Reset timer
    M.Timer = 0
    
    -- Create coordinate object
    local coord = {}
    coord.zone = GetZoneText()
    coord.x, coord.y = GetPlayerMapPosition("player")
    M.Coords:Push(coord)
    
    -- Remove old coordinate object if necessary
    if M.Coords.Size > M.Remembered then M.Coords:Pop() end
    
    -- TODO: Remove
    -- Print the current coordinates to the chat window
    DEFAULT_CHAT_FRAME:AddMessage("Coord List:")
    for i = M.Coords.First, M.Coords.Last do
        coord = M.Coords[i]
        DEFAULT_CHAT_FRAME:AddMessage(
            format("( %s ) %d,%d", coord.zone,coord.x*100,coord.y*100))
    end

end

-------------------------------------------------------------------------------------
-- M:DrawFootprints()       Draws current footprints to minimap
-- Arguments                nil
-- Returns                  nil
-------------------------------------------------------------------------------------
function M:DrawFootprints()
    
    -- Process Minimap --
    -- Get the position of the center of the minimap (player position)
    -- For each coordinate
        -- Calculate the coordinate relative to the player position
        -- Move the marker to the correct location and make it visible
    
    -- Process Zone Map --
    -- If the zone map is visible
        -- Get the coordinates of the upper left corner
        -- For each coordinate
            -- If the coordinate is in this zone
                -- Move a marker to the correct location and make it visible
            -- If it's not in this zone
                -- Make marker invisible
end


-------------------------------------------------------------------------------------
-- M:OnUpdate()             Drops footprints and draws them
-- Arguments                elapsed
-- Returns                  nil
-------------------------------------------------------------------------------------
function M:OnUpdate(elapsed)
    M:DropFootprints(elapsed)
    M:DrawFootprints()
end

A.Listener:SetScript("OnUpdate", M.OnUpdate)  -- TODO: Move to central location