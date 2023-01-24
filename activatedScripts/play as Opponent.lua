--not gonna be used but if u want to use it just add this to the scripts folder
local bfSingDuration = 0;
local dadSingDuration = 0;

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

	setProperty('boyfriend.singDuration', getProperty('boyfriend.singDuration') * 3);
	setProperty('dad.singDuration', getProperty('dad.singDuration') * 3);
	--bfSingDuration = getProperty('boyfriend.singDuration');
	--dadSingDuration = getProperty('dad.singDuration');
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
end

local singAnims = {'singLEFT', 'singDOWN', 'singUP', 'singRIGHT'}

function goodNoteHit(id, direction, noteType, isSustainNote)
	setProperty('health', getProperty('health') - 0.046)

	local urAnus = '';
	if noteType == 'Alt Animation' then
		urAnus = '-alt'
	end
	if noteType == '' or noteType == 'Alt Animation' then
		characterPlayAnim('dad', singAnims[direction + 1]..urAnus, true);
	end
	if noteType == 'custom note type' then
		--do something
	end
	--setProperty('dad.singDuration', getProperty('dad.singDuration') * 1000);
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
	local urAnus = '';
	if noteType == 'Alt Animation' then
		urAnus = '-alt'
	end
	if noteType == '' or noteType == 'Alt Animation' then
		characterPlayAnim('boyfriend', singAnims[direction + 1]..urAnus, true);
	end
	if noteType == 'custom note type' then
		--do something
	end
	--setProperty('boyfriend.singDuration', getProperty('boyfriend.singDuration') * 1000);
end

--[[function onBeatHit()
	if mustHitSection then
		setProperty('boyfriend.singDuration', bfSingDuration * 2.25);
	else
		setProperty('dad.singDuration', dadSingDuration * 2.25);
	end
end--]]

function noteMiss(id, direction, noteType, isSustainNote)
	setProperty('health', getProperty('health') + 0.095)
end
function noteMissPress(direction)
	setProperty('health', getProperty('health') + 0.095)
end