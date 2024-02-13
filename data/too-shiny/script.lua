function onCreatePost()
	scaleObject("dad", 0.25, 0.25, true)
	setProperty("dad.x", getProperty("dad.x") + 205)
	setProperty("dad.y", getProperty("dad.y") - 100)
	setProperty("dad.canDance", false)
end

function onStepHit()
	if curStep == 48 then 
		doTweenX("dadScaleX", "dad.scale", 1.2, 1.25 / playbackRate)
		doTweenY("dadScaleY", "dad.scale", 1.2, 1.25 / playbackRate)
		doTweenX("dadX", "dad", getProperty("dad.x") -205, 1.25 / playbackRate)
		doTweenY("dadY", "dad", getProperty("dad.y") +100, 1.25 / playbackRate)
		setProperty("bg.color", getColorFromHex("0000ff"))
	end

	if curStep == 64 and flashingLights then
		setProperty("bg.color", getColorFromHex("FFFFFF"))
		cameraFlash('other', 'FFFFFF', 1 / playbackRate) 
		setProperty("dad.canDance", true) 
	end
end