local gappleSongs = {};

function onCreate()
	addHaxeLibrary('Application', 'lime.app')
	addHaxeLibrary('Image', 'lime.graphics')
	addHaxeLibrary('WindowData', 'lime.tools')
	addHaxeLibrary('System', 'openfl.system')
	addHaxeLibrary('Lib', 'openfl')
	addHaxeLibrary('ClientPrefs')
end

function onCreatePost()
	gappleSongs = getDataFromSave("Juniors Ports Stuff", "gappleSongs")
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
	if buildTarget ~= 'windows' then
		return; --don't want other people crashing when trying to play
	end
	
	runHaxeCode([[
		Application.current.window.title = "Friday Night Funkin': Psych Engine";
		Lib.application.window.setIcon(Image.fromBitmapData(Paths.image("appIcons/Funkin").bitmap));
	]])
end

function onResume()
	changeIcon()
	setPropertyFromClass("Main", "fpsVar.visible", false)
end

function onEndSong()
	clearCache();
end

function onDestroy()
	clearCache();
end

function clearCache()
	runHaxeCode([[
		openfl.system.System.gc();
	]])
	setPropertyFromClass("Main", "fpsVar.visible", getPropertyFromClass('ClientPrefs', 'showFPS'))
	if buildTarget ~= 'windows' then
		return; --don't want other people crashing when trying to play
	end
	runHaxeCode([[
		Application.current.window.title = "Friday Night Funkin': Psych Engine";
		Lib.application.window.setIcon(Image.fromBitmapData(Paths.image("appIcons/Funkin").bitmap));
	]])
end

function changeIcon()
	if buildTarget ~= 'windows' then
		return; --don't want other people crashing when trying to play
	end

	if string.lower(songName) == 'maze' then
		runHaxeCode[[
			Application.current.window.title = "Friday Night Funkin' | VS. Dave and Bambi 3.0b";
			Lib.application.window.setIcon(Image.fromBitmapData(Paths.image("appIcons/DNB").bitmap));
		]]
	end

	for i = 1, #gappleSongs do
		if string.lower(songName) == gappleSongs[i] then
			runHaxeCode[[
				Application.current.window.title = 'Vs Dave and Bambi: Golden Apple';
				Lib.application.window.setIcon(Image.fromBitmapData(Paths.image("appIcons/Gapple").bitmap));
			]]
		end
	end
end