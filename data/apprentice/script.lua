local shadname = "glitchEffect";

local allBGItems = {"3dbg", "dave3D", "exckspee", "headphone_man", "joocey", "winteer"}
function onCreate()
	makeLuaSprite('3dbg', 'extras/apprentice/trist', 0, 0)
	scaleObject("3dbg", 2, 2, true)
	screenCenter("3dbg", 'xy')
	addLuaSprite('3dbg', false)
	initLuaShader(shadname)
	setSpriteShader('3dbg', shadname)
    setShaderFloat('3dbg', 'uWaveAmplitude', 0.1)
    setShaderFloat('3dbg', 'uFrequency', 5)
    setShaderFloat('3dbg', 'uSpeed', 2)

	makeLuaSprite('dave3D', 'extras/apprentice/daverson', -275, 50)
	addLuaSprite('dave3D', false)

	makeLuaSprite('exckspee', 'extras/apprentice/exckspee', 125, -275)
	scaleObject("exckspee", 0.6, 0.6, true)
	addLuaSprite('exckspee', false)

	makeLuaSprite('headphone_man', 'extras/apprentice/headphone_man', 300 + (getProperty("exckspee.width") / 2), -100)
	scaleObject("headphone_man", 0.6, 0.6, true)
	addLuaSprite('headphone_man', false)

	makeLuaSprite('joocey', 'extras/apprentice/joocey', getProperty("headphone_man.x") + (getProperty("headphone_man.width") / 1.25), -275)
	scaleObject("joocey", 0.6, 0.6, true)
	addLuaSprite('joocey', false)

	makeLuaSprite('winteer', 'extras/apprentice/winteer', getProperty("joocey.x") + (getProperty("joocey.width") / 1.35), -100)
	scaleObject("winteer", 0.6, 0.6, true)
	addLuaSprite('winteer', false)
	for i = 1, #allBGItems do
		setProperty(allBGItems[i]..".alpha", 0)
		if i >= 3 then
			setProperty(allBGItems[i]..".scale.x", 0.8)
			setProperty(allBGItems[i]..".scale.y", 0.8)
		end
	end
end

local elapsedtime = 0.0;
function onUpdate(elapsed)
    elapsedtime = elapsedtime + elapsed;
	setProperty("exckspee.y", getProperty("exckspee.y") + (math.sin(elapsedtime) * 0.6))
	setProperty("headphone_man.y", getProperty("headphone_man.y") - (math.sin(elapsedtime) * 0.6))
	setProperty("joocey.y", getProperty("joocey.y") + (math.sin(elapsedtime) * 0.6))
	setProperty("winteer.y", getProperty("winteer.y") - (math.sin(elapsedtime) * 0.6))

	setProperty("exckspee.angle", math.sin(elapsedtime) * 15)
	setProperty("headphone_man.angle", -math.sin(elapsedtime) * 15)
	setProperty("joocey.angle", math.sin(elapsedtime) * 15)
	setProperty("winteer.angle", -math.sin(elapsedtime) * 15)
end
function onUpdatePost(elapsed)
	setShaderFloat('3dbg', 'uTime', os.clock())
end

function onStepHit()
	if curStep == 672 then
		for i = 1, #allBGItems do
			setProperty(allBGItems[i]..".alpha", 1)
			if i >= 3 then
				doTweenX(allBGItems[i].."x", allBGItems[i]..".scale", 0.5, 1, "cubeInOut")
				doTweenY(allBGItems[i].."y", allBGItems[i]..".scale", 0.5, 1, "cubeInOut")
			end
		end
		if flashingLights then
			cameraFlash("other", "FFFFFF", 1)
		end
	end
	if curStep == 1472 then
		for i = 1, #allBGItems do
			setProperty(allBGItems[i]..".alpha", 0)
		end
		if flashingLights then
			cameraFlash("other", "FFFFFF", 1)
		end
	end
end