local gappleSongs = {'maze', 'disruption', 'applecore', 'disability', 'wireframe', 'algebra', 'ferocious', 'sugar-rush', 'cuberoot', 'sart-producer', 'og', 'mine', 'apple-leak', 'badcorn', 'crap!', 'kooky'};

function onCreate()
	addHaxeLibrary('Application', 'lime.app')
	addHaxeLibrary('Image', 'lime.graphics')
	addHaxeLibrary('WindowData', 'lime.tools')
	addHaxeLibrary('System', 'openfl.system')
	addHaxeLibrary('Lib', 'openfl')

	clearCache();
end

function onCreatePost()
	if getProperty('boyfriend.antialiasing') == true then --no point if antialiasing is off
		setProperty('boyfriend.antialiasing', getPropertyFromClass('ClientPrefs', 'globalAntialiasing'));
	end

	if getProperty('dad.antialiasing') == true then --no point if antialiasing is off
		setProperty('dad.antialiasing', getPropertyFromClass('ClientPrefs', 'globalAntialiasing'));
	end

	if getProperty('gf.antialiasing') == true then --no point if antialiasing is off
		setProperty('gf.antialiasing', getPropertyFromClass('ClientPrefs', 'globalAntialiasing'));
	end

	changeIcon();
end

function onEvent(tag, val1, val2)
	if tag == 'Change Character' then
		if getProperty('boyfriend.antialiasing') == true then --no point if antialiasing is off
			setProperty('boyfriend.antialiasing', getPropertyFromClass('ClientPrefs', 'globalAntialiasing'));
		end
	
		if getProperty('dad.antialiasing') == true then --no point if antialiasing is off
			setProperty('dad.antialiasing', getPropertyFromClass('ClientPrefs', 'globalAntialiasing'));
		end
	
		if getProperty('gf.antialiasing') == true then --no point if antialiasing is off
			setProperty('gf.antialiasing', getPropertyFromClass('ClientPrefs', 'globalAntialiasing'));
		end
	end
end

function onPause()
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


	if string.lower(songName) == 'lore' then
		runHaxeCode[[
			Application.current.window.title = "Friday Night Funkin' D-Sides";
			Lib.application.window.setIcon(Image.fromBitmapData(Paths.image("appIcons/D-Sides").bitmap));
		]]
	end

	if string.lower(songName) == 'close chuckle' then
		runHaxeCode[[
			Application.current.window.title = "Hotline 024";
			Lib.application.window.setIcon(Image.fromBitmapData(Paths.image("appIcons/Hotline-024").bitmap));
		]]
	end
end