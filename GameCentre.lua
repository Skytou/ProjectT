
-- Game Centre Class

local GameCentre 	= {}
local gameNetwork 	= require ("gameNetwork")
local loggedIntoGC 	= false

local leaderBoards 	= 
{
	["distancecovered"] = "com.skytou.pawadventures.distancecovered",
	["leaderboard2"]    = "",
	["leaderboard3"]    = ""
}

 
-- function GameCentre:new( o )
-- 	o = o or {}
-- 	setmetatable( o, self )
-- 	self.__index = self
-- 	return o
-- end

function GameCentre:Init()
 gameNetwork.init( "gamecenter", InitCallBack )
end


local function InitCallBack(event )
 	-- body
 	print("GC")
    if ( event.type == "showSignIn" ) then
        -- This is an opportunity to pause your game or do other things you might need to do while the Game Center Sign-In controller is up.
    elseif ( event.data ) then
        loggedIntoGC = true
       native.showAlert( "Success!", "", { "OK" } )
       print("Game centre logged in")
    end
    return true
end
 


function GameCentre:ShowLeaderBoard(leaderBoardName)

	print( leaderBoards[leaderBoardName]  )
		gameNetwork.show( "leaderboards", 
		{ 
			leaderboard={ category= leaderBoards[leaderBoardName]  } 
		} 
	)
	return true
end


function GameCentre:PostScoreToLeaderBoard(leaderBoardName,score)
	 
	gameNetwork.request( "setHighScore",
    {
        localPlayerScore = { category=leaderBoards[leaderBoardName] , value=score} ,
        listener = highScoreCallBack
         
    }
)
end
 
 local function highScoreCallBack( event )

	if ( event.data ) then
		-- Event type of "setHighScore"
		if ( event.type == "setHighScore" ) then
			native.showAlert( "Result", event.data.value..' submitted to\n"'..leaderBoards[leaderBoardName] ..'" leaderboard.', { "OK" } )
		end
	end

	 
end






return GameCentre