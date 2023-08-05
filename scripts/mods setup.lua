--DON'T STEAL KIDS!
--BY JUNIORNOVOA
local nonGappleSongs = {''};
local songSplashNames = {''};
local oldFNFPos = {''};
local gappleHUDsong = true;
local arrowXoffset = 35;
local no_splashes = true;

local songMod = 'DNB: Golden Apple';

local gappleMemoryCounter = false; --gapple doesn't have a memory counter...

local CharactersWith3D = {};

function onCreate()
	for i = 1, #nonGappleSongs do
		if string.lower(songName) == nonGappleSongs[i] then gappleHUDsong = false; end
	end

	if gappleHUDsong then
		makeLuaSprite('thunderBlack', '', 0, 0)
		makeGraphic('thunderBlack', '1280', '720', '000000')
		setProperty('thunderBlack.alpha', 0)
		setObjectCamera("thunderBlack", "hud")
		updateHitbox("thunderBlack")
		screenCenter("thunderBlack", 'xy')
		addLuaSprite('thunderBlack', true)
	end
end


function onCreatePost()
	CharactersWith3D = getDataFromSave("Juniors Ports Stuff", "CharactersWith3D")
	if stringStartsWith(version, '0.7') then
		changeDiscordClientID("1136119974763708478")
	end
	addLuaScript("activatedScripts/Gapple Rating", true)
	--[[for direction = 0, 3 do
		setPropertyFromGroup('playerStrums', direction, 'x', getPropertyFromGroup('playerStrums', direction, 'x') - arrowXoffset)
		setPropertyFromGroup('opponentStrums', direction, 'x', getPropertyFromGroup('opponentStrums', direction, 'x') - arrowXoffset -5)
	end--]]

	if not gappleHUDsong then return; end

	if stringStartsWith(version, '0.6') then
        addHaxeLibrary('HealthIcon')
    else
        addHaxeLibrary('HealthIcon', 'objects')
    end

	--White Hex Code: FFFFFF, Black Hex Code: 000000

	makeLuaText('fpsTxt', '', 0, 18, 6)
	setObjectCamera('fpsTxt', 'other')
	setTextAlignment('fpsTxt', 'center')
	setTextFont('fpsTxt', 'comic.ttf')
	setTextSize('fpsTxt', 26)
	setTextBorder('fpsTxt', 0, 'FFFFFF')
	setProperty('fpsTxt.antialiasing', true)
	if stringStartsWith(version, '0.6') then
		setProperty("fpsTxt.visible", getPropertyFromClass('ClientPrefs', 'showFPS'))
    else
		setProperty("fpsTxt.visible", getPropertyFromClass('backend.ClientPrefs', 'data.showFPS'))
    end
	if not gappleHUDsong then setProperty("fpsTxt.visible", false) end
	updateHitbox('fpsTxt')
	addLuaText('fpsTxt')

	makeLuaText('memoryTxt', '', 0, 18, 38)
	setObjectCamera('memoryTxt', 'other')
	setTextAlignment('memoryTxt', 'center')
	setTextFont('memoryTxt', 'comic.ttf')
	setTextSize('memoryTxt', 18)
	setTextBorder('memoryTxt', 0, 'FFFFFF')
	setProperty('memoryTxt.antialiasing', true)
	if stringStartsWith(version, '0.6') then
		setProperty("memoryTxt.visible", getPropertyFromClass('ClientPrefs', 'showFPS'))
    else
		setProperty("memoryTxt.visible", getPropertyFromClass('backend.ClientPrefs', 'data.showFPS'))
    end
	if not gappleHUDsong then setProperty("memoryTxt.visible", false) end
	updateHitbox('memoryTxt')
	if gappleMemoryCounter then addLuaText('memoryTxt') end

	if gappleHUDsong then setPropertyFromClass("Main", "fpsVar.visible", false) end

	makeAnimatedLuaSprite("gappleSoundTray", "gapple_soundtray", screenWidth - 150, 0)
	for i = 0, 9 do
		addAnimationByPrefix("gappleSoundTray", ""..(i + 1), ""..i, 24, true)
	end
	setObjectCamera("gappleSoundTray", "other")
	setProperty("gappleSoundTray.visible", false)
	updateHitbox("gappleSoundTray")
	screenCenter("gappleSoundTray", 'y')
	addLuaSprite("gappleSoundTray", false)

	setTextFont('scoreTxt', 'comic.ttf')
	setTextFont('timeTxt', 'comic.ttf')

	makeLuaText('creditsWatermark', songName, 0, 4, getProperty('healthBar.y') + 30)
	setObjectCamera('creditsWatermark', 'camHUD')
	setTextAlignment('creditsWatermark', 'center')
	setTextFont('creditsWatermark', 'comic.ttf')
	setTextSize('creditsWatermark', 16)
	setTextBorder('creditsWatermark', 1.5, '000000')
	setProperty('creditsWatermark.antialiasing', false)
	updateHitbox('creditsWatermark')
	addLuaText('creditsWatermark')

	if string.lower(songName) == 'nice' then setTextString("creditsWatermark", getTextString("creditsWatermark")..'!') end
	if string.lower(songName) == 'fresh-and-toasted' then setTextString("creditsWatermark", 'Fresh And Toasted') end

	makeLuaText('creditsText', '', 0, 4, getProperty('healthBar.y') + 52)
	setObjectCamera('creditsText', 'camHUD')
	setTextAlignment('creditsText', 'center')
	setTextFont('creditsText', 'comic.ttf')
	setTextSize('creditsText', 16)
	setTextBorder('creditsText', 1.5, '000000')
	setProperty('creditsText.antialiasing', false)
	updateHitbox('creditsText')
	addLuaText('creditsText')

	if string.lower(songName) == 'disruption' then setProperty('creditsText.text', 'Screw you!') end
	if string.lower(songName) == 'maze' then
		songMod = 'Dave and Bambi';
		setProperty('healthBarBG.visible', false)
		makeLuaSprite('healthBarBGnew', 'daveHealth', getProperty('healthBar.x'), getProperty('healthBar.y'))
		setObjectCamera('healthBarBGnew', 'camHUD')
		addLuaSprite('healthBarBGnew', false)
		setObjectOrder('healthBarBGnew', getObjectOrder('healthBar') + 1)
	
		createIcons()
		return;
	end

	if getProperty('creditsText.text') == '' and string.lower(songName) ~= 'kooky' then
		setProperty('creditsWatermark.y', getProperty('healthBar.y') + 50)
	elseif string.lower(songName) ~= 'kooky' then
		setProperty("creditsWatermark.y", getProperty("healthBar.y") + 30)
	end

	makeLuaSprite('healthBarBGnew', 'healthBarOverlay', getProperty('healthBar.x'), getProperty('healthBar.y') +5)
	scaleObject('healthBarBGnew', getProperty('healthBar.scale.x') - 0.075, getProperty('healthBar.scale.y') - 0.15)
	setObjectCamera('healthBarBGnew', 'camHUD')
	addLuaSprite('healthBarBGnew', false)
	setObjectOrder('healthBarBGnew', getObjectOrder('healthBar') + 1)

	if string.lower(songName) == 'kooky' then
		setProperty('healthBarBGnew.visible', false)
	end

	if downscroll then
		setProperty("iconP1.y", getProperty('healthBar.y') -75)
		setProperty("iconP2.y", getProperty('healthBar.y') -75)
	end

	createIcons()

	setProperty("updateTime", false)
			
	setObjectOrder('scoreTxt', getObjectOrder('healthBar') -1)
	setProperty("timeTxt.y", getProperty("timeTxt.y") - 10)
	--setObjectOrder('timeTxt', 99)

	local chars3D = {false, false}

	for i = 1, #CharactersWith3D do
		if string.lower(CharactersWith3D[i]) == string.lower(getProperty("boyfriend.curCharacter")) then 
			changeNoteSkin(true, 'NOTE_assets_3D')
			chars3D[1] = true;
		end
		if string.lower(CharactersWith3D[i]) == string.lower(getProperty("dad.curCharacter")) then 
			changeNoteSkin(false, 'NOTE_assets_3D')
			chars3D[2] = true;
		end
	end

	for i = 0, getProperty('unspawnNotes.length')-1 do
		setPropertyFromGroup('unspawnNotes', i, 'hitHealth', 0.023)
		if getPropertyFromGroup('unspawnNotes', i, 'isSustainNote') then
			setPropertyFromGroup('unspawnNotes', i, 'hitHealth', 0.004)
		end
		setPropertyFromGroup('unspawnNotes', i, 'missHealth', 0.04 + 0.075)
		if getPropertyFromGroup('unspawnNotes', i, 'isSustainNote') then
			setPropertyFromGroup('unspawnNotes', i, 'missHealth', 0)
		end
		if ((chars3D[2] or chars3D[1]) and ((getPropertyFromGroup('unspawnNotes', i, 'strumTime') / 50) % 20 > 10)) then
			setPropertyFromGroup('unspawnNotes', i, 'texture', 'noteSkins/NOTE_assets_3D')
		end
	end

	if gappleHUDsong then
		return;
	end
	gappleHUDsong = true;
end

local canMessWithDups = false;

function createIcons()
	canMessWithDups = false;
	if luaSpriteExists("iconP12") then
		cancelTween("iconMovementP1")
		cancelTween("iconMovementP2")
		setProperty("iconP12.visible", false)
		setProperty("iconP22.visible", false)
	end
	setProperty("iconP1.visible", false)
	setProperty("iconP2.visible", false)
	runHaxeCode([[
		var iconP12 = new HealthIcon(game.boyfriend.healthIcon, true);
		iconP12.x = game.iconP1.x;
		iconP12.y = game.iconP1.y;
        game.add(iconP12);
        game.modchartSprites.set('iconP12', iconP12);
		var iconP22 = new HealthIcon(game.dad.healthIcon, false);
		iconP22.x = game.iconP2.x;
		iconP22.y = game.iconP2.y;
        game.add(iconP22);
        game.modchartSprites.set('iconP22', iconP22);
	]])
	setObjectOrder('iconP12', getObjectOrder('healthBarBGnew') + 1)
	setObjectOrder('iconP22', getObjectOrder('iconP12') + 1)
	setObjectCamera("iconP12", 'hud')
	setObjectCamera("iconP22", 'hud')
	canMessWithDups = true;
end

function changeNoteSkin(player, skin)
	if player == true then
		for i = 0, 4, 1 do
			setPropertyFromGroup('playerStrums', i, 'texture', 'noteSkins/'..skin)
		end
	end
    if not player then
		for i = 0, 4, 1 do
			setPropertyFromGroup('opponentStrums', i, 'texture', 'noteSkins/'..skin)
		end
	end

    for i = 0, getProperty('notes.length') -1 do
        if getPropertyFromGroup('notes', i, 'mustPress') == player then --only "player" side
            setPropertyFromGroup('notes', i, 'texture', 'noteSkins/'..skin)
        end
    end

    for i = 0, getProperty('unspawnNotes.length') -1 do
        if getPropertyFromGroup('unspawnNotes', i, 'mustPress') == player then --only "player" side
            setPropertyFromGroup('unspawnNotes', i, 'texture', 'noteSkins/'..skin)
        end
    end
