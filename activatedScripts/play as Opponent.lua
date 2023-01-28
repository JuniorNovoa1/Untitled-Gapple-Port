local opponentPlay = false; --not gonna be used, but if u want to use this enable this variable

local regularNotes = {'', 'Alt Animation', 'Hey!'}
local singAnims = {'singLEFT', 'singDOWN', 'singUP', 'singRIGHT'}
local keys = {'left', 'down', 'up', 'right'}
local lastMissAnim = '';
local ratingPos = 215;
local prevRatingPos = {};
local dadHasMissAnims = false;

local functionIsHappening = false;
local prevPosBFX = {};
local prevPosDADX = {};
local prevPosBFY = {};
local prevPosDADY = {};
local prevSkinsBF = {};
local prevSkinsDAD = {};

function onCreatePost()
	if not opponentPlay then
		return;
	end
	for i = 0, getProperty('unspawnNotes.length') -1 do
		if getPropertyFromGroup('unspawnNotes', i, 'mustPress') == true then
			setPropertyFromGroup('unspawnNotes', i, 'mustPress', false)
		else
			setPropertyFromGroup('unspawnNotes', i, 'mustPress', true)
		end

		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == regularNotes[1] or getPropertyFromGroup('unspawnNotes', i, 'noteType') == regularNotes[2] or getPropertyFromGroup('unspawnNotes', i, 'noteType') == regularNotes[3] then
			setPropertyFromGroup('unspawnNotes', i, 'noAnimation', true)
		end
	end

	if not middlescroll then
		prevRatingPos[0] = getPropertyFromClass('ClientPrefs', 'comboOffset[0]');
		prevRatingPos[1] = getPropertyFromClass('ClientPrefs', 'comboOffset[2]');
		setPropertyFromClass('ClientPrefs', 'comboOffset[0]', ratingPos)
		setPropertyFromClass('ClientPrefs', 'comboOffset[2]', ratingPos)
	end

	swapNotePos();
	if middlescroll then
		swapNotePos();
	end
end

function onStartCountdown()
	swapNoteVariables();
	--swapNotePos();
end

function onSongStart()
	swapNoteSkins();
end

function onUpdate()
	if not opponentPlay then
		return;
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

	setProperty('boyfriend.hasMissAnimations', false);
	dadHasMissAnims = getProperty('dad.hasMissAnimations');

	for i = 0, #singAnims do
		if getProperty('dad.animation.curAnim.name') ~= lastMissAnim and dadHasMissAnims ~= true then
			setProperty('dad.color', getColorFromHex('FFFFFF'))
			lastMissAnim = '';
		end
		--hold time shits
		if getProperty('dad.animation.curAnim.name') == singAnims[i + 1] and keyPressed(keys[i + 1]) then
			setProperty('dad.holdTimer', 0)
		end
	end

	for i = 0, 4 do
		local bfnoteX = {};
		local dadnoteX = {};
		local bfnoteY = {};
		local dadnoteY = {};
		local bfskin = {};
		local dadskin = {};

		bfnoteX[i] = getPropertyFromGroup('playerStrums', i, 'x')
		dadnoteX[i] = getPropertyFromGroup('opponentStrums', i, 'x')
		bfnoteY[i] = getPropertyFromGroup('playerStrums', i, 'y')
		dadnoteY[i] = getPropertyFromGroup('opponentStrums', i, 'y')
		bfskin[i] = getPropertyFromGroup('playerStrums', i, 'texture')
		dadskin[i] = getPropertyFromGroup('opponentStrums', i, 'texture')

		swapNoteVariables();

		if functionIsHappening == false then
			if bfnoteX[i] ~= prevPosBFX[i] then
				swapNotePos();
			end
			if dadnoteX[i] ~= prevPosDADX[i] then
				swapNotePos();
			end
			if bfnoteY[i] ~= prevPosBFY[i] then
				swapNotePos();
			end
			if dadnoteY[i] ~= prevPosDADY[i] then
				swapNotePos();
			end
			if bfskin[i] ~= prevSkinsBF[i] then
				swapNoteSkins();
			end
			if dadskin[i] ~= prevSkinsBF[i] then
				swapNoteSkins();
			end
		end
	end
end

local dontSpamLuasCalls = false;

function goodNoteHit(id, direction, noteType, isSustainNote)
	if not opponentPlay then
		return;
	end

	if getProperty('camZooming') == false then
		setProperty('camZooming', true)
	end
	if dontSpamLuasCalls == true then
		return;
	end
	dontSpamLuasCalls = true;
	callOnLuas('opponentNoteHit', {id, direction, noteType, isSustainNote}) --thank god this exists
	dontSpamLuasCalls = false;
	if isSustainNote == true then
		setProperty('health', getProperty('health') - 0.032)
	else 
		setProperty('health', getProperty('health') - 0.046)
	end
	lastMissAnim = '';

	local urAnus = '';
	if noteType == regularNotes[2] then
		urAnus = '-alt'
	end
	if noteType == regularNotes[1] or noteType == regularNotes[2] then
		characterPlayAnim('dad', singAnims[direction + 1]..urAnus, true);
	end
	if noteType == regularNotes[3] then
		characterPlayAnim('dad', 'hey', true);
	end
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
	if not opponentPlay then
		return;
	end

	if dontSpamLuasCalls == true then
		return;
	end
	dontSpamLuasCalls = true;
	callOnLuas('goodNoteHit', {id, direction, noteType, isSustainNote}, false, false, 'play as Opponent') --thank god this exists
	dontSpamLuasCalls = false;
	setProperty('boyfriend.holdTimer', 0)

	local urAnus = '';
	if noteType == regularNotes[2] then
		urAnus = '-alt'
	end
	if noteType == regularNotes[1] or noteType == regularNotes[2] then
		characterPlayAnim('boyfriend', singAnims[direction + 1]..urAnus, true);
	end
	if noteType == regularNotes[3] then
		characterPlayAnim('boyfriend', 'hey', true);
	end
