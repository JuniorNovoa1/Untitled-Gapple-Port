opponentPlay = true; --not gonna be used but if u want to use it just turn opponentPlay on

local regularNotes = {'', 'Alt Animation', 'Hey!', 'GF Sing'}
local singAnims = {'singLEFT', 'singDOWN', 'singUP', 'singRIGHT'}
local keys = {'left', 'down', 'up', 'right'}
local missedOn = false;
local ratingPos = 215;
local prevRatingPos = {};
local dadHasMissAnims = false;
local actualTotalNotesPlayed = 0;

function onCreatePost()
	if not opponentPlay then
		return;
	end
	setProperty('cpuControlled', true) --not gonna fucking code bf's side lmao

	if not middlescroll then
		prevRatingPos[0] = getPropertyFromClass('ClientPrefs', 'comboOffset[0]');
		prevRatingPos[1] = getPropertyFromClass('ClientPrefs', 'comboOffset[2]');
		setPropertyFromClass('ClientPrefs', 'comboOffset[0]', ratingPos)
		setPropertyFromClass('ClientPrefs', 'comboOffset[2]', ratingPos)
	else
		local xOldBF = 0;
		local xOldDAD = 0;
		for i = 1, #keys do
			xOldBF = getPropertyFromGroup('playerStrums', i-1, 'x');
			xOldDAD = getPropertyFromGroup('opponentStrums', i-1, 'x')
			noteTweenAlpha('DASTRUM'..i, 3+i, 0.35, 3, 'cubeInOut')
			noteTweenAlpha('DASTRUMBF'..i, i-1, 1, 3, 'cubeInOut')
			setPropertyFromGroup('playerStrums', i-1, 'x', xOldDAD)
			setPropertyFromGroup('opponentStrums', i-1, 'x', xOldBF)
		end
	end
	addHaxeLibrary('StrumNote')
end

