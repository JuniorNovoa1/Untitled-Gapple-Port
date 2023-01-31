local canChangeIcon = true;
local alphaChange = false;
local bfX = 0;
local bfY = 0;
local dadX = 0;
local dadY = 0;
local zoomStuff = 0.05;

local stayOnCam = false;
local camX = 0;
local camY = 0;

local loopVarThing = false;

function onCreatePost()
	local randomNumb = 0;
	randomNumb = getRandomInt(1, 80);

	makeLuaSprite('iconBandu', 'icons/fatbandu/'..randomNumb, 0, 0)
	addAnimationByIndices('iconBandu', 'idle', 'null', '0') --i have to fix this shit bro
	addAnimationByIndices('iconBandu', 'dead', 'null', '1')
	setProperty('iconBandu.antialiasing', getPropertyFromClass('ClientPrefs', 'globalAntialiasing'))
	setProperty('iconBandu.x', getProperty('iconP2.x'))
	setProperty('iconBandu.y', getProperty('iconP2.y'))
	setProperty('iconBandu.width', getProperty('iconP2.width'))
	setProperty('iconBandu.height', getProperty('iconP2.height'))
	setObjectCamera('iconBandu', 'camhud')
	updateHitbox('iconBandu')
	if not lowQuality then
    	addLuaSprite('iconBandu', false)
	end

	--setProperty('cpuControlled', true) --testing loll
end

function onUpdate()
	if getProperty('iconP2.visible') == true and canChangeIcon then
		setProperty('iconP2.visible', false)
	end

	if getProperty('iconP2.visible') == false and canChangeIcon then
		setProperty('iconBandu.x', getProperty('iconP2.x'))
		setProperty('iconBandu.y', getProperty('iconP2.y'))
		setProperty('iconBandu.width', getProperty('iconP2.width'))
		setProperty('iconBandu.height', getProperty('iconP2.height'))
		updateHitbox('iconBandu')

		if getProperty('health') >= 1.75 then
			objectPlayAnimation('iconBandu', 'lose')
		else
			objectPlayAnimation('iconBandu', 'idle')
		end
	end
	if getProperty('iconP2.visible') == false and not canChangeIcon then
		setProperty('iconP2.visible', true)
		removeLuaSprite('iconBandu', true)
	end

	time = 1.5;

	if alphaChange and getProperty('dad.alpha') == 1 then
		doTweenAlpha('lmaoDad', 'dad', 0, time)
	end

	if alphaChange and getProperty('dad.alpha') == 0 then
		doTweenAlpha('lmaoDad', 'dad', 1, time)
	end

	if stayOnCam then
		setProperty('camFollow.x', camX);
		setProperty('camFollow.y', camY);
	end
end

function onStepHit()
	if curStep == 1088 then
		doTweenY('banduFat', 'dad', getProperty('dad.y') -500, 40)
	end

	if curStep == 1855 then
		--unused
		dadX = getProperty('dad.x');
		dadY = getProperty('dad.y');
	end

	--[[local zoomStuff = 0.05;

	if curStep == 3200 then
		setProperty('defaultCamZoom', getProperty('defaultCamZoom') -zoomStuff)
		removeLuaSprite('garryLeak', true)
		setProperty('r2.visible', true)
		alphaChange = true;
	end--]]

	if curStep == 5087 then --5088
		--[[
		setProperty('defaultCamZoom', getProperty('defaultCamZoom') +zoomStuff)
		setProperty('th1ft.visible', true)
		removeLuaSprite('r1', true)
		removeLuaSprite('r2', true)
		alphaChange = false;
		setProperty('dad.alpha', 1)
		--]]
		--setProperty('dad.y' -9999) --3d leak bambi would keep showing
	end

	if curStep == 5744 then
		--youtoob
	end

	if curStep == 6848 then
		--funk
	end

	if curStep == 7488 then
		--portal
		setProperty('portal.visible', true)
		setProperty('portal.x', getProperty('boyfriend.x') + 205)
		setProperty('portal.y', getProperty('boyfriend.y') + 205)
		setProperty('portal.scale.x', 1)
		setProperty('portal.scale.y', 1)
		doTweenX('null1', 'portal.scale', 0, 1)
		doTweenY('invisPortal', 'portal.scale', 0, 1)
		doTweenX('null3', 'boyfriend.scale', 0, 1)
		doTweenY('null4', 'boyfriend.scale', 0, 1)
	end

	if curStep == 9696 then
		--static for prob 2 secs
	end

	if curStep == 10464 then
		--static for prob 2 secs
	end

	if curStep == 11424 then
		--static for prob 2 secs
	end

	if curStep == 11944 then
		--discord leave call
	end
end

function onEvent(name, value1, value2)
	if name == 'Change Character' then
		if value2 == 'fat-bandu-3d' then
			changeNoteSkin(false, 'NOTE_assets_3D'); --adding what im guessing is gonna be in the newest build since leaked build is 4 months old.

			setProperty('wavyApplecore.visible', true)
			canChangeIcon = false;
		end

		if value2 == 'gary' then
			setProperty('fatBandu.x', dadX)
			setProperty('fatBandu.y', dadY)
			setProperty('fatBandu.visible', true)
	
			doTweenX('gasStationWidth', 'gasStation.scale', 0, 1)
			doTweenY('gasStationHeigth', 'gasStation.scale', 0, 1)
			doTweenAlpha('gasStationAlpha', 'gasStation', 0, 1)
	
			doTweenX('wavyWidth', 'wavyApplecore.scale', 0, 1)
			doTweenY('wavyHeigth', 'wavyApplecore.scale', 0, 1)
			doTweenAlpha('wavyAlpha', 'wavyApplecore', 0, 1)
	
			doTweenAlpha('fatBandunAlpha', 'fatBandu', 0, 1)
			doTweenAlpha('jamboulAlpha', 'jamboul', 0, 1)
	
			doTweenY('kineMasterUp', 'kineMaster', getProperty('kineMaster.y') -125, 1.25)
			doTweenAngle('kineMasterAngle', 'kineMaster', 90, 1.5)
		end

		if value2 == '3d-bambi-leak' then
			setProperty('defaultCamZoom', getProperty('defaultCamZoom') -zoomStuff)
			removeLuaSprite('garryLeak', true)
			setProperty('r2.visible', true)
			alphaChange = true;
		end

		if value2 == 'th1ft' then
			changeNoteSkin(false, 'NOTE_assets'); --adding what im guessing is gonna be in the newest build since leaked build is 4 months old.

			zoomStuff = zoomStuff + 0.15;
			setProperty('defaultCamZoom', getProperty('defaultCamZoom') +zoomStuff)
			setProperty('th1ft.visible', true)
			removeLuaSprite('r1', true)
			removeLuaSprite('r2', true)
			alphaChange = false;
			setProperty('dad.alpha', 1)

			bfX = getProperty('boyfriend.x');
			bfY = getProperty('boyfriend.y');
		end

		if value2 == 'bandu-trolled' then
			changeNoteSkin(false, 'NOTE_assets_3D'); --adding what im guessing is gonna be in the newest build since leaked build is 4 months old.

			setProperty('ytVids.scale.x', 2)
			setProperty('ytVids.scale.y', 2)
			doTweenX('ytVidsWidth', 'ytVids.scale', 1, 1)
			doTweenY('ytVidsHeigth', 'ytVids.scale', 1, 1)
			camX = getProperty('camFollow.x');
			camY = getProperty('camFollow.y');
			stayOnCam = true;

			setProperty('dad.x', 25)
			setProperty('dad.y', 1290)
			
			setProperty('boyfriend.x', 1400)
			setProperty('boyfriend.y', 1625)
			makeLuaSprite('boyfond', 'appleLeak/trolled/boyfranon', bfX, bfY)
			addLuaSprite('boyfond', false)

			setProperty('ytStatic.visible', true)
			setProperty('ytBox.visible', true)
		end

		if value2 == 'sammy' then
			setProperty('funkipedia.visible', true)
			setProperty('dad.x', 1660)
			setProperty('dad.y', 2070)
			setProperty('boyfriend.x', 1250)
			setProperty('boyfriend.y', 2500)
			setProperty('boyfriend.scale.x', 0.85)
			setProperty('boyfriend.scale.y', 0.85)
		end

		if value2 == 'duelExpunged' then
			setProperty('defaultCamZoom', 0.8)
			removeLuaSprite('funkipedia', true)
			removeLuaSprite('ytStatic', true)
			removeLuaSprite('ytBox', true)
			setProperty('caveBG.visible', true)
			setProperty('brob.visible', true)
			setProperty('monkey.visible', true)
			setProperty('ohyeah.visible', true)
			setProperty('wrath.visible', true)
			setProperty('caveFloor.visible', true)
			setProperty('norman.visible', true)

			setProperty('dad.x', -300)
			setProperty('dad.y', 350)
			setProperty('boyfriend.x', 900)
			setProperty('boyfriend.y', 465) --765

			setProperty('portal.visible', true)
			setProperty('portal.x', getProperty('boyfriend.x') + 200)
			setProperty('portal.y', getProperty('boyfriend.y') + 200)
			setProperty('boyfriend.scale.x', 0)
			setProperty('boyfriend.scale.y', 0)

			doTweenX('portalWidth', 'portal.scale', 1, 1)
			doTweenY('portalHeight', 'portal.scale', 1, 1)
			doTweenX('portalBFWidth', 'boyfriend.scale', 1, 1)
			doTweenY('portalBFHeight', 'boyfriend.scale', 1, 1)
		end

		if value2 == '3d-bambi-leak-finale' then
			if loopVarThing == false then
				removeLuaSprite('caveBG', true)
				removeLuaSprite('brob', true)
				removeLuaSprite('monkey', true)
				removeLuaSprite('ohyeah', true)
				removeLuaSprite('wrath', true)
				removeLuaSprite('caveFloor', true)
				removeLuaSprite('norman', true)
				setProperty('fire.visible', true)
				setProperty('vg.visible', true)
				setProperty('dad.x', 250)
				setProperty('dad.y', -315)
				setProperty('dad.visible', false)
				setProperty('camHUD.visible', false)
				camX = 1290;
				camY = 450;
				stayOnCam = true;

				setProperty('boyfriend.y', getProperty('boyfriend.y') - 900)
				doTweenY('boyfrinedYYY', 'boyfriend', getProperty('boyfriend.y') + 900, 1.5)
				loopVarThing = true;
			end

			changeNoteSkin(true, 'NOTE_assets_3D'); --adding what im guessing is gonna be in the newest build since leaked build is 4 months old.
		else
			setProperty('dad.x', 250)
			setProperty('dad.y', -315)
		end

		if value2 == 'duel-cheating-bambi-leak' then
			--1 second static
		end

		if value2 == 'wide-bambi-leak' then
			--2 second static
		end

		if value2 == 'screwed-bambi-leak' then
			--2 second static
		end
		
		if value2 == 'among-bambi' then
			--2 second static
		end

		if value2 == 'bob-bambi-leak' then
			--2 second static
		end
	end
end

function onTweenCompleted(tag)
	if tag == 'jamboulAlpha' then
		removeLuaSprite('jamboul', true)
		removeLuaSprite('fatBandu', true)
		removeLuaSprite('gasStation', true)
		removeLuaSprite('wavyApplecore', true)
		doTweenX('garyMoveX', 'dad', dadX, 1.5)
		doTweenY('garyMoveY', 'dad', dadY, 1.5)
	end

	if tag == 'kineMasterAngle' then
		doTweenY('kineMasterDown', 'kineMaster', 1000, 2.6)
		doTweenAngle('kineMasterAngle2', 'kineMaster', 125, 2.6)
	end

	if tag == 'kineMasterAngle2' then
		removeLuaSprite('kineMaster', true)
	end

	if tag == 'ytVidsHeigth' then
		doTweenAngle('boyfondAngle', 'boyfond', 10, 0.2)
	end

	if tag == 'boyfondAngle' then
		doTweenAngle('boyfondAngle2', 'boyfond', 120, 1)
		doTweenAlpha('boyfondAlpha', 'boyfond', 0, 1)
	end

	if tag == 'boyfondAlpha' then
		removeLuaSprite('boyfond', true)
		stayOnCam = false;
	end

	if tag == 'invisPortal' then
		setProperty('portal.visible', false)
	end

	if tag == 'portalBFHeight' then
		doTweenY('null5', 'boyfriend', 765, 1)
		doTweenX('null1', 'portal.scale', 0, 1)
		doTweenY('invisPortal', 'portal.scale', 0, 1)
	end

	if tag == 'camHUDHeight' then
		doTweenX('null999', 'camHUD.scale', 1, 1.25, 'cubeInOut')
		doTweenY('null314', 'camHUD.scale', 1, 1.25, 'cubeInOut')
	end
end

local POP = false;
local POP2 = false;
local POP3 = false;

function opponentNoteHit(id, direction, noteType, isSustainNote)
	if getProperty('dad.curCharacter') == 'bandu-trolled' and not POP then
		doTweenX('dadWidth', 'dad.scale', 0.3, 0.35)
		doTweenY('dadHeigth', 'dad.scale', 0.3, 0.35)
		removeLuaSprite('ytVids', true)
		removeLuaSprite('th1ft', true)
		POP = true;
	end

	if getProperty('dad.curCharacter') == '3d-bambi-leak-finale' and not POP2 then
		setProperty('camHUD.scale.x', 1.5)
		setProperty('camHUD.scale.y', 1.5)
		setProperty('camHUD.visible', true)
		doTweenX('camHUDWidth', 'camHUD.scale', 0.5, 1.25, 'cubeInOut')
		doTweenY('camHUDHeight', 'camHUD.scale', 0.5, 1.25, 'cubeInOut')
		triggerEvent("camFlash", '0.5', '')
		setProperty('dad.visible', true)
		stayOnCam = false;
		POP2 = true;
	end

	if getProperty('dad.curCharacter') == 'among-bambi' and not POP3 then
		--flash twitter post
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