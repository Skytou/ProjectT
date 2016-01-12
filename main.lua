-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- hide the status bar
display.setStatusBar( display.HiddenStatusBar )

-- include the Corona "composer" module
local composer 		= require ("composer")
local GameCentre 	= require ("GameCentre")


 -- Calling Game Centre on Application Start

local function onSystemEvent( event ) 
    if ( event.type == "applicationStart" ) then
    	print("initialise game centre")
    	GameCentre:Init()
        return true
    end
end

Runtime:addEventListener( "system", onSystemEvent )

-- load menu screen
composer.gotoScene( "game" ) -- change to menu

 