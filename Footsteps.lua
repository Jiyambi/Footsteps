-------------------------------------------------------------------------------------
-- Footsteps.lua    Main addon setup
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

-- General --
Footsteps = {}                      -- Table to hold all addon data
Footsteps.Version =                 -- The addon version defined in the ToC page
    GetAddOnMetadata("Footsteps", "Version")

-------------------------------------------------------------------------------------
-- CreateListenerFrame()    Sets up a listener frame for event handling.
-- Arguments                nil
-- Returns                  nil
-------------------------------------------------------------------------------------
function Footsteps:CreateListener()

    -- Create Listener
    Footsteps.Listener = CreateFrame("Button", "Footsteps.Listener", UIParent)
	
end
Footsteps:CreateListener()