end

function noteMiss(id, direction, noteType, isSustainNote)
	missShit(direction);
end
function noteMissPress(direction)
	missShit(direction);
end

function missShit(direction)
	if not opponentPlay then
		return;
	end

	setProperty('health', getProperty('health') + 0.095)
	setProperty('dad.holdTimer', 0)
	if getProperty('dad.hasMissAnimations') ~= true then
		characterPlayAnim('dad', singAnims[direction + 1], true);
		setProperty('dad.color', getColorFromHex('800080'))
		lastMissAnim = getProperty('dad.animation.curAnim.name');
	else
		characterPlayAnim('dad', singAnims[direction + 1]..'miss', true);
	end
end

function onDestroy()
	if not opponentPlay then
		return;
	end

	setPropertyFromClass('ClientPrefs', 'comboOffset[0]', prevRatingPos[0])
	setPropertyFromClass('ClientPrefs', 'comboOffset[2]', prevRatingPos[1])
end

function swapNoteVariables()
	if not opponentPlay then
		return;
	end

	local vars = {'alpha', 'visible'};
	local varsBF = {};
	local varsDAD = {};

	for i = 0, #vars do
		varsBF[i] = getPropertyFromGroup('playerStrums', i, vars[i])
		varsDAD[i] = getPropertyFromGroup('opponentStrums', i, vars[i])
		setPropertyFromGroup('playerStrums', i, vars[i], varsDAD[i])
		setPropertyFromGroup('opponentStrums', i, vars[i], varsBF[i])
	end
end

function swapNotePos()
	if not opponentPlay then
		return;
	end

	functionIsHappening = true;
	local bfXpos = {};
	local dadXpos = {};
	local bfYpos = {};
	local dadYpos = {};

	for i = 0, 3 do
		bfXpos[i] = getPropertyFromGroup('playerStrums', i, 'x')
		dadXpos[i] = getPropertyFromGroup('opponentStrums', i, 'x')
		bfYpos[i] = getPropertyFromGroup('playerStrums', i, 'y')
		dadYpos[i] = getPropertyFromGroup('opponentStrums', i, 'y')
		setPropertyFromGroup('playerStrums', i, 'x', dadXpos[i])
		setPropertyFromGroup('opponentStrums', i, 'x', bfXpos[i])
		setPropertyFromGroup('playerStrums', i, 'y', dadYpos[i])
		setPropertyFromGroup('opponentStrums', i, 'y', bfYpos[i])
		prevPosBFX[i] = bfXpos[i];
		prevPosDADX[i] = dadXpos[i];
		prevPosBFY[i] = bfYpos[i];
		prevPosDADY[i] = dadYpos[i];
	end
	functionIsHappening = false;
end

function swapNoteSkins()
	if not opponentPlay then
		return;
	end

	functionIsHappening = true;
	local bfskin = {};
	local dadskin = {};

	for i = 0, 4 do
		bfskin[i] = getPropertyFromGroup('playerStrums', i, 'texture')
		dadskin[i] = getPropertyFromGroup('opponentStrums', i, 'texture')
		setPropertyFromGroup('playerStrums', i, 'texture', dadskin[i])
		setPropertyFromGroup('opponentStrums', i, 'texture', bfskin[i])
		prevSkinsBF[i] = bfskin[i];
		prevSkinsDAD[i] = dadskin[i];
	end

	for i = 0, getProperty('notes.length') -1 do
		if getPropertyFromGroup('notes', i, 'mustPress') == true then
			if getPropertyFromGroup('notes', i, 'noteType') == regularNotes[1] or getPropertyFromGroup('notes', i, 'noteType') == regularNotes[2] or getPropertyFromGroup('notes', i, 'noteType') == regularNotes[3] then
				setPropertyFromGroup('notes', i, 'texture', dadskin[getPropertyFromGroup('notes', i, 'noteData')])
			end
		else
			if getPropertyFromGroup('notes', i, 'noteType') == regularNotes[1] or getPropertyFromGroup('notes', i, 'noteType') == regularNotes[2] or getPropertyFromGroup('notes', i, 'noteType') == regularNotes[3] then
				setPropertyFromGroup('notes', i, 'texture', bfskin[getPropertyFromGroup('notes', i, 'noteData')])
			end
		end
	end

	for i = 0, getProperty('unspawnNotes.length') -1 do
		if getPropertyFromGroup('unspawnNotes', i, 'mustPress') == true then
			if getPropertyFromGroup('unspawnNotes', i, 'noteType') == regularNotes[1] or getPropertyFromGroup('unspawnNotes', i, 'noteType') == regularNotes[2] or getPropertyFromGroup('unspawnNotes', i, 'noteType') == regularNotes[3] then
				setPropertyFromGroup('unspawnNotes', i, 'texture', dadskin[getPropertyFromGroup('unspawnNotes', i, 'noteData')])
			end
		else
			if getPropertyFromGroup('unspawnNotes', i, 'noteType') == regularNotes[1] or getPropertyFromGroup('unspawnNotes', i, 'noteType') == regularNotes[2] or getPropertyFromGroup('unspawnNotes', i, 'noteType') == regularNotes[3] then
				setPropertyFromGroup('unspawnNotes', i, 'texture', bfskin[getPropertyFromGroup('unspawnNotes', i, 'noteData')])
			end
		end
	end
	functionIsHappening = false;
end