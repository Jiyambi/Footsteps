-------------------------------------------------------------------------------------
-- Footsteps.lua  	Main addon setup
-- Project		    Footsteps - an addon that tracks where you're going and 
--					where you've been.
-- Authors		    Jiyambi, Taellis, Phaedra
-- Version		    0.1
-- Licesnse			Creative Commons Attribution-NonCommercial-NoDerivs 3.0 
--					Unported License
-------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------
-- Global Variable Initialization 
-------------------------------------------------------------------------------------
Footsteps = {}			-- Table to hold all addon data
Footsteps.version = 	-- The addon version defined in the ToC page
	GetAddOnMetadata("Footsteps", "Version")
Footsteps.rate = 1		-- Number of seconds between footprint drops

-------------------------------------------------------------------------------------
-- CreateDebugFrame()	Sets up a debugging frame for interaction with the addon
--						during testing.
-- Arguments       		nil
-- Returns          	nil
-------------------------------------------------------------------------------------
function Footsteps:CreateDebugFrame()

	-- Create debug frame
	-- For now, we don't really want it to be visible so we don't specify a size
	--		or background.
	local frame = CreateFrame("Button", "Footsteps.DebugFrame", UIParent)
	Footsteps.DebugFrame = frame
	
	-- Set up OnUpdate script
	--		This is called every time the game redraws it's graphics
	local timer = 0		-- Timer for footprint drop based on Footsteps.rate
	local function OnUpdate(self, elapsed)
		-- Add the timesince last update to the timer
		timer = timer + elapsed	
		
		-- If the timer value is greater than our rate, it's time to print.
		if timer > Footsteps.rate then
			-- Reset timer
			timer = 0
			-- Print the current coordinates to the chat window
			local px,py=GetPlayerMapPosition("player")
			DEFAULT_CHAT_FRAME:AddMessage(format("( %s ) %i,%i", GetZoneText(),px *100,py *100))
		end
	end
	Footsteps.DebugFrame:SetScript("OnUpdate", OnUpdate)
end
Footsteps:CreateDebugFrame()
