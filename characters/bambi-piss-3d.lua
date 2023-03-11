local healthtolower = 0.02;
local originalPos = 0;
local posAmount = 125;
local speedAmount = 3;
local tweenType = 'sineInOut';

function onCreatePost()
    changeNoteSkin(false, 'NOTE_assets_3D')
    setObjectOrder('dadGroup', 99)
    originalPos = getProperty('dad.y')
    doTweenY('bambiUp', 'dad', originalPos -posAmount, speedAmount, tweenType)
end

function onTweenCompleted(tag)
    if tag == 'bambiDown' and getProperty('dad.curCharacter') == 'bambi-piss-3d' then
        doTweenY('bambiUp', 'dad', originalPos -posAmount, speedAmount, tweenType)
    end

    if tag == 'bambiUp' and getProperty('dad.curCharacter') == 'bambi-piss-3d' then
        doTweenY('bambiDown', 'dad', originalPos, speedAmount, tweenType)
    end
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
	setProperty('health', getProperty('health') -(healthtolower / 2.65))
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