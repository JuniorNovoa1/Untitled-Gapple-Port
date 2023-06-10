--DON'T STEAL KIDS!
--BY JUNIORNOVOA
local gappleHUD = {'maze', 'disruption', 'applecore', 'disability', 'wireframe', 'ferocious', 'cuberoot', 'sart-producer', 'og', 'apple-leak', 'badcorn', 'crap!', 'kooky'};
local songSplashNames = {''};
local oldFNFPos = {''};
local gappleHUDsong = false;
local arrowXoffset = 35;
local no_splashes = false;

local ratingPos = 575;
local prevRatingPos = {};

local songMod = 'Null';

local CharactersWith3D = {'bambi-unfair', 'bambi-piss-3d', 'bandu', 'bandu-sad', 'tunnel-dave', 'badai', 'unfair-junker', 'split-dave-3d', 'garrett', '3d-bf', '3d-bf-flipped', '3d-bf-shoulder', 'garrett-animal', 'playtime', 'palooseMen', 'garrett-ipad', 'wizard', 'piano-guy', 'pedophile', 'garrett-angry', 'garrett-car',
'insanidave', 'bamb-root', 'sart-producer', 'sart-producer-front', 'fat-bandu-3d', 'gary', '3d-bambi-leak', 'bandu-trolled', 'sammy', 'duelExpunged', '3d-bambi-leak-finale'}

function onCreatePost()
	setProperty('showCombo', true)

	for i = 1, #songSplashNames do
		if string.lower(songName) == songSplashNames[i] then
			no_splashes = true;
		end
	end
	for i = 1, 99 do
		if string.lower(songName) == oldFNFPos[i] or string.lower(songName) == gappleHUD[i] then
			for direction = 0, 3 do
				setPropertyFromGroup('playerStrums', direction, 'x', getPropertyFromGroup('playerStrums', direction, 'x') - arrowXoffset)
				setPropertyFromGroup('opponentStrums', direction, 'x', getPropertyFromGroup('opponentStrums', direction, 'x') - arrowXoffset -5)
			end
		end
	end
	for i = 1, #gappleHUD do
		if string.lower(songName) == gappleHUD[i] or gappleHUDsong then
			no_splashes = true;
			setTextFont('scoreTxt', 'comic.ttf')
			setTextFont('timeTxt', 'comic.ttf')

			makeLuaText('creditsWatermark', songName, 0, 4, getProperty('healthBarBG.y') + 30)
			setObjectCamera('creditsWatermark', 'camHUD')
			setTextAlignment('creditsWatermark', 'center')
			setTextFont('creditsWatermark', 'comic.ttf')
			setTextSize('creditsWatermark', 16)
			setTextBorder('creditsWatermark', 1.5, '000000')
			setProperty('creditsWatermark.antialiasing', false)
			updateHitbox('creditsWatermark')
			addLuaText('creditsWatermark')

			makeLuaText('creditsText', '', 0, 4, getProperty('healthBarBG.y') + 50)
			setObjectCamera('creditsText', 'camHUD')
			setTextAlignment('creditsText', 'center')
			setTextFont('creditsText', 'comic.ttf')
			setTextSize('creditsText', 16)
			setTextBorder('creditsText', 1.5, '000000')
			setProperty('creditsText.antialiasing', false)
			updateHitbox('creditsText')
			addLuaText('creditsText')

			if string.lower(songName) == 'disruption' then
				setProperty('creditsText.text', 'Screw you!')
			end
			if getProperty('creditsText.text') == '' then
				setProperty('creditsWatermark.y', getProperty('healthBarBG.y') + 50)
			end
			songMod = 'Dave and Bambi';
			if string.lower(songName) == 'maze' then
				setProperty('healthBarBG.visible', false)
				makeLuaSprite('healthBarBGnew', 'daveHealth', getProperty('healthBarBG.x'), getProperty('healthBarBG.y'))
				setObjectCamera('healthBarBGnew', 'camHUD')
				addLuaSprite('healthBarBGnew', false)
				setObjectOrder('healthBarBGnew', getObjectOrder('healthBarBG') + 1)
	
				makeLuaSprite('iconP12', 'icons/missing', 0, 0)
				makeLuaSprite('iconP22', 'icons/missing', 0, 0)
				break;
			end

			songMod = 'DNB: Golden Apple';

			prevRatingPos[0] = getPropertyFromClass('ClientPrefs', 'comboOffset[0]');
			prevRatingPos[1] = getPropertyFromClass('ClientPrefs', 'comboOffset[2]');
			setPropertyFromClass('ClientPrefs', 'comboOffset[0]', ratingPos)
			setPropertyFromClass('ClientPrefs', 'comboOffset[2]', ratingPos)

			makeLuaSprite('healthBarBGnew', 'healthBarOverlay', getProperty('healthBarBG.x'), getProperty('healthBarBG.y'))
			scaleObject('healthBarBGnew', getProperty('healthBarBG.scale.x') - 0.075, getProperty('healthBarBG.scale.y') - 0.15)
			setObjectCamera('healthBarBGnew', 'camHUD')
			addLuaSprite('healthBarBGnew', false)
			setObjectOrder('healthBarBGnew', getObjectOrder('healthBarBG') + 1)

			if string.lower(songName) == 'kooky' then
				setProperty('healthBarBGnew.visible', false)
			end

			if has_value(CharactersWith3D, getProperty('boyfriend.curCharacter')) then
				changeNoteSkin(true, 'NOTE_assets_3D');
			end

			if has_value(CharactersWith3D, getProperty('dad.curCharacter')) then
				changeNoteSkin(false, 'NOTE_assets_3D');
			end

			local difHealth = 0.025;

			for i = 0, getProperty('unspawnNotes.length')-1 do
				setPropertyFromGroup('unspawnNotes', i, 'hitHealth', getPropertyFromGroup('unspawnNotes', i, 'hitHealth') * (1.0 - difHealth))
				if getPropertyFromGroup('unspawnNotes', i, 'isSustainNote') then
					setPropertyFromGroup('unspawnNotes', i, 'hitHealth', getPropertyFromGroup('unspawnNotes', i, 'hitHealth') / 2)
				end
				setPropertyFromGroup('unspawnNotes', i, 'missHealth', getPropertyFromGroup('unspawnNotes', i, 'missHealth') * (1.0 + (difHealth * 4)))
				if getPropertyFromGroup('unspawnNotes', i, 'isSustainNote') then
					setPropertyFromGroup('unspawnNotes', i, 'missHealth', getPropertyFromGroup('unspawnNotes', i, 'missHealth') / 2)
				end
				if (((has_value(CharactersWith3D, getProperty('dad.curCharacter')) and not getPropertyFromGroup('unspawnNotes', i, 'mustHit')) or (has_value(CharactersWith3D, getProperty('boyfriend.curCharacter'))) and getPropertyFromGroup('unspawnNotes', i, 'mustHit'))) or ((has_value(CharactersWith3D, getProperty('dad.curCharacter')) or has_value(CharactersWith3D, getProperty('boyfriend.curCharacter'))) and ((getPropertyFromGroup('unspawnNotes', i, 'strumTime') / 50) % 20 > 10)) then
					setPropertyFromGroup('unspawnNotes', i, 'texture', 'NOTE_assets_3D')
				end
			end

			makeLuaSprite('iconP12', 'icons/missing', 0, 0)
			makeLuaSprite('iconP22', 'icons/missing', 0, 0)

			setProperty("updateTime", false)
			
			setObjectOrder('scoreTxt', getObjectOrder('healthBarBG') -1)
			setObjectOrder('timeTxt', 99)
			if gappleHUDsong then
				break;
			end
			gappleHUDsong = true;
		end
	end

	if string.lower(songName) == 'lore' then
		songMod = 'D-Sides';
	end

	if string.lower(songName) == 'close chuckle' then
		songMod = 'Hotline-024';
	end
end

function changeNoteSkin(player, skin)
	if player == true then
		for i = 0, 4, 1 do
			setPropertyFromGroup('playerStrums', i, 'texture', skin)
		end
	end
    if not player then
		for i = 0, 4, 1 do
			setPropertyFromGroup('opponentStrums', i, 'texture', skin)
		end
	end

    for i = 0, getProperty('notes.length') -1 do
        if getPropertyFromGroup('notes', i, 'mustPress') == player then --only "player" side
            setPropertyFromGroup('notes', i, 'texture', skin)
        end
    end

    for i = 0, getProperty('unspawnNotes.length') -1 do
        if getPropertyFromGroup('unspawnNotes', i, 'mustPress') == player then --only "player" side
            setPropertyFromGroup('unspawnNotes', i, 'texture', skin)
        end
    end
end

