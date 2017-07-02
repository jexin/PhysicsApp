display.setStatusBar(display.HiddenStatusBar)
local physics= require("physics")
physics.start()
 
local shelf
local side1                                                  
local side2
 
local home
 
local function base() 
	--- the following code was modified from a previous class assignment---
	--- using images created by https://github.com/coronalabs---
	local sky = display.newImage("bkg_clouds.png", 160, 195)
	local left = display.newRect(0,0,0,880)
	physics.addBody(left,"static",{friction=0.5,bounce=0.3})
	local right = display.newRect(320,0,0,880)
	physics.addBody(right,"static",{friction=0.5,bounce=0.3})
	local top = display.newRect(0,0,600,0)
	physics.addBody(top,"static",{friction=0.5,bounce=0.3})
	local crate = display.newImage("crate.png", 180, 50)
	crate.rotation = 5
	physics.addBody(crate,{bounce=0.3, density=2.0,friction=0.5})
	crate.isSleepingAllowed = false
	local function reposition()
		crate.rotation = math.random(-360,360)
		crate:applyLinearImpulse(0,-150,crate.x,crate.y)
	end
	crate:addEventListener("tap", reposition)
	shelf = display.newRect(56.5,250,85,10)
	physics.addBody(shelf, "static",{friction=0.5,bounce=0.3})
	side1 = display.newRect(19,220,10,60)
	physics.addBody(side1, "static",{friction=0.5,bounce=0.3})
	side2 = display.newRect(94,220,10,60)
	physics.addBody(side2, "static",{friction=0.5,bounce=0.3})
	local ground = display.newImage("ground.png", 160, 445)
	physics.addBody(ground,"static",{friction=0.5,bounce=0.5})
	---	
	local score = 0
	local inside = false
	local thescore = display.newText("Score " .. score,  150,430, native.systemFont , 19)
	local function update()
		if (crate.x > side1.x + 5 and crate.x < side2.x -5 and crate.y < shelf.y and crate.y > shelf.y - 50) then
			if inside == false then 
				inside = true
				score = score + 1
				thescore.text = "Score " .. score
			end
		else
			inside = false
		end
	end
	local timers = timer.performWithDelay(1, update, -1) 
	local function restart()
		transition.cancel()
		timer.cancel(timers)
		shelf:removeSelf()
		side1:removeSelf()
		side2:removeSelf()
		crate:removeSelf()
		ground:removeSelf()
		home()
	end
	ground:addEventListener("tap", restart)
end	
 
local function easy()
	local moveLeft
	local function moveRight()
		transition.to(shelf, {time = 3000, x = 261})
		transition.to(side1, {time = 3000, x = 223})
		transition.to(side2, {time = 3000, x = 299, onComplete = moveLeft})
	end
	moveLeft = function()
		transition.to(shelf, {time = 3000, x = 57.5})
		transition.to(side1, {time = 3000, x = 20})
		transition.to(side2, {time = 3000, x = 94, onComplete = moveRight})
	end
	moveRight()
end
 
local function medium()
	local moveLeft
	local function moveRight()
		transition.to(shelf, {time = 5000, x = 261})
		transition.to(side1, {time = 5000, x = 223})
		transition.to(side2, {time = 5000, x = 299, onComplete = moveLeft})
	end
	moveLeft = function()
		transition.to(shelf, {time = 5000, x = 57.5})
		transition.to(side1, {time = 5000, x = 20})
		transition.to(side2, {time = 5000, x = 94, onComplete = moveRight})
	end
	moveRight()
end
 
local function hard()
	local moveLeft
	local function moveRight()
		transition.to(shelf, {time = 10000, x = 261})
		transition.to(side1, {time = 10000, x = 223})
		transition.to(side2, {time = 10000, x = 299, onComplete = moveLeft})
	end
	moveLeft = function()
		transition.to(shelf, {time = 10000, x = 57.5})
		transition.to(side1, {time = 10000, x = 20})
		transition.to(side2, {time = 10000, x = 94, onComplete = moveRight})
	end
	moveRight()
end
 
home = function()
	local startscreen = display.newRect(0, 0, 640, 960)
	local ez = display.newRect(70,300, 80, 50)
	local eztext = display.newText("Easy",  70,300, native.systemFont , 19)
	ez:setFillColor(1, .5, .7)
	local md = display.newRect(160,300, 80, 50)
	local mdtext = display.newText("Medium",  160, 300, native.systemFont , 19)
	md:setFillColor(.5, .5, .7)
	local hd = display.newRect(250,300, 80, 50)
	local hdtext = display.newText("Hard", 250,300, native.systemFont , 19)
	hd:setFillColor(.5, .7, .7)
	local dir = display.newText("Tap crate to reposition. \n Tap grass to restart.",  170, 180, native.systemFont , 19)
	dir:setFillColor(.2,.6,.9)
	local function remove()
		startscreen:removeSelf()
		ez:removeSelf()
		md:removeSelf()
		hd:removeSelf()
		eztext:removeSelf()	
		mdtext:removeSelf()	
		hdtext:removeSelf()	
	end
	local function low()
		remove()
		base()
		easy()
	end
	local function mem()
		remove()
		base()
		medium()
	end
	local function hi()
		remove()
		base()
		hard()
	end
	ez:addEventListener("tap", low)
	md:addEventListener("tap", mem)
	hd:addEventListener("tap", hi)
end
 
home()
