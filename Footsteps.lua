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
Footsteps = {}                      -- Table to hold all addon data
local A = Footsteps                 -- Localize reference to addon table
A.Version =                         -- The addon version defined in the ToC page
    GetAddOnMetadata("Footsteps", "Version")
A.DEBUGLEVEL = 10                   -- Screens debug messages

-------------------------------------------------------------------------------------
-- Debug()    				Prints a debug message.
-- Arguments                lvl: The debug level at which to print this message
--                          msg: The message to print
-- Returns                  nil
-------------------------------------------------------------------------------------
function A:Debug(lvl, msg)
    if lvl <= A.DEBUGLEVEL then
        DEFAULT_CHAT_FRAME:AddMessage(msg)
    end
end

-------------------------------------------------------------------------------------
-- CreateListenerFrame()    Sets up a listener frame for event handling.
-- Arguments                nil
-- Returns                  nil
-------------------------------------------------------------------------------------
function A:CreateListener()
    A:Debug(10,"func enter Footsteps:CreateListener()")

    -- Create Listener
    A.Listener = CreateFrame("Button", "Footsteps.Listener", UIParent)
    A.Listener:Hide()
	
    A:Debug(10,"func exit Footsteps:CreateListener()")
end
A:Debug(9,"func call Footsteps:CreateListener()")
A:CreateListener()  -- TODO: Move to central location