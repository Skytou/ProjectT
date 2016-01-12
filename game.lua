-----------------------------------------------------------------------------------------
--
-- game.lua
--
-----------------------------------------------------------------------------------------

local composer 		= require( "composer" )
local scene 		= composer.newScene()
 
local GameCentre 	= require("GameCentre")
local physics 		= require("physics")
 
 

--------------------------------------------

-- forward declarations and other locals
local screenW, screenH, halfW 	= display.contentWidth, display.contentHeight, display.contentWidth*0.5
local centerX 					= display.contentCenterX
local centerY 					= display.contentCenterY
local StatusMessageY 			= 120	-- pos y for log message

local holding 					= false
local isCollided				= false
 
 physics.start(); physics.pause()
 physics.setDrawMode( "normal" )

local function createStatusMessage( message, x, y )
	-- Show text, using default bold font of device (Helvetica on iPhone)
	local textObject = display.newText(message, 0, 0, native.systemFontBold, 12 )
	textObject:setFillColor( 1,1,1 )

	-- A trick to get text to be centered
	local group 	= display.newGroup()
	group.x 		= x
	group.y 		= y
	group:insert( textObject, true )

	 
	group.textObject = textObject
	return group
end

local onScreenMessage 	= createStatusMessage( " Log: ", centerX, StatusMessageY )

function scene:create( event )

	-- Called when the scene's view does not exist.
	-- 
	-- INSERT code here to initialize the scene
	-- e.g. add display objects to 'sceneGroup', add touch listeners, etc.

	local sceneGroup 	= self.view
	local background 	= display.newRect( 0, 0, screenW, screenH ) -- create a grey rectangle as the backdrop
	background.anchorX 	= 0
	background.anchorY 	= 0
	background:setFillColor( .5 )
	
	-- local crate = display.newImageRect( "crate.png", 90, 90 )
	-- crate.x, crate.y = 160, 100
	-- physics.addBody( crate, "static",{ density=1.0, friction=0.3, bounce=0.3 } )

	-- local crate2 = display.newImageRect( "crate.png", 90, 90 )
	-- crate2.x, crate2.y = 160, 300
	-- physics.addBody( crate2, "static",{ density=1.0, friction=0.3, bounce=0.3 } )
	 
	 local needle = display.newRect( 100, 100, 10, 150 )
	needle.anchorY = 0
	needle.rotation = 50
	needle.name ="needle"
	physics.addBody(needle, "static", {bounce = 0, friction = 0.1} )

	local function moveNeedle()
	    transition.to( needle, { tag="moveNeedle", time=1000, rotation=-50, transition=easing.inSine } )
	    transition.to( needle, { tag="moveNeedle", delay=1000, time=1000, rotation=50, transition = easing.inSine } )
	end

local function moveCircle()
	--physics.addBody(circle, "static", {bounce=0.1})
	-- local t = cicle.object
	-- local parent = t.parent
	-- parent:insert( t )
	-- display.getCurrentStage():setFocus( t, event.id )
	-- t.bodyType = "kinematic"
	-- t:setLinearVelocity( 0, 0 ) -- Stop the body's motion x and y
	-- t.angularVelocity = 0 -- Stop the body's rotation

	-- t.isFocus = true
	-- t.x0 = event.x - t.x
	-- t.y0 = event.y - t.y

	    -- transition.to( circle, { tag="moveCircle", time=1000, rotation=-50, transition=easing.inSine } )
	    -- transition.to( circle, { tag="moveCircle", delay=1000, time=1000, rotation=50, transition = easing.inSine } )
	end

timer.performWithDelay( 2000, moveNeedle, 0 )
moveNeedle()

local circle = display.newCircle(0, 0, 20)
circle.x = 150
circle.y = 290
circle.name ="circle"

physics.addBody(circle, "dynamic", {bounce=0.1})

local floor = display.newRect(0, 0, 480, 1)
floor.x = _W
floor.y = 320
physics.addBody(floor, "static", {bounce = 0, friction = 0.1} )
floor.isVisible = true

local function circle_jump(event)
	if(isCollided == false) then

		if(event.phase == "ended" and jump_completed == false)then

		jump_completed = true
		circle:setLinearVelocity(-100, -250)
		end
	end
