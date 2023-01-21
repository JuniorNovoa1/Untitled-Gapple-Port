local timeSpot = 2;
local angleRandom = 0;
local spotLightPart = false;
local lastSinger = '';
local bfPos = {};
local dadPos = {};

function onUpdate()
	if angleRandom == 6 or angleRandom == 8 and spotLightPart then
		doTweenAngle('angleSpotlight', 'spotLight', 4, timeSpot, 'expoInOut')
	end

	if angleRandom == 2 or angleRandom == 4 and spotLightPart then
		doTweenAngle('angleSpotlight', 'spotLight', -4, timeSpot, 'expoInOut')
	end

	if spotLightPart then
		angleRandom = getRandomInt(0, 128);
		updateSpotlight(mustHitSection);
	end
end

function onStepHit()
	if curStep == 466 then
		setProperty('defaultCamZoom', getProperty('defaultCamZoom') + 0.2)
		cameraFlash('camother', 'FFFFFF', 0.5)
		doTweenAlpha('fadeINN', 'blackScreen', 0.6, 1, 'quadInOut')
		fadeOutNotes(1)
	end

	if curStep == 510 then
		fadeInNotes(1)
	end

	if curStep == 528 then
		setProperty('defaultCamZoom', 0.8)
		cameraFlash('camother', 'FFFFFF', 0.5)
		setProperty('blackScreen.alpha', 0)
	end

	if curStep == 832 then
		setProperty('defaultCamZoom', getProperty('defaultCamZoom') + 0.2)
		doTweenAlpha('fadeINN', 'blackScreen', 0.4, 1, 'quadInOut')
	end

	if curStep == 838 then
		fadeOutNotes(1)
	end

	if curStep == 902 then
		fadeInNotes(1)
	end

	if curStep == 908 then
		local speed = getPropertyFromClass('Conductor.stepCrochet') / 1000 * 4;
		doTweenAlpha('fadeINN', 'blackScreen', 1, speed, 'quadInOut')
	end

	if curStep == 912 and not spotLightPart then
		--spotlight
		spotLightPart = true;
		setProperty('defaultCamZoom', getProperty('defaultCamZoom') - 0.1)
		cameraFlash('camother', 'FFFFFF', 0.5)
		updateSpotlight(false)

		--[[
		setProperty('spotLight.origin.set.x', getProperty('spotLight.origin.x'))
		setProperty('spotLight.origin.set.y', getProperty('spotLight.origin.y') - (getProperty('spotLight.frameHeight') / 2))
		setProperty('spotLight.setPosition.x', getProperty('dad.getGraphicMidpoint().x') - getProperty('spotLight.width') / 2)
		setProperty('spotLight.setPosition.y', getProperty('dad.getGraphicMidpoint().y') + getProperty('dad.frameHeight') / 2 - getProperty('spotLight.height'))
		--]]

		doTweenAlpha('fadeINN', 'blackScreen', 0.6, 1, 'quadInOut')
		doTweenAlpha('fadeINNSPOT', 'spotLight', 0.7, 1, 'quadInOut')
		bfPos[0] = getGraphicMidpointX('boyfriend') -getCharacterX('boyfriend') * 0.4;
		bfPos[1] = getGraphicMidpointY('boyfriend') -getGraphicMidpointY('boyfriend') -175;
		dadPos[0] = getGraphicMidpointX('dad') -getCharacterX('dad') * 1.225;
		dadPos[1] = getGraphicMidpointY('dad') -getGraphicMidpointY('dad') -125;
	end

	if curStep == 1168 then
		--remove spotlight
		spotLightPart = false;
		doTweenAlpha('fadeINN', 'blackScreen', 0, 1, 'quadInOut')
		doTweenAlpha('fadeOUTTSPOT', 'spotLight', 0, 1, 'quadInOut')
	end

	if curStep == 1232 then
		cameraFlash('camother', 'FFFFFF', 0.5)
	end
end

function fadeInNotes(time)
	for i = 0, 7 do
	    noteTweenAlpha('FADE IN NOTE '..i, i, 1, time, 'quadInOut')
	end
end

function fadeOutNotes(time)
	for i = 0, 7 do
	    noteTweenAlpha('FADE OUT NOTE '..i, i, 0, time, 'quadInOut')
	end
end

function updateSpotlight(bfSinging)
	if bfSinging then
		doTweenX('moveSpotLightX', 'spotLight', bfPos[0], 0.66, 'circOut')
		doTweenY('moveSpotLightY', 'spotLight', bfPos[1], 0.66, 'circOut')
	end

	if not bfSinging then
		doTweenX('moveSpotLightX', 'spotLight', dadPos[0], 0.66, 'circOut')
		doTweenY('moveSpotLightY', 'spotLight', dadPos[1], 0.66, 'circOut')
	end
	--[[
	local curSinger = getProperty('boyfriend.curCharacter');
	if not bfSinging then
		curSinger = getProperty('dad.curCharacter');
	end

	if not curSinger == lastCurSinger then
		local posX = 0;
		local posY = -150;
	
		if curSinger == 'bambi-new' then
			posX = -25;
			posY = -220;
		end
	
		local targetPositionX = getProperty(curSinger + '.getGraphicMidpoint()') - getProperty('spotLight.width') / 2 + posX;
		local targetPositionY = getProperty(curSinger + '.getGraphicMidpoint()') + getProperty(curSinger + '.frameHeight') / 2 - getProperty('spotLight.height') - posY;

		doTweenX('fadeINN', 'spotLight', targetPositionX, 0.66, 'circOut')
		doTweenY('fadeINN', 'spotLight', targetPositionY, 0.66, 'circOut')
	
		lastSinger = curSinger;
	end
	--]]
end