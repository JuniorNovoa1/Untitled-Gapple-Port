function onCreatePost()
	scaleObject("dad", 0.25, 0.25, true)
	callOnLuas("addToVal", {'dad.x', 205})
	callOnLuas("takeFromVal", {'dad.y', 100})
	setProperty("dad.canDance", false)
end

function onStepHit()
	if curStep == 48 then 
		doTweenX("dadScaleX", "dad.scale", 1.2, 1.25)
		doTweenY("dadScaleY", "dad.scale", 1.2, 1.25)
		doTweenX("dadX", "dad", getProperty("dad.x") -205, 1.25)
		doTweenY("dadY", "dad", getProperty("dad.y") +100, 1.25)
		setProperty("bg.color", getColorFromHex("0000ff"))
	end

	if curStep == 64 and flashingLights then
		setProperty("bg.color", getColorFromHex("FFFFFF"))
		cameraFlash("other", "FFFFFF", 1) 
		setProperty("dad.canDance", true) 
	end
end