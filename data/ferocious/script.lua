local normalStrumY = 50;
local daCurstep = 0;
local padZoomTime = 1;
local allowCountdown = false;
local allowSongEnd = false;

--[[
function onStartCountdown()
	if allowCountdown then
		return Function_Continue;
	end

	if not allowCountdown then
		makeLuaSprite('greenScreen', '', 0, 0)
		makeGraphic('greenScreen', '1280', '720', '90ee90')
		setObjectCamera('greenScreen', 'camother')
		scaleObject('greenScreen', 10, 10)
		screenCenter('greenScreen', 'x')
		screenCenter('greenScreen', 'y')
		updateHitbox('greenScreen')
		addLuaSprite('greenScreen', false)

		makeLuaSprite('garrett1', 'funnyAnimal/fat_guy', 0, 0)
		setObjectCamera('garrett1', 'camother')
		screenCenter('garrett1', 'x')
		screenCenter('garrett1', 'y')
		updateHitbox('garrett1')
		addLuaSprite('garrett1', false)

		makeLuaSprite('canYou', 'funnyAnimal/canYouBeat', 250, 450)
		setObjectCamera('canYou', 'camother')
		addLuaSprite('canYou', false)

		makeLuaSprite('garrett2', 'funnyAnimal/obese_guy', 0, 0)
		setProperty('garrett2.visible', false)
		setObjectCamera('garrett2', 'camother')
		screenCenter('garrett2', 'x')
		screenCenter('garrett2', 'y')
		updateHitbox('garrett2')
		addLuaSprite('garrett2', false)

		makeLuaSprite('horray', 'funnyAnimal/hooray', 250, 450)
		setObjectCamera('horray', 'camother')
		setProperty('horray.visible', false)
		addLuaSprite('horray', false)

		runTimer('garretChange', 3)
		runTimer('songStart', 5)
		return Function_Stop;
	end
end
]]--

function onCreate()
	--heheheha
	precacheImage('funnyAnimal/zunkity')
	precacheImage('funnyAnimal/palooseCar')

	if downscroll then
		normalStrumY = screenHeight -150;
	end
end

function onUpdate()
	if curStep >= 3311 and curStep <= 4719 then
		setProperty('camFollow.x', 600);
		setProperty('camFollow.y', 350);
	end
end

