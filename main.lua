display.setStatusBar(display.HiddenStatusBar)
local physics = require("physics")
physics.start()
local left = display.newRect(0,0,0,880)
physics.addBody(left,"static",{friction=0.5,bounce=0.3})
local right = display.newRect(320,0,0,880)
physics.addBody(right,"static",{friction=0.5,bounce=0.3})
local top = display.newRect(0,0,600,0)
physics.addBody(top,"static",{friction=0.5,bounce=0.3})
local sky = display.newImage("bkg_clouds.png", 160, 195)
local ground = display.newImage("ground.png", 160, 445)
physics.addBody(ground,"static",{friction=0.5,bounce=0.3})
local crate = display.newImage("crate.png", 180, 50)
crate.rotation = 5
physics.addBody(crate, {density=3.0,friction=0.5,bounce=0.5})
local shelf = display.newRect(56.5,250,85,10)
physics.addBody(shelf, "static",{friction=0.5,bounce=0.5})
local side1 = display.newRect(20,220,10,60)
physics.addBody(side1, "static",{friction=0.5,bounce=0.5})
local side2 = display.newRect(93,220,10,60)
physics.addBody(side2, "static",{friction=0.5,bounce=0.5})



local moveLeft
local function moveRight()
	transition.to(shelf, {time = 5000, x = 261})
	transition.to(side1, {time = 5000, x = 223})
	transition.to(side2, {time = 5000, x = 299, onComplete = moveLeft})
end
moveLeft = function()
	transition.to(shelf, {time = 5000, x = 57.5})
	transition.to(side1, {time = 5000, x = 20})
	transition.to(side2, {time = 5000, x = 95, onComplete = moveRight})
end
moveRight()


local function reposition()
	crate.rotation = math.random(-360,360)
	crate:applyLinearImpulse(0,-200,crate.x,crate.y)
end
crate:addEventListener("tap", reposition)