--THANK GOD THE INTERNET EXISTS
function has_value (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
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
	setProperty('healthBarBGnew.alpha', getProperty('healthBar.alpha'))
	actualSongLength = math.toTime(getProperty("songLength") / 1000);
	songPos = math.toTime(getSongPosition() / 1000)

	if gappleHUDsong then
		iconScale()
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
end

local noteColors = {'7A5299', '00FFFF', '90EE90', 'FF7F7F'} --90EE90

function onUpdatePost(elapsed)
	if string.lower(songName) == 'maze' or gappleHUDsong then
		if string.lower(songName) ~= 'kooky' then
			setProperty('healthBarBG.y', screenHeight * 0.9)
			setProperty('healthBar.y', getProperty('healthBarBG.y') + 4)
			setProperty('healthBar.x', getProperty('healthBarBG.x') + 4)
			setProperty('healthBarBGnew.y', screenHeight * 0.9)
			setProperty('healthBarBGnew.x', getProperty('healthBarBG.x'))
			setProperty('scoreTxt.y', getProperty('healthBarBG.y') + 40)
		end
		if downscroll then
			setProperty('healthBarBG.y', 50)
			setProperty('healthBar.y', getProperty('healthBarBG.y') + 4)
			setProperty('healthBar.x', getProperty('healthBarBG.x') + 4)
			setProperty('healthBarBGnew.y', getProperty('healthBarBG.y') + 4)
			setProperty('healthBarBGnew.x', getProperty('healthBarBG.x') + 4)
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
			updateHitbox('iconP1')
			updateHitbox('iconP2')
		end
		iconScale()
	end
end

function onStepHit()
	changePresence(songName.." ("..songMod..") - Junior's Funny Mod Folder Ports", "S: "..tostring(score).." | M: "..tostring(getProperty('songMisses')).." | A: "..tostring(math.floor(getProperty('ratingPercent') * 100, 2)).."%".." ("..songPos.." / "..actualSongLength..")")

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

function iconScale()
	setProperty('iconP1.scale.x', getProperty('iconP12.scale.x'))
	setProperty('iconP1.scale.y', getProperty('iconP12.scale.y'))
	setProperty('iconP2.scale.x', getProperty('iconP22.scale.x'))
	setProperty('iconP2.scale.y', getProperty('iconP22.scale.y'))
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
		iconScale()
	end

	if gappleHUDsong then
		if string.lower(songName) == 'kooky' then
			return;
		end
		local iconPos = getProperty('healthBar.y') -82.5;

		if curBeat % getProperty('gfSpeed') == 0 then
			local fuasd = {0.8, 1.3}
			local angl = 15;
			local yOffset = 15;

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

		doTweenY('iconP1yREAL', 'iconP1', iconPos, crochet / 1300 * getProperty('gfSpeed'), 'quadOut')
		doTweenY('iconP2yREAL', 'iconP2', iconPos, crochet / 1300 * getProperty('gfSpeed'), 'quadOut')
		doTweenAngle('iconP1', 'iconP1', 0, crochet / 1300 * getProperty('gfSpeed'), 'quadOut')
		doTweenAngle('iconP2', 'iconP2', 0, crochet / 1300 * getProperty('gfSpeed'), 'quadOut')
		doTweenX('iconP1x', 'iconP12.scale', 1, crochet / 1250 * getProperty('gfSpeed'), 'quadOut')
		doTweenX('iconP2x', 'iconP22.scale', 1, crochet / 1250 * getProperty('gfSpeed'), 'quadOut')
		doTweenY('iconP1y', 'iconP12.scale', 1, crochet / 1250 * getProperty('gfSpeed'), 'quadOut')
		doTweenY('iconP2y', 'iconP22.scale', 1, crochet / 1250 * getProperty('gfSpeed'), 'quadOut')

		updateHitbox('iconP1')
		updateHitbox('iconP2')
		updateHitbox('iconP12')
		updateHitbox('iconP22')
		iconScale()
	end
	if curBeat % 2 == 0 then
		if getProperty('boyfriend.animation.curAnim.name') == 'idle' then
			playAnim('boyfriend', 'idle', true)
		end

		if getProperty('dad.animation.curAnim.name') == 'idle' then
			if dadName == 'bambi-piss-3d' then
				return;
			end
			playAnim('dad', 'idle', true)
		end
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

function onPause()
	if gappleHUDsong then
		setPropertyFromClass('ClientPrefs', 'comboOffset[0]', prevRatingPos[0])
		setPropertyFromClass('ClientPrefs', 'comboOffset[2]', prevRatingPos[1])
	end
end

function onDestroy()
	if gappleHUDsong then
		setPropertyFromClass('ClientPrefs', 'comboOffset[0]', prevRatingPos[0])
		setPropertyFromClass('ClientPrefs', 'comboOffset[2]', prevRatingPos[1])
	end
end