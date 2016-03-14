--##############################  Main Code Begin  ##############################--
local composer = require( "composer" )

local scene = composer.newScene()

-- "scene:create()"
function scene:create( event )
	local sceneGroup = self.view

	-- 여기서부터 시작
	local img = display.newImage("Icon.png")
	transition.to(img, {time=1000, x=150, y=150})
end

-- -------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )

-- -------------------------------------------------------------------------------

return scene
--##############################  Main Code End  ##############################--