end

local function on_hit(event)
if(event.phase == "began")then
	-- print( event.target.name )       --the first object in the collision
 --    print( event.other.name )       --the second object in the collision
   if(event.other.name =="needle") then
   	print ("wow")
   	isCollided =true
   	afterCollision()
   	--moveCircle()

   end
	jump_completed = false

end
end

local function afterCollision( )
	-- body
	if(isCollided) then
		print("w")
		display.getCurrentStage():setFocus(circle)
		circle.bodyType ="kinematic"
   		circle:setLinearVelocity(0, 0)
   	 	circle.x = needle.x
   	 	circle.y = needle.y
	end
end




Runtime:addEventListener("touch", circle_jump)
circle:addEventListener("collision", on_hit)

 

	  -- local touchJoint = physics.newJoint( "touch", crate2, 100, 100 )
	  -- touchJoint:setTarget( 100, 100 )
-- 	 local firstButton 	= display.newRect( display.contentWidth/2, display.contentHeight/2, 100, 100 )
-- 	 firstButton.id 	= "leaderboard"

-- 	 local secondButton = display.newRect( display.contentWidth/2, display.contentHeight-100, 100, 100 )
-- 	 secondButton.id 	= "postScore"

-- 	local function OnButtonTap(event)
-- 	  	--GameCentre:ShowLeaderBoard("distancecovered")		
-- 	  	--if(even.phase =="tap") then
-- 	  	if(event.pressure== nil) then
-- 	  		onScreenMessage.textObject.text = "Button Tapped"	 
-- 	  	else
-- 	  		onScreenMessage.textObject.text = "pressure"..event.pressure
-- 	 	end
-- 	end



-- 	local function OnPostScoreTap(event) 
-- 	 	--GameCentre:PostScoreToLeaderBoard("distancecovered",2000)
-- 	 end

-- -- local function enterFrameListener()
-- --     if holding then
-- --         -- Holding button
-- --         -- Code here
-- --         if(event.pressure==null) then
-- --          onScreenMessage.textObject.text = "Holding"
-- --      else
-- --  		 onScreenMessage.textObject.text = "Holding Pressure"..event.pressure
-- --      end

-- --     else
-- --         -- Not holding
-- --          onScreenMessage.textObject.text = "Not holding"
-- --     end
-- -- end

-- local function onButtonTouch( event)
-- 	 	-- body
 
-- 	 	if ( event.phase == "began" ) then
-- 	 		--display.getCurrentStage( ):setFocus( event.target)
-- 	 		--event.target.isFocus = true
-- 	 		--event.target.isfocus = true
-- 	 		-- Runtime:addEventListener( "enterFrame", enterFrameListener )
-- 	 		 --holding = true
-- 	 		-- if(event.pressure==nil) then
-- 				-- print(event.pressure)
-- 				-- onScreenMessage.textObject.text = "Touch event began on: " ..event.name.. event.target.id
--  			-- else
--  			 	onScreenMessage.textObject.text = "pressure".."Touch event began on: " ..event.name.. event.target.id
 		 
--  			--print( "Touch event began on: " .. event.target.id )
--     	elseif ( event.phase == "ended" ) then
--  			onScreenMessage.textObject.text = "Not Holding Touch event ended on: " .. event.target.id
--  			holding = false
--             Runtime:removeEventListener( "enterFrame", enterFrameListener )
--             display.getCurrentStage():setFocus( nil )
--             event.target.isFocus = false
--        	end
    
--  return true

-- end
	 
	-- all display objects must be inserted into group

	-- firstButton:addEventListener("tap",OnButtonTap)

	-- secondButton:addEventListener( "touch", onButtonTouch )
	 
	sceneGroup:insert( background )
	-- sceneGroup:insert( firstButton )
	-- sceneGroup:insert( secondButton )
	-- sceneGroup:insert( crate )
	-- sceneGroup:insert( crate2 )
	 
end


function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then

		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
		physics.start()
		  
	end
end

function scene:hide( event )
	local sceneGroup = self.view
	
	local phase = event.phase
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
		physics.stop()
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end	
	
end

function scene:destroy( event )

	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
	local sceneGroup = self.view
	
 
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene