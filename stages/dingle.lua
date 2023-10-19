function onCreate()
	if string.lower(songName) == 'the-big-dingle' then
		makeLuaSprite('sludd', 'extras/dale_and_dingle/sludd', 0, 0)
		scaleObject("sludd", 2.2, 2, true)
		screenCenter("sludd", 'xy')
		setScrollFactor("sludd", 1.1, 1.1)
		setProperty("sludd.y", getProperty("sludd.y") + 100)
		addLuaSprite('sludd', false)
	
		if not lowQuality then
			makeLuaSprite('water', 'extras/dale_and_dingle/water', 0, 0)
			scaleObject("water", 2, 2, true)
			screenCenter("water", 'xy')
			addLuaSprite('water', false)
		end
	
		makeLuaSprite('sand', 'extras/dale_and_dingle/sand', 0, 0)
		scaleObject("sand", 2, 2, true)
		screenCenter("sand", 'xy')
		setScrollFactor("sand", 0.9, 0.9)
		addLuaSprite('sand', false)

		makeAnimatedLuaSprite("crowd", 'extras/dale_and_dingle/crowd', 0, 0)
		addAnimationByPrefix("crowd", "danceLeft", "danceLeft", 24, false)
		addAnimationByPrefix("crowd", "danceRight", "danceRight", 24, false)
		scaleObject("crowd", 0.5, 0.5, true)
		setProperty("crowd.x", getProperty("crowd.x") + 160)
		setProperty("crowd.y", getProperty("crowd.y") - 150)
		addLuaSprite("crowd", false)
	end

	makeLuaSprite('sky', 'extras/dale_and_dingle/sky', 0, 0)
	scaleObject("sky", 2, 2, true)
	screenCenter("sky", 'xy')
	setScrollFactor("sky", 1.1, 1.1)
	setProperty("sky.y", getProperty("sky.y") + 100)
	addLuaSprite('sky', false)

	if not lowQuality then
		makeLuaSprite('city', 'extras/dale_and_dingle/city', 0, 0)
		scaleObject("city", 2, 2, true)
		screenCenter("city", 'xy')
		setProperty("city.x", getProperty("city.x") + 150)
		addLuaSprite('city', false)
	
		makeLuaSprite('behindTrain', 'extras/dale_and_dingle/behindTrain', 0, 0)
		scaleObject("behindTrain", 2, 2, true)
		screenCenter("behindTrain", 'xy')
		addLuaSprite('behindTrain', false)
	end

	makeLuaSprite('street', 'extras/dale_and_dingle/street', 0, 0)
	scaleObject("street", 2, 2, true)
	screenCenter("street", 'xy')
	setProperty("street.y", getProperty("street.y") -45)
	setScrollFactor("street", 0.9, 1.35)
	addLuaSprite('street', false)

	--blackbar city
	makeLuaSprite('blackBarsSquareLeft', '', 0, 0)
	makeGraphic('blackBarsSquareLeft', '256', '720', '000000')
	setObjectCamera("blackBarsSquareLeft", "hud")
	addLuaSprite('blackBarsSquareLeft', true)
	makeLuaSprite('blackBarsSquareRight', '', 1280 - 256, 0)
	makeGraphic('blackBarsSquareRight', '256', '720', '000000')
	setObjectCamera("blackBarsSquareRight", "hud")
	addLuaSprite('blackBarsSquareRight', true)

	makeLuaSprite('blackBarsSquareUp', '', 0, 0)
	makeGraphic('blackBarsSquareUp', '1280', '72', '000000')
	setObjectCamera("blackBarsSquareUp", "hud")
	addLuaSprite('blackBarsSquareUp', true)
	makeLuaSprite('blackBarsSquareDown', '', 0, 720 - 72)
	makeGraphic('blackBarsSquareDown', '1280', '72', '000000')
	setObjectCamera("blackBarsSquareDown", "hud")
	addLuaSprite('blackBarsSquareDown', true)
end

function onCreatePost()
	if not lowQuality then
		makeAnimatedLuaSprite("pon", 'extras/dale_and_dingle/pon', getProperty("dad.x") - 175, getProperty("dad.y") + 225)
		addAnimationByPrefix("pon", "idle", "IDLE0", 24, false)
		addLuaSprite("pon", true)

		makeAnimatedLuaSprite("talking", 'extras/dale_and_dingle/talking', -200, 0)
		addAnimationByPrefix("talking", "talk", "WHAT", 24, false)
		updateHitbox("talking")
		setObjectCamera("talking", "hud")
		addLuaSprite("talking", true)
		setProperty("talking.visible", false)
	end
end

function onBeatHit()
	if curBeat % 2 == 0 and luaSpriteExists("pon") then
		playAnim("pon", "idle", true)
	end

	if curBeat % 2 == 0 and luaSpriteExists("crowd") then
		if getProperty("crowd.animation.curAnim.name") == 'danceLeft' then playAnim("crowd", "danceRight", true) else playAnim("crowd", "danceLeft", true) end
	end
end