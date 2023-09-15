function onCreate()
	local scaleMult = 1.2;

	makeLuaSprite('sky', 'extras/apprentice/sky', 0, 0)
	scaleObject("sky", scaleMult, scaleMult, true)
	screenCenter("sky", 'xy')
	addLuaSprite('sky', false)

	makeLuaSprite('clouds', 'extras/apprentice/clouds', 0, 0)
	scaleObject("clouds", scaleMult, scaleMult, true)
	screenCenter("clouds", 'xy')
	addLuaSprite('clouds', false)

	makeLuaSprite('water', 'extras/apprentice/water', 0, 0)
	scaleObject("water", scaleMult, scaleMult, true)
	screenCenter("water", 'xy')
	addLuaSprite('water', false)
	
	makeLuaSprite('grass', 'extras/apprentice/grass', 0, 0)
	scaleObject("grass", scaleMult, scaleMult, true)
	screenCenter("grass", 'xy')
	addLuaSprite('grass', false)

	makeLuaSprite('props', 'extras/apprentice/props', 0, 0)
	scaleObject("props", scaleMult, scaleMult, true)
	screenCenter("props", 'xy')
	addLuaSprite('props', false)

	--671 is 3d
	--1472 is return

	makeAnimatedLuaSprite('crowd', 'extras/apprentice/tristan_crowd', 350, 250)
	addAnimationByPrefix("crowd", "crowd", "crowd", 24, false)
	scaleObject("crowd", 0.75, 0.75, true)
	addLuaSprite('crowd', false)

	makeAnimatedLuaSprite('dave', 'extras/apprentice/davec', -275, 200)
	addAnimationByPrefix("dave", "idle", "idle", 24, false)
	scaleObject("dave", 0.75, 0.75, true)
	addLuaSprite('dave', false)
end

function onBeatHit()
	if curBeat % 2 == 0 then
		playAnim("crowd", "crowd", true)
		playAnim("dave", "idle", true)
	end
end