function onUpdate()
	if not opponentPlay then
		return;
	end

	dadHasMissAnims = getProperty('dad.hasMissAnimations')
	setProperty('totalPlayed', actualTotalNotesPlayed)

	for iNote = 0, getProperty('notes.length') do
		if getPropertyFromGroup('notes', iNote, 'mustPress') == false then
			setPropertyFromGroup('notes', iNote, 'wasGoodHit', false)
			setPropertyFromGroup('notes', iNote, 'hitByOpponent', true)
			local lateHitMult = getPropertyFromGroup('notes', iNote, 'lateHitMult');
			--lateHitMult = 0.465; --was to high before (im pretty sure this doesn't need fixing)
			local earlyHitMult = getPropertyFromGroup('notes', iNote, 'earlyHitMult');
			earlyHitMult = 0.275; --was to high before and you would be able to spam the shit outta jacks
			if getPropertyFromGroup('notes', iNote, 'strumTime') > getPropertyFromClass('Conductor', 'songPosition') - (getPropertyFromClass('Conductor', 'safeZoneOffset') * lateHitMult) and getPropertyFromGroup('notes', iNote, 'strumTime') < getPropertyFromClass('Conductor', 'songPosition') + (getPropertyFromClass('Conductor', 'safeZoneOffset') * earlyHitMult) then
				setPropertyFromGroup('notes', iNote, 'canBeHit', true);
			else
				setPropertyFromGroup('notes', iNote, 'canBeHit', false);
			end

			if getPropertyFromGroup('notes', iNote, 'strumTime') -75 < getPropertyFromClass('Conductor', 'songPosition') - getPropertyFromClass('Conductor', 'safeZoneOffset') and getPropertyFromGroup('notes', iNote, 'wasGoodHit') == false then
				setPropertyFromGroup('notes', iNote, 'tooLate', true);
			end
			local assType = getPropertyFromGroup('notes', iNote, 'noteType');
			local directionNOTE = getPropertyFromGroup('notes', iNote, 'noteData');
			local sustainSUS = getPropertyFromGroup('notes', iNote, 'isSustainNote');
			for iKey = 1, #keys do --need to prevent people from holding keys and spamming notes
				if keyJustPressed(keys[iKey]) or keyPressed(keys[iKey]) then
					if getPropertyFromGroup('notes', iNote, 'noteData') == iKey-1 and getPropertyFromGroup('notes', iNote, 'canBeHit') and getPropertyFromGroup('notes', iNote, 'tooLate') == false then
						if getProperty('camZooming') == false then
							setProperty('camZooming', true)
						end
						recalculateShitRating()
						local holdStuff = 0.15;
						if sustainSUS then
							if getPropertyFromGroup('notes', iNote, 'animation.curAnim.name.endsWith') ~= 'end' then
								holdStuff = holdStuff +0.05;
							end
						end
						setProperty('health', getProperty('health') - getPropertyFromGroup('notes', iNote, 'hitHealth') * getProperty('healthGain'))
						missedOn = false;
						local urAnus = '';
						if assType == regularNotes[2] or altAnim then
							urAnus = '-alt'
						end
						if assType == regularNotes[4] or gfSection then
							setProperty('gf.holdTimer', 0)
						else
							setProperty('dad.holdTimer', 0)
						end
						if assType == regularNotes[1] or assType == regularNotes[2] then
							characterPlayAnim('dad', singAnims[iKey]..urAnus, true);
						end
						if assType == regularNotes[3] then
							characterPlayAnim('dad', 'hey', true);
						end
						if assType == regularNotes[4] or gfSection then
							characterPlayAnim('gf', singAnims[iKey]..urAnus, true);
						end
						doRatingShits(true, iNote)
				
						strumAnim(directionNOTE, 'confirm', holdStuff);
						setPropertyFromGroup('notes', iNote, 'wasGoodHit', true)
						callOnLuas('opponentNoteHit', {iNote, directionNOTE, assType, sustainSUS}) --thank god this exists
						removeFromGroup('notes', iNote, false)
					end
				end
				if getPropertyFromGroup('notes', iNote, 'noteData') == iKey-1 and getPropertyFromGroup('notes', iNote, 'tooLate') then
					setProperty('health', getProperty('health') + getPropertyFromGroup('notes', iNote, 'missHealth') * getProperty('healthLoss'))
					setProperty('dad.holdTimer', 0)
					if getProperty('dad.hasMissAnimations') ~= true then
						characterPlayAnim('dad', singAnims[iKey], true);
						setProperty('dad.color', getColorFromHex('800080'))
						missedOn = true;
					else
						characterPlayAnim('dad', singAnims[iKey]..'miss', true);
					end
					doRatingShits(false, iNote)
				
					callOnLuas('noteMiss', {iNote, directionNOTE, assType, sustainSUS}) --thank god this exists
					removeFromGroup('notes', iNote, false)
				end
			end
		end
	end

	for iKey = 1, #keys do
		local fuckingLua = iKey-1;
		if getProperty('strumLineNotes.members['..fuckingLua..'].animation.curAnim.name') == 'confirm' and getProperty('strumLineNotes.members['..fuckingLua..'].resetAnim') <= 0.01 and keyPressed(keys[iKey]) then
			setProperty('strumLineNotes.members['..fuckingLua..'].resetAnim', 0.1)
		end
		if getProperty('strumLineNotes.members['..fuckingLua..'].animation.curAnim.name') == 'static' or getProperty('strumLineNotes.members['..fuckingLua..'].animation.curAnim.name') == 'pressed' then
			if keyJustPressed(keys[iKey]) then
				strumAnim(iKey-1, 'pressed', 0.15)

				if ghostTapping ~= true then
					--miss shit
					setProperty('vocals.volume', 0)
					addScore(-10)
					addMisses(1)
					setProperty('health', getProperty('health') + 0.05 * getProperty('healthLoss'))
					if dadHasMissAnims then
						characterPlayAnim('dad', singAnims[iKey], true);
						setProperty('dad.color', getColorFromHex('800080'))
						missedOn = true;
					else
						characterPlayAnim('dad', singAnims[iKey]..'miss', true);
					end
					missedOn = true;
					callOnLuas('noteMissPress', {iKey-1}) --thank god this exists
				end
			elseif keyPressed(keys[iKey]) then
				setProperty('strumLineNotes.members['..fuckingLua..'].resetAnim', 0.05)
			end
		end
	end

	for i = 0, #singAnims do
		if missedOn == false and dadHasMissAnims ~= true then
			setProperty('dad.color', getColorFromHex('FFFFFF'))
		end
		if getProperty('dad.animation.curAnim.name') == 'idle' and getProperty('dad.color') == getColorFromHex('800080') then
			setProperty('dad.color', getColorFromHex('FFFFFF'))
		end
		--hold time shits
		if keyPressed(keys[i + 1]) then
			if getProperty('dad.animation.curAnim.name') ~= 'idle' then
				setProperty('dad.holdTimer', 0)
			end
			if getProperty('gf.animation.curAnim.name') ~= 'idle' and getProperty('gf.animation.curAnim.name') ~= 'danceLeft' and getProperty('gf.animation.curAnim.name') ~= 'danceRight' and gfSection then
				setProperty('gf.holdTimer', 0)
			end
		end
	end

	if getProperty('health') >= 2 and misses == 0 then --mod support sorta
		setProperty('health', 1.999)
	end

	if getProperty('health') <= 0 then
		setProperty('health', 0.001)
	end

	if getProperty('health') >= 2 then
		setProperty('health', 0)
	end
end

function goodNoteHit(id, direction, noteType, isSustainNote)
	if not opponentPlay then
		return;
	end
	setProperty('health', getProperty('health') - 0.023)
	removeFromGroup('grpNoteSplashes', getProperty('grpNoteSplashes.length') -1, false); --insta killed
end

function strumAnim(direction, fool, timer)
	runHaxeCode([[
		var directionStrum = ]]..direction..[[;
		var animAtion = ']]..fool..[[';
		var time = ']]..timer..[[';
		var strum = game.strumLineNotes.members[directionStrum];
		strum.playAnim(animAtion, true);
		strum.resetAnim = time;
	]])
end

function doRatingShits(hit, ID)
	--call('popUpScore', (getProperty('notes.members['..noteID..']')))
	if getPropertyFromGroup('notes', ID, 'isSustainNote') then
		return;
	end
	if hit then
		setProperty('vocals.volume', 1)

		local noteDiff = math.abs(getPropertyFromGroup('notes', ID, 'strumTime') - getPropertyFromClass('Conductor', 'songPosition'));
		local isSick = true;
		local score = 350;

		if noteDiff > getPropertyFromClass('Conductor', 'safeZoneOffset') * 0.9 then
			score = 50;
		elseif noteDiff > getPropertyFromClass('Conductor', 'safeZoneOffset') * 0.75 then
			score = 100;
		elseif noteDiff > getPropertyFromClass('Conductor', 'safeZoneOffset') * 0.2 then
			score = 200;
		elseif noteDiff < getPropertyFromClass('Conductor', 'safeZoneOffset') * 0.2 then
			isSick = true;
		end

		addScore(score)
	else
		setProperty('vocals.volume', 0)
		addScore(-10)
		addMisses(1)
		callOnLuas('noteMiss', {getPropertyFromGroup('notes', iNote, 'ID'), getPropertyFromGroup('notes', iNote, 'noteData'), getPropertyFromGroup('notes', iNote, 'noteType'), getPropertyFromGroup('notes', iNote, 'isSustainNote')}) --thank god this exists
	end
	actualTotalNotesPlayed = actualTotalNotesPlayed +1;
end

function recalculateShitRating(bad)
	if getProperty('totalPlayed') < 1 then
		ratingName = '?';
	else
		rating = math.min(1, math.max(0, getProperty('totalNotesHit') / getProperty('totalPlayed')))

		--[[if rating >= 1 then
			ratingName = getProperty('ratingStuff.length[0]');
		else	
			for i = 0, getProperty('ratingStuff.length')-1 do
				if rating < getProperty('ratingStuff['..i..'][1]') then
					setProperty('ratingName', getProperty('ratingStuff['..i..'][0]'));
					break;
				end
			end
		end--]]
	end

	if getProperty('sicks') > 0 then 
		ratingFC = "SFC"; 
	end
	if getProperty('goods') > 0 then 
		ratingFC = "GFC"; 
	end
	if getProperty('bads') > 0 or getProperty('shits') > 0 then 
		ratingFC = "FC"; 
	end
	if getProperty('songMisses') > 0 and getProperty('songMisses') < 10 then 
		ratingFC = "SDCB"; 
	elseif getProperty('songMisses') >= 10 then 
		ratingFC = "Clear"; 
	end

	--setOnLuas('ratingFC', ratingFC2)
	updateScore(bad)
end

function updateScore(bad)
	cancelTween('scoreX')
	cancelTween('scoreY')
	if not bad then
		setProperty('scoreTxt.scale.x', 1.075)
		setProperty('scoreTxt.scale.y', 1.075)
		doTweenX('scoreX', 'scoreTxt.scale', 1, 0.2)
		doTweenY('scoreY', 'scoreTxt.scale', 1, 0.2)
	else
		setProperty('scoreTxt.scale.x', 1)
		setProperty('scoreTxt.scale.y', 1)
	end
end

function onDestroy()
	if not opponentPlay then
		return;
	end

	setPropertyFromClass('ClientPrefs', 'comboOffset[0]', prevRatingPos[0])
	setPropertyFromClass('ClientPrefs', 'comboOffset[2]', prevRatingPos[1])
end