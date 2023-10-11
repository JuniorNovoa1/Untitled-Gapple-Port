function onCreate()
	addHaxeLibrary('ClientPrefs')
end

function onCreatePost()
	clearCache()

	if stringStartsWith(version, '0.6') then
		runHaxeCode([[
			for (integer in game.modchartSprites.keys()) {
				game.modchartSprites[integer].antialiasing = ClientPrefs.globalAntialiasing;
			}
		]])
    else
		runHaxeCode([[
			for (integer in game.modchartSprites.keys()) {
				game.modchartSprites[integer].antialiasing = backend.ClientPrefs.data.antialiasing;
			}
		]])
    end

	changeIcon();
end

function onUpdatePost(elapsed)
	if stringStartsWith(version, '0.6') then
		runHaxeCode([[
			for (integer in game.modchartSprites.keys()) {
				game.modchartSprites[integer].antialiasing = ClientPrefs.globalAntialiasing;
			}
		]])
    else
		runHaxeCode([[
			for (integer in game.modchartSprites.keys()) {
				game.modchartSprites[integer].antialiasing = backend.ClientPrefs.data.antialiasing;
			}
		]])
    end
end

function onPause()
	setPropertyFromClass("Main", "fpsVar.visible", getPropertyFromClass('ClientPrefs', 'showFPS'))
end

function onResume()
	setPropertyFromClass("Main", "fpsVar.visible", false)
end

function onEndSong()
	clearCache();
end

function onDestroy()
	clearCache();
end

function clearCache()
	setPropertyFromClass("Main", "fpsVar.visible", getPropertyFromClass('ClientPrefs', 'showFPS'))
end