end

function iconPropertys()
	if not canMessWithDups then return; end
	local props = {'alpha'}
	for i = 1, #props do
		setProperty("iconP12."..props[i], getProperty('iconP1.'..props[i]))
		setProperty("iconP22."..props[i], getProperty('iconP2.'..props[i]))
	end
end

function math.lerp(from, to, t)
	return from + (to - from) * math.clamp(t, 0, 1)
end
function math.clamp(x,min,max)return math.max(min,math.min(x,max))end
function string.duplicate(s, i)
    local str = ""
    for i = 1, i do str = str .. s end
    return str
end
string.dupe = string.duplicate
local zero = "0"
function math.toTime(x, includeMS, blankIfNotExist)
    local abs = math.abs(x)
    local int = math.floor(abs)
    
    local ms = tostring(abs - int):sub(2, 5)
    ms = ms .. zero:duplicate(math.floor(math.clamp(4 - #ms, 0, 3)))
    
    local s = tostring(math.fmod(int, 60))
    if (#s == 1) then s = zero .. s end
    
    local m = tostring(math.fmod(math.floor(int / 60), 60))
    if (#m == 1 and (blankIfNotExist or int >= 3600)) then m = zero .. m end
    
    local h = tostring(math.floor(int / 3600))
    
    local r = m .. ":" .. s
    if (int >= 3600) then r = h .. ":" .. r end
    
    return (x < 0 and "-" or "") .. (includeMS and r .. ms or r)
end
--NO MORE INTERNET NEEDED

local singAnims = {'singLEFT', 'singDOWN', 'singUP', 'singRIGHT'}
local boyfriendHasMissAnims = false;
local actualSongLength = 0;
local songPos = 0;

function onUpdate(elapsed)
	setProperty("iconP12.animation.curAnim.curFrame", getProperty("iconP1.animation.curAnim.curFrame"))
    setProperty("iconP22.animation.curAnim.curFrame", getProperty("iconP2.animation.curAnim.curFrame"))
	if canMessWithDups then
		doTweenX("iconMovementP1", "iconP12", getProperty("iconP1.x"), 0.1, "sineInOut")
		doTweenX("iconMovementP2", "iconP22", getProperty("iconP2.x"), 0.1, "sineInOut")
	end
	if stringStartsWith(version, '0.7') then
		for i = 0, getProperty("strumLineNotes.length") do
			setPropertyFromGroup('strumLineNotes', i, 'rgbShader.enabled', false)
		end
		for i = 0, getProperty("notes.length") do
			setPropertyFromGroup('notes', i, 'rgbShader.enabled', false)
		end
    end
	setProperty('healthBarBGnew.alpha', getProperty('healthBar.alpha'))
	actualSongLength = math.toTime(getProperty("songLength") / 1000);
	songPos = math.toTime(getSongPosition() / 1000)

	if gappleHUDsong then
		iconPropertys()
		setProperty('timeBarBG.visible', false)
		setProperty('timeBar.visible', false)
		setTextString('timeTxt', songPos.." / "..actualSongLength)
	end

	for i = 1, #singAnims do
		boyfriendHasMissAnims = getProperty('boyfriend.hasMissAnimations')
		if getProperty('boyfriend.animation.curAnim.name') == 'idle' and getProperty('boyfriend.color') == getColorFromHex('9400d3') then
			setProperty('boyfriend.color', getColorFromHex('FFFFFF'))
		end
	end

	if stringStartsWith(version, '0.6') then
		playAnim("gappleSoundTray", ""..math.max(getPropertyFromClass("flixel.FlxG", "sound.volume") * 10) + 1, false)

		runHaxeCode([[
			var volumeUP = ClientPrefs.copyKey(ClientPrefs.keyBinds.get('volume_up'));
			var volumeDOWN = ClientPrefs.copyKey(ClientPrefs.keyBinds.get('volume_down'));
			var volumeMUTE = ClientPrefs.copyKey(ClientPrefs.keyBinds.get('volume_mute'));
	
			if (FlxG.keys.anyJustPressed(volumeUP) || FlxG.keys.anyJustPressed(volumeDOWN) || FlxG.keys.anyJustPressed(volumeMUTE)) {
				game.getLuaObject('gappleSoundTray').visible = true;
			}
				
			if (FlxG.sound.muted)
				game.getLuaObject('gappleSoundTray', false).animation.play('1');
	
			game.getLuaObject('gappleSoundTray', false).centerOffsets();
			game.getLuaObject('gappleSoundTray', false).centerOrigin();
		]])
    end

	--setProperty('camHUD.x', math.sin((getSongPosition() / 1200) * (getPropertyFromClass("Conductor", "bpm") / 60) * -1.0) * 50)
	--setProperty('camHUD.y', math.sin((getSongPosition() / 1000) * (getPropertyFromClass("Conductor", "bpm") / 60) * 1.0) * 15)
	--setProperty('camHUD.angle', math.sin((getSongPosition() / 1200) * (getPropertyFromClass("Conductor", "bpm") / 60) * -1.0) * 1.2)
end

local offsets = {-13, -13}--{55, 43}

function onUpdatePost(elapsed)
	if string.lower(songName) == 'maze' or gappleHUDsong then
		if gappleHUDsong then
			iconPropertys()
		end

		if string.lower(songName) ~= 'kooky' then
			setProperty('healthBar.y', screenHeight * 0.9 + 4)
			--setProperty('healthBar.x', screenHeight * 0.4)
			if stringStartsWith(version, '0.7') then
				setProperty('healthBarBGnew.y', screenHeight * 0.9 +5)
				setProperty('healthBarBGnew.x', getProperty('healthBar.x'))
			else
				setProperty('healthBarBGnew.y', screenHeight * 0.9 +2)
				setProperty('healthBarBGnew.x', getProperty('healthBar.x') -5)
			end
			setProperty('scoreTxt.y', getProperty('healthBar.y') + 40)
		end
		if downscroll then
			setProperty('healthBar.y', 54)
			--setProperty('healthBar.x', getProperty('healthBar.x') + 4)
			setProperty('healthBarBGnew.y', getProperty('healthBar.y') + 5.25)
			setProperty('healthBarBGnew.x', getProperty('healthBar.x') + 4)
		end
		if getProperty('creditsText.text') == '' and string.lower(songName) ~= 'kooky' then
			setProperty('creditsWatermark.y', getProperty('healthBar.y') + 46)
		elseif string.lower(songName) ~= 'kooky' then
			setProperty("creditsWatermark.y", getProperty("healthBar.y") + 30)
		end

		if gappleHUDsong then
			setTextString("fpsTxt", "FPS: "..getPropertyFromClass("Main", "fpsVar.currentFPS"))
			setTextString("memoryTxt", "Memory: "..math.abs(math.floor(getPropertyFromClass("openfl.system.System", "totalMemory") / 1000000, 1)).." MB")

			if getDataFromSave("Juniors Ports Stuff", "debugMode") then setTextString("fpsTxt", getTextString("fpsTxt").." - DEBUG MODE") end
			if getDataFromSave("Juniors Ports Stuff", "settingsAlert") then setTextString("fpsTxt", getTextString("fpsTxt").." - CHANGE SETTINGS IN 'mod folder/scripts/settings.lua' TO DISABLE THIS!!") end
		end
		setTextString('scoreTxt', "Score:"..tostring(score).." | Misses:"..tostring(getProperty('songMisses')).." | Accuracy:"..tostring(math.floor(getProperty('ratingPercent') * 100, 2)).."%")
		if string.lower(songName) == 'kooky' then
			setTextString('scoreTxt', "Score:\n"..tostring(score).."\n\n\n\nMisses:\n"..tostring(getProperty('songMisses')).."\n\n\nAccuracy:\n"..tostring(math.floor(getProperty('ratingPercent') * 100, 2)).."%")
		end
		if string.lower(songName) == 'maze' then
			local thingy = 0.8;
			setGraphicSize('iconP22', math.floor(math.lerp(150, getProperty('iconP22.width'), thingy)), math.floor(math.lerp(150, getProperty('iconP22.height'), thingy)))
			setGraphicSize('iconP12', math.floor(math.lerp(150, getProperty('iconP12.width'), thingy)), math.floor(math.lerp(150, getProperty('iconP12.height'), thingy)))
			updateHitbox('iconP12')
			updateHitbox('iconP22')
		end
	end
end

function onStepHit()
	if stringStartsWith(version, '0.7') then
		changeDiscordPresence(songName.." ("..songMod..") - Junior's Funny Mod Folder Ports", "S: "..tostring(score).." | M: "..tostring(getProperty('songMisses')).." | A: "..tostring(math.floor(getProperty('ratingPercent') * 100, 2)).."%")
		changeDiscordPresence(songName.." ("..songMod..") - Junior's Funny Mod Folder Ports", "S: "..tostring(score).." | M: "..tostring(getProperty('songMisses')).." | A: "..tostring(math.floor(getProperty('ratingPercent') * 100, 2)).."%".." ("..songPos.." / "..actualSongLength..")")
    else
		changePresence(songName.." ("..songMod..") - Junior's Funny Mod Folder Ports", "S: "..tostring(score).." | M: "..tostring(getProperty('songMisses')).." | A: "..tostring(math.floor(getProperty('ratingPercent') * 100, 2)).."%")
		changePresence(songName.." ("..songMod..") - Junior's Funny Mod Folder Ports", "S: "..tostring(score).." | M: "..tostring(getProperty('songMisses')).." | A: "..tostring(math.floor(getProperty('ratingPercent') * 100, 2)).."%".." ("..songPos.." / "..actualSongLength..")")
	end

	--setObjectOrder('strumLineNotes', getObjectOrder('notes') +1) --puts notes under strumlinenotes

	for i = 0, getProperty('notes.length') do --why doesn't psych do this already???
        for iStrum = 0, 3 do
            if getPropertyFromGroup('notes', i, 'mustPress') then
                setPropertyFromGroup('notes', i, 'scale.x', getPropertyFromGroup('playerStrums', getPropertyFromGroup('notes', i, 'noteData'), 'scale.x'))
				if getPropertyFromGroup('notes', i, 'isSustainNote') ~= true then
                	setPropertyFromGroup('notes', i, 'scale.y', getPropertyFromGroup('playerStrums', getPropertyFromGroup('notes', i, 'noteData'), 'scale.y'))
				end
            else
                setPropertyFromGroup('notes', i, 'scale.x', getPropertyFromGroup('opponentStrums', getPropertyFromGroup('notes', i, 'noteData'), 'scale.x'))
				if getPropertyFromGroup('notes', i, 'isSustainNote') ~= true then
                	setPropertyFromGroup('notes', i, 'scale.y', getPropertyFromGroup('opponentStrums', getPropertyFromGroup('notes', i, 'noteData'), 'scale.y'))
				end
            end
        end
    end
end

function onSectionHit()
	if gappleHUDsong then
		cancelTween('timeTxtScaleX')
		cancelTween('timeTxtScaleY')
		setProperty('timeTxt.scale.x', 1.1)
		setProperty('timeTxt.scale.y', 1.1)
		doTweenX('timeTxtScaleX', 'timeTxt.scale', 1, 0.2)
		doTweenY('timeTxtScaleY', 'timeTxt.scale', 1, 0.2)
	end
end

function onBeatHit()
	if string.lower(songName) == 'maze' then
		local funny = math.max(math.min(getProperty('healthBar.value'), 1.9), 0.1)
		setGraphicSize('iconP12', math.floor(getProperty('iconP12.width') + (50 * funny)), math.floor(getProperty('iconP12.height') - (25 * funny)))
		setGraphicSize('iconP22', math.floor(getProperty('iconP22.width') + (50 * ((2 - funny) + 0.1))), math.floor(getProperty('iconP22.height') - (25 * ((2 - funny) + 0.1))))

		updateHitbox('iconP12')
		updateHitbox('iconP22')
		updateHitbox('iconP1')
		updateHitbox('iconP2')
		iconPropertys()
	end

	if gappleHUDsong then
		if string.lower(songName) == 'kooky' or string.lower(songName) == 'maze' then
			return;
		end
		local iconPos = getProperty('healthBar.y') -75;

		if curBeat % getProperty('gfSpeed') == 0 then
			local fuasd = {0.8, 1.3}
			local angl = 15;
			local yOffset = 20;

			if curBeat % (getProperty('gfSpeed') * 2) == 0 then
				scaleObject('iconP12', 1.1, fuasd[1])
				scaleObject('iconP22', 1.1, fuasd[2])
				setProperty('iconP12.angle', -angl)
				setProperty('iconP22.angle', angl)
				setProperty('iconP12.y', iconPos - yOffset)
				setProperty('iconP22.y', iconPos + yOffset)
			else
				scaleObject('iconP12', 1.1, fuasd[2])
				scaleObject('iconP22', 1.1, fuasd[1])
				setProperty('iconP12.angle', angl)
				setProperty('iconP22.angle', -angl)
				setProperty('iconP12.y', iconPos + yOffset)
				setProperty('iconP22.y', iconPos - yOffset)
			end
		end

		doTweenY('iconP1yREAL', 'iconP12', iconPos, crochet / 1300 * getProperty('gfSpeed'), 'quadOut')
		doTweenY('iconP2yREAL', 'iconP22', iconPos, crochet / 1300 * getProperty('gfSpeed'), 'quadOut')
		doTweenAngle('iconP1', 'iconP12', 0, crochet / 1300 * getProperty('gfSpeed'), 'quadOut')
		doTweenAngle('iconP2', 'iconP22', 0, crochet / 1300 * getProperty('gfSpeed'), 'quadOut')
		doTweenX('iconP1x', 'iconP12.scale', 1, crochet / 1250 * getProperty('gfSpeed'), 'quadOut')
		doTweenX('iconP2x', 'iconP22.scale', 1, crochet / 1250 * getProperty('gfSpeed'), 'quadOut')
		doTweenY('iconP1y', 'iconP12.scale', 1, crochet / 1250 * getProperty('gfSpeed'), 'quadOut')
		doTweenY('iconP2y', 'iconP22.scale', 1, crochet / 1250 * getProperty('gfSpeed'), 'quadOut')

		updateHitbox('iconP12')
		updateHitbox('iconP22')
		iconPropertys()
	end
	if curBeat % 2 == 0 then
		if getProperty('boyfriend.animation.curAnim.name') == 'idle' then
			playAnim('boyfriend', 'idle', true)
		end

		if getProperty('dad.animation.curAnim.name') == 'idle' then
			if dadName == 'bambi-piss-3d' or dadName == 'garrett-animal' then
				return;
			end
			playAnim('dad', 'idle', true)
		end
	end
end

function onEvent(eventName, value1, value2, strumTime)
	if eventName == 'Change Character' then
		createIcons()
	end
end

function goodNoteHit(id, direction, noteType, isSustainNote)
	if getProperty('boyfriend.color') == getColorFromHex('9400d3') then
		setProperty('boyfriend.color', getColorFromHex('FFFFFF'))
	end
	
	if no_splashes then
		removeFromGroup('grpNoteSplashes', getProperty('grpNoteSplashes.length') -1, false); --insta killed
	end
end

function noteMissPress(direction)
	noteMissedStuff(direction)
end

function noteMiss(id, direction, noteType, isSustainNote)
	noteMissedStuff(direction)
end

function noteMissedStuff(direction)
	if boyfriendHasMissAnims ~= false then
		return;
	end
	playAnim('boyfriend', singAnims[direction+1], true);
	setProperty('boyfriend.color', getColorFromHex('9400d3'))
	setProperty('boyfriend.holdTimer', 0)
	prevAnim = getProperty('boyfriend.animation.curAnim.name')
end