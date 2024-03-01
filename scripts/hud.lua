local gappleMemoryCounter = true; --gapple doesn't have a memory counter... ITS REAL LANCE YPOSTED  IYT OPMGGGG	--doesnt matter
local volumeKeybind = {"PLUS","MINUS","ZERO"}

local CharactersWith3D = {'bambi-unfair', 'bambi-piss-3d', 'bandu', 'bandu-sad', 'tunnel-dave', 'badai', 'unfair-junker', 'split-dave-3d', 'garrett', '3d-bf', '3d-bf-flipped', 'shoulder-bf', 'garrett-animal', 'playtime', 'palooseMen', 'garrett-ipad', 'wizard', 'piano-guy', 'pedophile', 'garrett-angry', 'garrett-car',
'bandu-candy', 'dinnerbambi', 'insanidave', 'bamb-root', 'sart-producer', 'sart-producer-glitch', 'ticking', 'fat-bandu-3d', 'gary', '3d-bambi-leak', 'bandu-trolled', 'sammy', 
'duelExpunged', '3d-bambi-leak-finale', 'og-dave', 'og-dave-angey', 'spike', 'spike-bg', 'playrobot', 'playrobot-crazy', 'hall-monitor', 'diamond-man', 'too-shiny', 'dave-wide', 'awesomeBambiCrack',
'brob', 'barbu', 'gfreddy', 'cameo', 'facecam', 'bandu-card', 'alge', 'butch', 'bad', "3d-tristan", 'dambai', 'dambu', 'dale', 'dingle', 'froing', 'scratchman-3d', 'wug'}

local badaiSongs = {
	["applecore"] = 'bambi-piss-3d',
	["fresh-and-toasted"] = 'barbu',
	["resumed"] = 'dambu',
	["the-big-dingle"] = 'donk',
	['apple-leak'] = "cheating-4-leak2d"
}

function onCreate()
	if stringStartsWith(version, '0.7') then setProperty("SONG.disableNoteRGB", true) end
	makeLuaSprite('thunderBlack', '', 0, 0)
	makeGraphic('thunderBlack', '1280', '720', '000000')
	setProperty('thunderBlack.alpha', 0)
	setObjectCamera("thunderBlack", "hud")
	updateHitbox("thunderBlack")
	screenCenter("thunderBlack", 'xy')
	addLuaSprite('thunderBlack', true)

	if string.lower(songName) ~= 'apple-leak' then 
		precacheImage("ui/notes/NOTE_assets")
		precacheImage("ui/notes/NOTE_assets_3D")
	end
end

local oldFPS = 60;
local overrideFPS = 126;
local vol = 0.0;
local arrowOffset = 30;

