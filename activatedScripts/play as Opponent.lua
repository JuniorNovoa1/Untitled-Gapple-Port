--not gonna be used but if u want to use it just add this to the scripts folder
local singAnims = {'singLEFT', 'singDOWN', 'singUP', 'singRIGHT'}
local keys = {'left', 'down', 'up', 'right'}
local lastMissAnim = '';
local offsetAmount = 150;

function onCreatePost()
	local bfXpos = {};
	local dadXpos = {};

	for i = 0, 3 do
		bfXpos[i] = getPropertyFromGroup('playerStrums', i, 'x')
		dadXpos[i] = getPropertyFromGroup('opponentStrums', i, 'x')
		setPropertyFromGroup('playerStrums', i, 'x', dadXpos[i])
		setPropertyFromGroup('opponentStrums', i, 'x', bfXpos[i])
	end

	for i = 0, getProperty('unspawnNotes.length') -1 do
		if getPropertyFromGroup('unspawnNotes', i, 'mustPress') == true then
			setPropertyFromGroup('unspawnNotes', i, 'mustPress', false)
		else
			setPropertyFromGroup('unspawnNotes', i, 'mustPress', true)
		end

		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == '' or getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Alt Animation' then
			setPropertyFromGroup('unspawnNotes', i, 'noAnimation', true)
		end
	end

	setProperty('boyfriend.hasMissAnimations', false);
	setPropertyFromClass('ClientPrefs', 'comboOffset[0]', getPropertyFromClass('ClientPrefs', 'comboOffset[0]') + offsetAmount)
	setPropertyFromClass('ClientPrefs', 'comboOffset[2]', getPropertyFromClass('ClientPrefs', 'comboOffset[2]') + offsetAmount)
end

function onSongStart()
	local bfskin = {};
	local dadskin = {};

	for i = 0, 4 do
		bfskin[i] = getPropertyFromGroup('playerStrums', i, 'texture')
		dadskin[i] = getPropertyFromGroup('opponentStrums', i, 'texture')
		setPropertyFromGroup('playerStrums', i, 'texture', dadskin[i])
		setPropertyFromGroup('opponentStrums', i, 'texture', bfskin[i])
	end

	for i = 0, getProperty('notes.length') -1 do
		if getPropertyFromGroup('notes', i, 'mustPress') == true then
			if getPropertyFromGroup('notes', i, 'noteType') == '' or getPropertyFromGroup('notes', i, 'noteType') == 'Alt Animation' then
				setPropertyFromGroup('notes', i, 'texture', dadskin[getPropertyFromGroup('notes', i, 'noteData')])
			end
		else
			if getPropertyFromGroup('notes', i, 'noteType') == '' or getPropertyFromGroup('notes', i, 'noteType') == 'Alt Animation' then
				setPropertyFromGroup('notes', i, 'texture', bfskin[getPropertyFromGroup('notes', i, 'noteData')])
			end
		end
	end

	for i = 0, getProperty('unspawnNotes.length') -1 do
		if getPropertyFromGroup('unspawnNotes', i, 'mustPress') == true then
			if getPropertyFromGroup('unspawnNotes', i, 'noteType') == '' or getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Alt Animation' then
				setPropertyFromGroup('unspawnNotes', i, 'texture', dadskin[getPropertyFromGroup('unspawnNotes', i, 'noteData')])
			end
		else
			if getPropertyFromGroup('unspawnNotes', i, 'noteType') == '' or getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Alt Animation' then
				setPropertyFromGroup('unspawnNotes', i, 'texture', bfskin[getPropertyFromGroup('unspawnNotes', i, 'noteData')])
			end
		end
	end
end

function onUpdate()	
	if getProperty('health') <= 0 then
		setProperty('health', 0.001)
	end

	if getProperty('health') >= 2 then
		setProperty('health', 0)
	end

	for i = 0, #singAnims do
		if getProperty('dad.animation.curAnim.name') ~= lastMissAnim then
			setProperty('dad.color', getColorFromHex('FFFFFF'))
			lastMissAnim = '';
		end
		--hold time shits
		if getProperty('dad.animation.curAnim.name') == singAnims[i + 1] and keyPressed(keys[i + 1]) then
			setProperty('dad.holdTimer', 0)
		end
	end
end

function goodNoteHit(id, direction, noteType, isSustainNote)
	setProperty('health', getProperty('health') - 0.046)
	lastMissAnim = '';

	local urAnus = '';
	if noteType == 'Alt Animation' then
		urAnus = '-alt'
	end
	if noteType == '' or noteType == 'Alt Animation' then
		characterPlayAnim('dad', singAnims[direction + 1]..urAnus, true);
	end
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
	setProperty('boyfriend.holdTimer', 0)

	local urAnus = '';
	if noteType == 'Alt Animation' then
		urAnus = '-alt'
	end
	if noteType == '' or noteType == 'Alt Animation' then
		characterPlayAnim('boyfriend', singAnims[direction + 1]..urAnus, true);
	end
end

function noteMiss(id, direction, noteType, isSustainNote)
	missShit(direction);
end
function noteMissPress(direction)
	missShit(direction);
end

function missShit(direction)
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
	setPropertyFromClass('ClientPrefs', 'comboOffset[0]', getPropertyFromClass('ClientPrefs', 'comboOffset[0]') - offsetAmount)
	setPropertyFromClass('ClientPrefs', 'comboOffset[2]', getPropertyFromClass('ClientPrefs', 'comboOffset[2]') - offsetAmount)
end