function onStepHit()
	daCurstep = curStep;
	if curStep == 2160 then
		reposLegs()
		removeLuaSprite('schoolSTATIC', true)
		setProperty('RUNBITCH.visible', true)
		setProperty('BFLEGS2.visible', true)
		setProperty('defaultCamZoom', 0.75)
		print('POLICE IS ON UR ASS, RUN!')
	end

	if curStep == 3215 then
		setProperty('RUNBITCH.visible', false)
		setProperty('BFLEGS2.visible', false)
		setProperty('Jail.visible', true)

		runTimer('dadMovingTimer', 1.45)
		print('POLICE CAUGHT UR ASS!')
	end

	if curStep == 3300 then
		setProperty('IPADBG.visible', true)
		setProperty('IPADBG.scale.x', 0)
		setProperty('IPADBG.scale.y', 0)
		doTweenY('IPADBG APPEAR ON SCREEN SCALE Y', 'IPADBG.scale', 2, padZoomTime, 'quadInOut')
		doTweenX('IPADBG APPEAR ON SCREEN SCALE X', 'IPADBG.scale', 2, padZoomTime, 'quadInOut')
		doTweenAlpha('IPADBG APPEAR ON SCREEN', 'IPADBG', 1, padZoomTime / 2, 'quadInOut')

		setProperty('IPAD.visible', true)
		setProperty('IPAD.scale.x', 0)
		setProperty('IPAD.scale.y', 0)
		doTweenY('IPAD APPEAR ON SCREEN SCALE Y', 'IPAD.scale', 2, padZoomTime, 'quadInOut')
		doTweenX('IPAD APPEAR ON SCREEN SCALE X', 'IPAD.scale', 2, padZoomTime, 'quadInOut')
		doTweenAlpha('IPAD APPEAR ON SCREEN', 'IPAD', 1, padZoomTime / 2, 'quadInOut')
	end

	if curStep == 3310 then
		removeLuaSprite('Jail', true)
		setProperty('defaultCamZoom', 0.5)
		setProperty('blackScreenBG.visible', true)
		setProperty('Jail.visible', false)
		setProperty('IPADBG.visible', true)
		setProperty('IPAD.visible', true)

		setProperty('strumLine.y', normalStrumY);
		for i = 0, 4, 1 do
			setPropertyFromGroup('opponentStrums', i, 'visible', false)
		end
		for i = 0, getProperty('unspawnNotes.length') -1 do
			if getPropertyFromGroup('unspawnNotes', i, 'mustPress') == false then
				setPropertyFromGroup('unspawnNotes', i, 'visible', false)
			end
		end
		changeNoteSkin(true, 'BEVEL_NOTES')
		local scaleXY = 0.4;
		for i = 0, 4, 1 do
			setPropertyFromGroup('playerStrums', i, 'scale.x', scaleXY)
			setPropertyFromGroup('playerStrums', i, 'scale.y', scaleXY)

			local offsetss = 64 * i;
			setPropertyFromGroup('playerStrums', i, 'x', 781.5 + offsetss)
			if downscroll then
				setPropertyFromGroup('playerStrums', i, 'y', 535)
			else
				setPropertyFromGroup('playerStrums', i, 'y', 120)
			end
		end

		print('UH OH GARRETT IS ANGRY >:(')
	end

	if curStep == 4719 then
		removeLuaSprite('blackScreenBG', true)
		setProperty('defaultCamZoom', 0.8)
		setProperty('blackScreenBG.visible', false)
		setProperty('IPADBG.visible', false)
		setProperty('IPAD.visible', false)
		removeLuaSprite('IPADBG', true)
		removeLuaSprite('IPAD', true)
		setProperty('RUNBITCHSTATIC.visible', true)
		for i = 0, 4, 1 do
			setPropertyFromGroup('opponentStrums', i, 'visible', true)
		end
		for i = 0, getProperty('notes.length') -1 do
			if getPropertyFromGroup('notes', i, 'mustPress') == false then --only "player" side
				setPropertyFromGroup('notes', i, 'visible', true)
			end
		end
		for i = 0, getProperty('unspawnNotes.length') -1 do
			if getPropertyFromGroup('unspawnNotes', i, 'mustPress') == false then --only "player" side
				setPropertyFromGroup('unspawnNotes', i, 'visible', true)
			end
		end
		changeNoteSkin(true, 'NOTE_assets_3D')
		for i = 0, getProperty('unspawnNotes.length') -1 do
			if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'magic note' then
				setPropertyFromGroup('unspawnNotes', i, 'texture', 'funnyAnimal/magicNote')
			end
			if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'police note' then
				setPropertyFromGroup('unspawnNotes', i, 'texture', 'funnyAnimal/palooseNote')
			end
		end
		for i = 0, 4, 1 do
			local offsetss = 125 * i;
			setPropertyFromGroup('playerStrums', i, 'x', 750 + offsetss)
			setPropertyFromGroup('playerStrums', i, 'y', normalStrumY)
			setPropertyFromGroup('opponentStrums', i, 'y', normalStrumY)
		end

		print('magik man appeared')
	end

	if curStep == 5903 then
		setProperty('RUNBITCHSTATIC.visible', false)
		setProperty('RUNBITCH.visible', true)
		print('A FUCKING PIANO?!')
	end

	if curStep == 7719 then
		setProperty('RUNBITCHSTATIC.visible', true)
		setProperty('RUNBITCH.visible', false)
		doTweenX('movePiano', 'dad', -3610, 1.3)
		print('piano leaves now')
	end

	if curStep == 8927 then
		objectPlayAnimation('PEDOPHILESTATIC', 'hhmm')
	end

	if curStep == 8991 then
		objectPlayAnimation('PEDOPHILESTATIC', 'smile')
	end

	if curStep == 9279 then
		objectPlayAnimation('PEDOPHILESTATIC', 'im smile at you')
	end

	if curStep == 9347 then
		objectPlayAnimation('PEDOPHILESTATIC', 'you ugly')
	end

	if curStep == 9420 then
		objectPlayAnimation('PEDOPHILESTATIC', 'did you get uglier')
	end

	if curStep == 9503 then
		objectPlayAnimation('PEDOPHILESTATIC', 'garrett is ugly')
	end

	if curStep == 9759 then
		objectPlayAnimation('PEDOPHILESTATIC', 'bf is ugly')
	end

	if curStep == 10015 then
		objectPlayAnimation('PEDOPHILESTATIC', 'like my cut')
	end

	if curStep == 10271 then
		objectPlayAnimation('PEDOPHILESTATIC', 'i wear a mask with a smile')
	end

	if curStep == 10527 then
		objectPlayAnimation('PEDOPHILESTATIC', 'wtf')
	end

	if curStep == 10863 then
		objectPlayAnimation('PEDOPHILESTATIC', 'THERE IS A CAR COMING RUN BITCH')
	end

	if curStep == 11038 then
		setProperty('PEDOPHILESTATIC.visible', false)
		removeLuaSprite('PEDOPHILESTATIC', true)
		setProperty('blackScreen.visible', true)
		setProperty('RUNBITCHSTATIC.visible', false)
		removeLuaSprite('RUNBITCHSTATIC', true)
		setProperty('RUNBITCH.visible', true)

		makeAnimatedLuaSprite('POLICECAR', 'funnyAnimal/palooseCar', getProperty('dad.x'), getProperty('dad.y'))
		addAnimationByPrefix('POLICECAR', 'run', 'idle0', 24, true)
		objectPlayAnimation('POLICECAR', 'run', true)
		setProperty('POLICECAR.antialiasing', getPropertyFromClass('ClientPrefs', 'globalAntialiasing'))
		addLuaSprite('POLICECAR', true)
		print('CAR IS HERE LOL')
	end

	if curStep == 11043 then
		setProperty('blackScreen.visible', false)
		removeLuaSprite('blackScreen', true)
		setProperty('BFLEGS2.visible', true)
		setProperty('BFLEGS2.flipX', false)
		reposLegs()
	end

	if curStep == 11295 then
		setProperty('defaultCamZoom', 1.2)
	end

	if curStep == 11423 then
		setProperty('defaultCamZoom', 0.8)
	end