function onCreatePost()
	setProperty('showComboNum', false)
    setProperty("showRating", false)
    setProperty('showCombo', false)
	if string.lower(songName) ~= 'apple-leak' then
		makeLuaSprite("iconP12", "icons/missing", 0, 0)
		makeLuaSprite("iconP22", "icons/missing", 0, 0)
	end

	makeLuaText('creditsWatermark', songName, 0, 4, 698)
	setObjectCamera('creditsWatermark', 'camHUD')
	setTextAlignment('creditsWatermark', 'center')
	setTextFont('creditsWatermark', 'comic.ttf')
	setTextSize('creditsWatermark', 16)
	setTextBorder('creditsWatermark', 1.5, '000000')
	setProperty('creditsWatermark.antialiasing', false)
	updateHitbox('creditsWatermark')
	addLuaText('creditsWatermark')

	if string.lower(songName) == 'fresh-and-toasted' then setTextString("creditsWatermark", 'Fresh And Toasted') end
	if string.lower(songName) == 'nice' then setTextString("creditsWatermark", getTextString("creditsWatermark")..'!') end
	if string.lower(songName) == 'the-big-dingle' then setTextString("creditsWatermark", 'The Big Dingle') end
	if string.lower(songName) == 'the-scratches' then setTextString("creditsWatermark", 'The Scratches') end
	if string.lower(songName) == 'og' then setTextString("creditsWatermark", 'OG Legacy - KE 1.2') end
	if string.lower(songName) == 'apple-leak' then setTextString("creditsWatermark", 'Apple Leak') end

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

	if not lowQuality and string.lower(songName) ~= 'kooky' then
		makeLuaSprite('healthBarBGnew', 'healthBarOverlay', getProperty('healthBar.x'), getProperty('healthBar.y') +5)
		--scaleObject('healthBarBGnew', getProperty('healthBar.scale.x'), getProperty('healthBar.scale.y'))
		setObjectCamera('healthBarBGnew', 'hud')
		addLuaSprite('healthBarBGnew', false)
		setObjectOrder('healthBarBGnew', getObjectOrder("healthBar"))
		setGraphicSize("healthBarBGnew", getProperty("healthBar.width"), getProperty("healthBarBGnew.height") -1)
		updateHitbox("healthBarBGnew")
	end

	if downscroll then
		setProperty("iconP1.y", getProperty('healthBar.y') -108)
		setProperty("iconP2.y", getProperty('healthBar.y') -108)
	end

	setProperty("updateTime", false)
	setTextFont('scoreTxt', 'comic.ttf')
	setProperty('timeBarBG.visible', false)
	setProperty('timeBar.visible', false)
	setTextFont('timeTxt', 'comic.ttf')
	setTextSize("timeTxt", getTextSize("timeTxt"))
	--setProperty("timeTxt.y", getProperty("timeTxt.y") - 10)

	if badaiSongs[string.lower(songName)] ~= nil then
		runHaxeCode([[
			var badai = new Character(0, 0, ']]..badaiSongs[string.lower(songName)]..[[');
			game.add(badai);
			game.startCharacterLua(']]..badaiSongs[string.lower(songName)]..[[');
			game.modchartSprites.set('badai', badai);
		]])
		runHaxeCode([[game.callOnLuas("onBadaiCreate", []);]]) --callOnLuas inside of lua is broken?
	end
	makeAnimatedLuaSprite('gappleTransition', 'transition', 0, 0)
	addAnimationByPrefix("gappleTransition", "start", "Symbol 1", 30, false)
	setObjectCamera("gappleTransition", "other")
	updateHitbox("gappleTransition")
	screenCenter("gappleTransition", 'xy')
	addLuaSprite('gappleTransition', true)

	if stringStartsWith(version, '0.6') then oldFPS = getPropertyFromClass("ClientPrefs", "framerate") else oldFPS = getPropertyFromClass("backend.ClientPrefs", "data.framerate") end
	if stringStartsWith(version, '0.6') then setPropertyFromClass('ClientPrefs', 'framerate', overrideFPS) else setPropertyFromClass('backend.ClientPrefs', 'data.framerate', overrideFPS) end
	runHaxeCode([[
		var framerate = ]]..overrideFPS..[[;
		if(framerate > FlxG.drawFramerate) {
			FlxG.updateFramerate = framerate;
			FlxG.drawFramerate = framerate;
		} else {
			FlxG.drawFramerate = framerate;
			FlxG.updateFramerate = framerate;
		}
	]])

	makeLuaText('fpsTxt', '', 0, 18, 6)
	setObjectCamera('fpsTxt', 'other')
	setTextAlignment('fpsTxt', 'center')
	setTextFont('fpsTxt', 'comic.ttf')
	setTextSize('fpsTxt', 24)
    runHaxeCode([[game.getLuaObject('fpsTxt').setBorderStyle(Type.resolveEnum('flixel.text.FlxTextBorderStyle').NONE);]]) --Collin09 POG
	setProperty('fpsTxt.antialiasing', true)
	if stringStartsWith(version, '0.6') then
		setProperty("fpsTxt.visible", getPropertyFromClass('ClientPrefs', 'showFPS'))
    else
		setProperty("fpsTxt.visible", getPropertyFromClass('backend.ClientPrefs', 'data.showFPS'))
    end
	updateHitbox('fpsTxt')
	addLuaText('fpsTxt')
	--[[makeLuaText('memoryTxt', '', 0, 18, 32)
	setObjectCamera('memoryTxt', 'other')
	setTextAlignment('memoryTxt', 'center')
	setTextFont('memoryTxt', 'comic.ttf')
	setTextSize('memoryTxt', 16)
	--runHaxeCode([[game.getLuaObject('memoryTxt').setBorderStyle(Type.resolveEnum('flixel.text.FlxTextBorderStyle').NONE);]]--) --Collin09 POG
	--[[setProperty('memoryTxt.antialiasing', true)
	if stringStartsWith(version, '0.6') then
		setProperty("memoryTxt.visible", getPropertyFromClass('ClientPrefs', 'showFPS'))
    else
		setProperty("memoryTxt.visible", getPropertyFromClass('backend.ClientPrefs', 'data.showFPS'))
    end
	updateHitbox('memoryTxt')
	if gappleMemoryCounter then addLuaText('memoryTxt') end--]]

	if stringStartsWith(version, '0.6') then setPropertyFromClass("Main", "fpsVar.visible", false) else setPropertyFromClass("Main", "fpsVar.visible", false) end
	setPropertyFromClass('flixel.FlxG', 'sound.soundTrayEnabled', false)

	makeLuaSprite("gappleSoundTray", "soundtray", screenWidth, 0)
	setObjectCamera("gappleSoundTray", "other")
	screenCenter("gappleSoundTray", 'y')
	addLuaSprite("gappleSoundTray", false)
	makeLuaSprite("gappleSoundTrayArrow", "arrow", screenWidth, 0)
	setObjectCamera("gappleSoundTrayArrow", "other")
	addLuaSprite("gappleSoundTrayArrow", false)
	vol = math.floor(getPropertyFromClass('flixel.FlxG', 'sound.volume') * 10)

	playAnim("gappleTransition", "start")
	runTimer("gappleTransitionStart", 3 / playbackRate)

	makeLuaText("ratingTxt", "Sick!\n1", 0, 0.0, 64)
    setTextFont("ratingTxt", "comic.ttf")
    screenCenter("ratingTxt", 'x')
    setProperty("ratingTxt.x", getProperty("ratingTxt.x") - 10)
    setTextSize("ratingTxt", 36)
    setTextBorder("ratingTxt", 2, "000000")
    addLuaText("ratingTxt")
    setProperty("ratingTxt.alpha", 0)
	if downscroll then setProperty("ratingTxt.y", 570) end

	for i = 0, getProperty('unspawnNotes.length')-1 do --one off thing
		if not getPropertyFromGroup("unspawnNotes", i, 'isSustainNote') then setPropertyFromGroup('unspawnNotes', i, 'hitHealth', getPropertyFromGroup("unspawnNotes", i, 'hitHealth') * 0.8) else setPropertyFromGroup('unspawnNotes', i, 'hitHealth', getPropertyFromGroup("unspawnNotes", i, 'hitHealth') * 0.3) end
		if stringStartsWith(version, '0.7') then setPropertyFromGroup('unspawnNotes', i, 'rgbShader.enabled', false) end
		if stringStartsWith(version, '0.7') then setPropertyFromGroup('unspawnNotes', i, 'noteSplashData.disabled', true) else setPropertyFromGroup('unspawnNotes', i, 'noteSplashDisabled', true) end
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == '' or getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'normal' or getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'No Animation' or getPropertyFromGroup('unspawnNotes', i, 'noteType') == nil then 
			if getPropertyFromGroup('unspawnNotes', i, 'mustPress') == false then 
				setPropertyFromGroup('unspawnNotes', i, 'noAnimation', true)
			end
		end
	end

	setProperty("gappleSoundTrayArrow.y", getProperty("gappleSoundTray.y") + (300 + arrowOffset - (arrowOffset * (vol + 1))), 0.25, "sineInOut")
	if getPropertyFromClass('flixel.FlxG', 'sound.muted') then setProperty("gappleSoundTrayArrow.y", "gappleSoundTrayArrow", getProperty("gappleSoundTray.y") + (300 + arrowOffset - (arrowOffset * (vol + 1))), 0.25, "sineInOut") end
end

function badaiPlayAnim(anim)
	runHaxeCode([[
		game.getLuaObject("badai", false).playAnim("]]..anim..[[", true);
		if ("]]..anim..[[" == "dance")
			game.getLuaObject("badai", false).dance();
	]])
end

local donezo = false;

function onStrumsCreate()
	if donezo then return; end
	for i = 0, 3 do
		setPropertyFromGroup("opponentStrums", i, "x", getPropertyFromGroup("opponentStrums", i, "x") - 35)
		setPropertyFromGroup("playerStrums", i, "x", getPropertyFromGroup("playerStrums", i, "x") + 40) -- 5 more than opponentStrums
	end
	donezo = true;
end

function changeNoteSkinsOnChange(idForPerson, onlyNotes)
	if string.lower(songName) == "apple-leak" or string.lower(songName) == 'kooky' or lowQuality then return; end
	local chars3D = {false, false}

	if idForPerson == 1 or idForPerson == nil then
		for i = 1, #CharactersWith3D do
			if string.lower(CharactersWith3D[i]) == string.lower(getProperty("boyfriend.curCharacter")) then
				setProperty("boyfriend.antialiasing", false)
				changeNoteSkin(true, 'NOTE_assets_3D', onlyNotes)
				for i = 0, 3 do
					setPropertyFromGroup("playerStrums", i, "antialiasing", false)
				end
				chars3D[1] = true;
				break;
			else
				changeNoteSkin(true, 'NOTE_assets', onlyNotes)
				for i = 0, 3 do
					setPropertyFromGroup("playerStrums", i, "antialiasing", true)
				end
			end
		end
	end
	if idForPerson == 2 or idForPerson == nil then
		for i = 1, #CharactersWith3D do
			if string.lower(CharactersWith3D[i]) == string.lower(getProperty("dad.curCharacter")) then
				setProperty("dad.antialiasing", false)
				changeNoteSkin(false, 'NOTE_assets_3D', onlyNotes)
				for i = 0, 3 do
					setPropertyFromGroup("opponentStrums", i, "antialiasing", false)
				end
				chars3D[2] = true;
				break;
			else
				changeNoteSkin(false, 'NOTE_assets', onlyNotes)
				for i = 0, 3 do
					setPropertyFromGroup("opponentStrums", i, "antialiasing", true)
				end
			end
		end
	end
	for i = 0, getProperty('unspawnNotes.length')-1 do --one off thing
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == '' or getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'normal' or getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'No Animation' or getPropertyFromGroup('unspawnNotes', i, 'noteType') == nil then 
			if ((chars3D[2] or chars3D[1]) and ((getPropertyFromGroup('unspawnNotes', i, 'strumTime') / 50) % 20 > 10)) then
				setPropertyFromGroup('unspawnNotes', i, 'texture', 'ui/notes/NOTE_assets_3D')
			end
		end
	end
end

function onEvent(eventName, value1, value2, strumTime)
	if eventName == 'Change Character' and string.lower(songName) ~= 'badcorn' then
		if string.lower(value1) == "bf" then 
			changeNoteSkinsOnChange(1, false)
			changeNoteSkinsOnChange(2, true)
		end
		if string.lower(value1) == "dad" then 
			changeNoteSkinsOnChange(1, true)
			changeNoteSkinsOnChange(2, false)
		end
		--[[changeNoteSkinsOnChange(1)
		changeNoteSkinsOnChange(2)--]]
		--[[if string.lower(value1) == "bf" then changeNoteSkinsOnChange(1) end --changing both because of one character change = lag --nvm this was incase other character was 3d
		if string.lower(value1) == "dad" then changeNoteSkinsOnChange(2) end--]]
		if string.lower(value1) == 'badai' then
			runHaxeCode([[
				game.getLuaObject('badai', false).destroy();
				var badai = new Character(0, 0, ']]..value2..[[');
				game.add(badai);
				game.startCharacterLua(']]..value2..[[');
				game.modchartSprites.set('badai', badai);
			]])
		end
	end
end

local objectsCountown = {'countdownReady', 'countdownSet', 'countdownGo'}

function onCountdownTick(swagCounter)
	if swagCounter == 3 then
		runHaxeCode([[
			if (game.boyfriend.animOffsets.exists("hey"))
				game.boyfriend.playAnim("hey");
			else
				game.boyfriend.playAnim("singUP");
			end
		]])
		setProperty(objectsCountown[3]..".scale.x", 0)
		setProperty(objectsCountown[3]..".scale.y", 0)
		doTweenX("lastCountScaleX", objectsCountown[3]..".scale", 1.35, crochet / 2000 / getProperty("playbackRate"), "")
		doTweenY("lastCountScaleY", objectsCountown[3]..".scale", 1.35, crochet / 2000 / getProperty("playbackRate"), "")
	end
end

local hasFinishedExitTween = false;
local alreadyCreatedEnding = false;
function onEndSong()
	if not alreadyCreatedEnding then
		makeAnimatedLuaSprite('gappleTransition', 'transition', 0, 0)
		addAnimationByPrefix("gappleTransition", "start", "Symbol 1", 30, false)
		setObjectCamera("gappleTransition", "other")
		updateHitbox("gappleTransition")
		screenCenter("gappleTransition", 'xy')
		addLuaSprite('gappleTransition', true)
		scaleObject("gappleTransition", 1.05, 1.05)
		runTimer("gappleTransitionEnd", 1 / playbackRate)
		playAnim("gappleTransition", "start", true, true)
		alreadyCreatedEnding = true;
	end
	if not hasFinishedExitTween then
		return Function_Stop;
	else
		return Function_Continue;
	end
end

function onTweenCompleted(tag)
	if tag == 'lastCountScaleY' then
		doTweenX("lastCountScaleX2", objectsCountown[3]..".scale", 1, crochet / 2000 / getProperty("playbackRate"), "")
		doTweenY("lastCountScaleY2", objectsCountown[3]..".scale", 1, crochet / 2000 / getProperty("playbackRate"), "")
	end
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == "gappleTransitionStart" then removeLuaSprite("gappleTransition", true) end
	if tag == "gappleTransitionEnd" then hasFinishedExitTween = true; runHaxeCode([[game.endSong();]]) end
	if tag == "gappleSoundTrayExit" then doTweenX("gappleSoundTrayExit", "gappleSoundTray", screenWidth + 150, 1, "") end
end

function changeNoteSkin(player, skin, onlyNotes)
	if player == true and not onlyNotes then
		for i = 0, 4, 1 do
			setPropertyFromGroup('playerStrums', i, 'texture', 'ui/notes/'..skin)
			if stringStartsWith(version, '0.7') then
				setPropertyFromGroup('playerStrums', i, 'rgbShader.enabled', false)
				setPropertyFromGroup('playerStrums', i, 'useRGBShader', false)
			end
		end
	end
    if not player and not onlyNotes then
		for i = 0, 4, 1 do
			setPropertyFromGroup('opponentStrums', i, 'texture', 'ui/notes/'..skin)
			if stringStartsWith(version, '0.7') then
				setPropertyFromGroup('opponentStrums', i, 'rgbShader.enabled', false)
				setPropertyFromGroup('opponentStrums', i, 'useRGBShader', false)
			end
		end
	end

    for i = 0, getProperty('notes.length') -1 do
        if getPropertyFromGroup('notes', i, 'mustPress') == player then --only "player" side
            if getPropertyFromGroup('notes', i, 'noteType') == '' or getPropertyFromGroup('notes', i, 'noteType') == 'normal' or getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'No Animation' or getPropertyFromGroup('notes', i, 'noteType') == nil then setPropertyFromGroup('notes', i, 'texture', 'ui/notes/'..skin) end
        end
    end

    for i = 0, getProperty('unspawnNotes.length') -1 do
        if getPropertyFromGroup('unspawnNotes', i, 'mustPress') == player then --only "player" side
			if getPropertyFromGroup('unspawnNotes', i, 'noteType') == '' or getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'normal' or getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'No Animation' or getPropertyFromGroup('unspawnNotes', i, 'noteType') == nil then setPropertyFromGroup('unspawnNotes', i, 'texture', 'ui/notes/'..skin) end
        end
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

local alphaTimer = 0.0;
function onUpdate(elapsed)
	setProperty("gappleSoundTrayArrow.x", getProperty("gappleSoundTray.x") + 60)
	if keyboardJustPressed(volumeKeybind[3]) or keyboardJustPressed(volumeKeybind[2]) or keyboardJustPressed(volumeKeybind[1]) then
		if keyboardJustPressed(volumeKeybind[1]) then
			vol = vol +1;
			if vol > 10 then vol = 10; end
		end
		if keyboardJustPressed(volumeKeybind[2]) then
			vol = vol -1;
			if vol < 0 then vol = 0; end
		end
		cancelTween("gappleSoundTrayArrow")
		--doTweenY("gappleSoundTrayArrow", "gappleSoundTrayArrow", getProperty("gappleSoundTray.y") + (300 + arrowOffset - (arrowOffset * (vol + 1))), 0.25, "sineInOut")
		--if keyboardJustPressed(volumeKeybind[3]) then cancelTween("gappleSoundTrayArrow") doTweenY("gappleSoundTrayArrow", "gappleSoundTrayArrow", getProperty("gappleSoundTray.y") + (300 + arrowOffset - (25 * 1)), 0.25, "sineInOut") end
		--if keyboardJustPressed(volumeKeybind[3]) and getPropertyFromClass('flixel.FlxG', 'sound.muted') then cancelTween("gappleSoundTrayArrow") doTweenY("gappleSoundTrayArrow", "gappleSoundTrayArrow", getProperty("gappleSoundTray.y") + (300 + arrowOffset - (arrowOffset * (vol + 1))), 0.25, "sineInOut") end
		cancelTween("gappleSoundTrayExit")
		setProperty("gappleSoundTray.x", screenWidth - 150)
		cancelTimer("gappleSoundTrayExit")
		runTimer("gappleSoundTrayExit", 1 / playbackRate)
		playSound("clicky", 1)
    end
	setProperty("gappleSoundTrayArrow.y", getProperty("gappleSoundTray.y") + (300 + arrowOffset - (arrowOffset * (vol + 1))))
	if getPropertyFromClass('flixel.FlxG', 'sound.muted') then setProperty("gappleSoundTrayArrow.y", getProperty("gappleSoundTray.y") + (300 + arrowOffset - (25 * 1))) end
	
	if alphaTimer > 0 then
        alphaTimer = alphaTimer - (elapsed * playbackRate);
        if alphaTimer <= 0 then
            alphaTimer = 0;
            doTweenAlpha("ratingTxt", "ratingTxt", 0, .5 / playbackRate, "")
        end
    end
	setProperty('healthBarBGnew.alpha', getProperty('healthBar.alpha'))
	actualSongLength = math.toTime(getProperty("songLength") / 1000);
	songPos = math.toTime(getSongPosition() / 1000)

	if string.lower(songName) == "apple-leak" then setProperty("songLength", 786000) end
	if string.lower(songName) == "apple-leak" then actualSongLength = "13:06" end
	if string.lower(songName) == "apple-leak" and curStep >= 8608 then actualSongLength = "17:25" end

	local curTime = math.max(0, getSongPosition() - noteOffset)
	setProperty("songPercent", curTime / getProperty("songLength"))

	setTextString('timeTxt', songPos.." / "..actualSongLength)
	updateHitbox("timeTxt")
	screenCenter("timeTxt", 'x')

	boyfriendHasMissAnims = getProperty('boyfriend.hasMissAnimations')
	if getProperty('boyfriend.animation.curAnim.name') == 'idle' and getProperty('boyfriend.color') == getColorFromHex('9400d3') then
		setProperty('boyfriend.color', getColorFromHex('FFFFFF'))
	end

	--[[setProperty('camHUD.x', math.sin((getSongPosition() / 1200) * (getPropertyFromClass("Conductor", "bpm") / 60) * -1.0) * 50)
	setProperty('camHUD.y', math.sin((getSongPosition() / 1000) * (getPropertyFromClass("Conductor", "bpm") / 60) * 1.0) * 15)
	setProperty('camHUD.angle', math.sin((getSongPosition() / 1200) * (getPropertyFromClass("Conductor", "bpm") / 60) * -1.0) * 1.2)
	setProperty('camGame.zoom', getProperty("camGame.zoom") + (math.sin((getSongPosition() / 1200) * (getPropertyFromClass("Conductor", "bpm") / 60) * -1.0) * 0.01))--]]
end

function onUpdatePost(elapsed)
	if string.lower(songName) ~= 'kooky' then
		if downscroll then setProperty('healthBar.y', 54) else setProperty('healthBar.y', screenHeight * 0.9 + 4) end
		if not lowQuality then
			setProperty('healthBarBGnew.y', getProperty('healthBar.y') - 4)
			setProperty('healthBarBGnew.x', getProperty('healthBar.x'))
		end
		setProperty('scoreTxt.y', getProperty('healthBar.y') + 36)
		if songName ~= 'main-menu' then
			if getProperty('creditsText.text') == '' then
				setProperty('creditsWatermark.y', getProperty('healthBar.y') + 46)
			elseif string.lower(songName) ~= 'kooky' then
				setProperty("creditsWatermark.y", getProperty("healthBar.y") + 30)
			end
			setProperty('creditsText.y', getProperty('creditsWatermark.y') + 16)
		end
	end

	setTextString("fpsTxt", "FPS: "..getPropertyFromClass("Main", "fpsVar.currentFPS"))
	--setTextString("memoryTxt", "RAM Used: "..math.abs(math.floor(getPropertyFromClass("openfl.system.System", "totalMemory") / 1000000, 1)).." MB")

	setTextString('scoreTxt', "Score: "..tostring(score).." | Misses: "..tostring(getProperty('songMisses')).." | Accuracy: ")
	if string.lower(songName) == 'kooky' then
		setTextString('scoreTxt', "Score: \n"..tostring(score).."\n\n\n\nMisses: \n"..tostring(getProperty('songMisses')).."\n\n\nAccuracy: \n")
	end
	if stringStartsWith(version, '0.7') then runHaxeCode([[game.scoreTxt.text += '' + CoolUtil.floorDecimal(game.ratingPercent * 100, 2) + "%";]]) else runHaxeCode([[game.scoreTxt.text += '' + Highscore.floorDecimal(game.ratingPercent * 100, 2) + "%";]]) end
	if string.lower(songName) == "og" then
		if stringStartsWith(version, '0.7') then runHaxeCode([[setVar("AccuracyOG", CoolUtil.floorDecimal(game.ratingPercent * 100, 2));]]) else runHaxeCode([[setVar("AccuracyOG", Highscore.floorDecimal(game.ratingPercent * 100, 2));]]) end
		if (getProperty("AccuracyOG") >= 96 or getScore() == 0) and getMisses() == 0 then
			setTextString("scoreTxt", getProperty("scoreTxt.text").." | FC")
		elseif getMisses() == 0 then
			setTextString("scoreTxt", getProperty("scoreTxt.text").." | A")
		end
	end
	if luaSpriteExists("iconP12") then
		runHaxeCode([[
			var iconOffset = 26;
			setVar("playerIconPos", game.healthBar.x + (game.healthBar.width * (FlxMath.remapToRange(game.healthBar.percent, 0, 100, 100, 0) * 0.01)) + (150 * game.iconP1.scale.x - 150) / 2 - iconOffset);
			setVar("dadIconPos", game.healthBar.x + (game.healthBar.width * (FlxMath.remapToRange(game.healthBar.percent, 0, 100, 100, 0) * 0.01)) - (150 * game.iconP2.scale.x) / 2 - iconOffset * 2);
		]])
		doTweenX("iconMovementP12vhv", "iconP12", getProperty("playerIconPos"), 0.04, "sineInOut")
		doTweenX("iconMovementP22hvh", "iconP22", getProperty("dadIconPos"), 0.04, "sineInOut")
		iconPropertys()
	end
end

function iconPropertys()
	local props = {'scale.x', 'scale.y', 'x'}
	for i = 1, #props do
		setProperty("iconP1."..props[i], getProperty('iconP12.'..props[i]))
		setProperty("iconP2."..props[i], getProperty('iconP22.'..props[i]))
	end
end

function onStepHit()
	if stringStartsWith(version, '0.7') then
		changeDiscordPresence(songName.." - Untitled Gapple Port", "S: "..tostring(score).." | M: "..tostring(getProperty('songMisses')).." | A: "..tostring(math.floor(getProperty('ratingPercent') * 100, 2)).."%".." ("..songPos.." / "..actualSongLength..")")
    else
		changePresence(songName.." - Untitled Gapple Port", "S: "..tostring(score).." | M: "..tostring(getProperty('songMisses')).." | A: "..tostring(math.floor(getProperty('ratingPercent') * 100, 2)).."%".." ("..songPos.." / "..actualSongLength..")")
	end --trying to optimize --if psych can do it, so can I!

	--setObjectOrder('strumLineNotes', getObjectOrder('notes') +1) --puts notes under strumlinenotes

	if string.lower(songName) == 'disruption' or string.lower(songName) == 'applecore' or string.lower(songName) == 'nice' then
		for i = 0, getProperty('notes.length') do --why doesn't psych do this already??? (performance issues thats why!)
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
end

function onSectionHit()
	cancelTween('timeTxtScaleX')
	cancelTween('timeTxtScaleY')
	setProperty('timeTxt.scale.x', 1.1)
	setProperty('timeTxt.scale.y', 1.1)
	doTweenX('timeTxtScaleX', 'timeTxt.scale', 1, 0.2)
	doTweenY('timeTxtScaleY', 'timeTxt.scale', 1, 0.2)
end

function onBeatHit()
	if curBeat % 2 == 0 then
		if getProperty('boyfriend.animation.curAnim.name') == 'idle' then
			characterDance("bf")
		end

		if getProperty('dad.animation.curAnim.name') == 'idle' then
			if dadName ~= 'bambi-piss-3d' and dadName ~= 'garrett-animal' and dadName ~= 'scratchgirl' then
				characterDance("dad")
			end
		end

		if badaiSongs[string.lower(songName)] ~= nil or luaSpriteExists("badai") then
			if getProperty("badai.animation.curAnim.name") == 'idle' and not getProperty("badai.skipDance") then badaiPlayAnim('dance') end
			if getProperty("badai.animation.curAnim.name") == 'danceLeft' and not getProperty("badai.skipDance") then badaiPlayAnim('dance') elseif getProperty("badai.animation.curAnim.name") == 'danceRight' and not getProperty("badai.skipDance") then badaiPlayAnim('dance') end
		end
	end

	if string.lower(songName) == 'og' or string.lower(songName) == 'kooky' or not luaSpriteExists("iconP12") then return; end
    local iconPos = getProperty('healthBar.y') -80;

    if curBeat % getProperty('gfSpeed') == 0 then
    	local fuasd = {0.8, 1.3}
    	local angl = 15;
    	local yOffset = 20;

    	if curBeat % (getProperty('gfSpeed') * 2) == 0 then
            scaleObject('iconP12', 1.1, fuasd[1])
            scaleObject('iconP22', 1.1, fuasd[2])
            setProperty('iconP1.angle', -angl)
            setProperty('iconP2.angle', angl)
            setProperty('iconP1.y', iconPos - yOffset)
            setProperty('iconP2.y', iconPos + yOffset)
    	else
            scaleObject('iconP12', 1.1, fuasd[2])
            scaleObject('iconP22', 1.1, fuasd[1])
            setProperty('iconP1.angle', angl)
            setProperty('iconP2.angle', -angl)
            setProperty('iconP1.y', iconPos + yOffset)
            setProperty('iconP2.y', iconPos - yOffset)
    	end
    end

    doTweenY('iconP1yREAL', 'iconP1', iconPos, (crochet / 1300 * getProperty('gfSpeed')) / playbackRate, 'quadOut')
    doTweenY('iconP2yREAL', 'iconP2', iconPos, (crochet / 1300 * getProperty('gfSpeed')) / playbackRate, 'quadOut')
    doTweenAngle('iconP1Angl', 'iconP1', 0, (crochet / 1300 * getProperty('gfSpeed')) / playbackRate, 'quadOut')
    doTweenAngle('iconP2Angl', 'iconP2', 0, (crochet / 1300 * getProperty('gfSpeed')) / playbackRate, 'quadOut')
    doTweenX('iconP1x', 'iconP12.scale', 1, (crochet / 1250 * getProperty('gfSpeed')) / playbackRate, 'quadOut')
    doTweenX('iconP2x', 'iconP22.scale', 1, (crochet / 1250 * getProperty('gfSpeed')) / playbackRate, 'quadOut')
    doTweenY('iconP1y', 'iconP12.scale', 1, (crochet / 1250 * getProperty('gfSpeed')) / playbackRate, 'quadOut')
    doTweenY('iconP2y', 'iconP22.scale', 1, (crochet / 1250 * getProperty('gfSpeed')) / playbackRate, 'quadOut')

    updateHitbox('iconP12')
    updateHitbox('iconP22')
    iconPropertys()
end

function goodNoteHit(membersIndex, direction, noteType, isSustainNote)
	if getProperty('boyfriend.color') == getColorFromHex('9400d3') then
		setProperty('boyfriend.color', getColorFromHex('FFFFFF'))
	end
	if isSustainNote then return; end

    local ratingOffset = 0;
    if stringStartsWith(version, '0.7') then stupid = "game.ratingsData"; ratingOffset = getPropertyFromClass("backend.ClientPrefs", "data.ratingOffset") else stupid = "note"; ratingOffset = getPropertyFromClass("ClientPrefs", "ratingOffset") end
    runHaxeCode([[
        var membersIndex = ]]..membersIndex..[[;
        var note = game.notes.members[membersIndex];
        var noteDiff = note.strumTime - Conductor.songPosition + ]]..ratingOffset..[[;
		var daRating = Conductor.judgeNote(]]..stupid..[[, noteDiff / game.playbackRate);
        var text = "Sick!";
        if (daRating.name == "good") text = "Good";
        if (daRating.name == "bad") text = "Bad";
        if (daRating.name == "shit") text = "Shit";
        game.getLuaObject("ratingTxt", true).text = text + "\n" + (game.combo);
    ]])
    --[[scaleObject("ratingTxt", 1.2, 1.2)
	doTweenX("ratingTxtScaleX", "ratingTxt.scale", 1, .2, 'sineInOut')
	doTweenY("ratingTxtScaleY", "ratingTxt.scale", 1, .2, 'sineInOut') --it is better this way - the grinch--]]
    cancelTween("ratingTxt")
	setProperty("ratingTxt.alpha", 1)
    alphaTimer = 0.5 / playbackRate;

	runHaxeCode([[
		if(game.scoreTxtTween != null) {
			game.scoreTxtTween.cancel();
		}
	]])
	if string.lower(songName) == "og" then return; end
	runHaxeCode([[
		game.scoreTxt.scale.x = 1.075;
		game.scoreTxt.scale.y = 1.075;
		game.scoreTxtTween = FlxTween.tween(game.scoreTxt.scale, {x: 1, y: 1}, 0.35 / game.playbackRate, {
			ease: FlxEase.backOut,
			onComplete: function(twn) {
				game.scoreTxtTween = null;
			}
		});
	]])
end

function opponentNoteHit(membersIndex, noteData, noteType, isSustainNote)
	local suffix = "";
	if string.lower(noteType) == "altanim" or altAnim then suffix = "-alt" end
	if getDataFromSave("UnNamedGapplePortSettings", "badaiTime", false) then
		setProperty("badai.holdTimer", 0)
		badaiPlayAnim(singAnims[noteData + 1]..suffix)
	elseif string.lower(songName) ~= "ataefull" and string.lower(noteType) ~= "no animation" then
		setProperty("dad.holdTimer", 0)
		playAnim("dad", singAnims[noteData + 1]..suffix, true)
	end

	if string.lower(songName) == 'apple-leak' then
		setProperty("badai.holdTimer", 0)
		badaiPlayAnim(singAnims[noteData + 1]..suffix)
	end
end

function noteMissPress(direction)
	noteMissedStuff(direction)
end

function noteMiss(id, direction, noteType, isSustainNote)
	setTextString("ratingTxt", "Shit\n0")
    cancelTween("ratingTxt")
    setProperty("ratingTxt.alpha", 1)
    alphaTimer = 0.5 / playbackRate;
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

function onDestroy()
	setPropertyFromClass('flixel.FlxG', 'sound.soundTrayEnabled', true)
	if stringStartsWith(version, '0.6') then setPropertyFromClass('ClientPrefs', 'framerate', overrideFPS) else setPropertyFromClass('backend.ClientPrefs', 'data.framerate', overrideFPS) end
	runHaxeCode([[
		var framerate = ]]..overrideFPS..[[;
		if(framerate > FlxG.drawFramerate) {
			FlxG.updateFramerate = framerate;
			FlxG.drawFramerate = framerate;
		} else {
			FlxG.drawFramerate = framerate;
			FlxG.updateFramerate = framerate;
		}
	]])
	if stringStartsWith(version, '0.6') then setPropertyFromClass("Main", "fpsVar.visible", getPropertyFromClass('ClientPrefs', 'showFPS')) else setPropertyFromClass("Main", "fpsVar.visible", getPropertyFromClass('backend.ClientPrefs', 'data.showFPS')) end
end