end

--[[
function onEndSong()
	if not allowSongEnd then --Block the first countdown
		makeLuaSprite('VICTORY', 'funnyAnimal/end', 0, 0)
		setObjectCamera('VICTORY', 'camhud')
		setProperty('VICTORY.width', 1280)
		setProperty('VICTORY.height', 720)
		screenCenter('VICTORY', 'x')
		screenCenter('VICTORY', 'y')
		updateHitbox('VICTORY')
		addLuaSprite('VICTORY', false)
		playSound('win')
		runTimer('songEnd', 4)
		return Function_Stop;
	end

	return Function_Continue;
end
-]]

function onEvent(n, v1, v2)
	if n == 'Change Character' then
		if v2 == 'garrett-car' or v2 == 'garrett-angry' or v2 == 'pedophile' or v2 == '3d-bf' or v2 == '3d-bf-flipped' then			
			if v2 == 'garrett-angry' then
				setProperty('PEDOPHILESTATIC.x', 1950)
				setProperty('PEDOPHILESTATIC.y', 675)
				setProperty('PEDOPHILESTATIC.visible', true)
				objectPlayAnimation('PEDOPHILESTATIC', 'hey its the toddler')
				print('pedophile 2 is now shown')
			end

			if v2 == 'pedophile' then
				makeAnimatedLuaSprite('PEDOPHILESTATIC', 'funnyAnimal/zunkity', getProperty('dad.x') -300, getProperty('dad.y'))
				addAnimationByPrefix('PEDOPHILESTATIC', 'hey its the toddler', 'FAKE LOADING SCREEN0000', 24, false)
				addAnimationByPrefix('PEDOPHILESTATIC', 'hhmm', 'FAKE LOADING SCREEN0001', 24, false)
				addAnimationByPrefix('PEDOPHILESTATIC', 'smile', 'FAKE LOADING SCREEN0002', 24, false)
				addAnimationByPrefix('PEDOPHILESTATIC', 'im smile at you', 'FAKE LOADING SCREEN0003', 24, false)
				addAnimationByPrefix('PEDOPHILESTATIC', 'you ugly', 'FAKE LOADING SCREEN0004', 24, false)
				addAnimationByPrefix('PEDOPHILESTATIC', 'did you get uglier', 'FAKE LOADING SCREEN0005', 24, false)
				addAnimationByPrefix('PEDOPHILESTATIC', 'garrett is ugly', 'FAKE LOADING SCREEN0006', 24, false)
				addAnimationByPrefix('PEDOPHILESTATIC', 'bf is ugly', 'FAKE LOADING SCREEN0007', 24, false)
				addAnimationByPrefix('PEDOPHILESTATIC', 'like my cut', 'FAKE LOADING SCREEN0008', 24, false)
				addAnimationByPrefix('PEDOPHILESTATIC', 'i wear a mask with a smile', 'FAKE LOADING SCREEN0009', 24, false)
				addAnimationByPrefix('PEDOPHILESTATIC', 'wtf', 'FAKE LOADING SCREEN0010', 24, false)
				addAnimationByPrefix('PEDOPHILESTATIC', 'THERE IS A CAR COMING RUN BITCH', 'FAKE LOADING SCREEN0011', 24, false)
				setProperty('PEDOPHILESTATIC.antialiasing', getPropertyFromClass('ClientPrefs', 'globalAntialiasing'))
				setProperty('PEDOPHILESTATIC.visible', false)
				addLuaSprite('PEDOPHILESTATIC', false)
				print('pedophile sprite made')
			end
		else
			cameraFlash('other', 'FFFFFF', 0.35)
		end
	end
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'garretChange' then
		setProperty('garrett1.visible', false)
		setProperty('canYou.visible', false)
		setProperty('garrett2.visible', true)
		setProperty('horray.visible', true)
		playSound('win')
	end

	if tag == 'songStart' then
		setProperty('greenScreen.visible', false)
		setProperty('garrett1.visible', false)
		setProperty('canYou.visible', false)
		setProperty('garrett2.visible', false)
		setProperty('canYou.visible', false)
		setProperty('horray.visible', false)
		allowCountdown = true;
	end

	if tag == 'songEnd' then
		allowSongEnd = true;
	end

	if tag == 'dadMovingTimer' then
		doTweenX('moveDad', 'dad', 4640, 6.5)
	end
end

function onTweenCompleted(tag)
	if tag == 'movePiano' then
        triggerEvent('Change Character', 'dad', 'pedophile')
	end
end

function reposLegs()
	setProperty('BFLEGS2.x', getProperty("boyfriend.x") - 130)
	setProperty('BFLEGS2.y', getProperty("boyfriend.y") + 200)

	if getProperty("BFLEGS2.flipX") == false then
		setProperty('BFLEGS2.x', getProperty("BFLEGS2.x") + 100)
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