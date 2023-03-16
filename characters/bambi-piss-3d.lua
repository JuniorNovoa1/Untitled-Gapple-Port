local healthtolower = 0.02;
local originalPos = 0;
local posAmount = 125;
local speedAmount = 3;
local tweenType = 'sineInOut';
local dad = 'dad'

function onCreatePost()
    changeNoteSkin(false, 'NOTE_assets_3D')
    setObjectOrder('dadGroup', 99)
    originalPos = getProperty('dad.y')
    if getProperty('gf.curCharacter') == 'bambi-piss-3d' then
        dad = 'gf';
    end
    if songName ~= 'Applecore' then
        doTweenY('bambiUp', dad, originalPos -posAmount, speedAmount, tweenType)
    end
end

function onTweenCompleted(tag)
    if tag == 'bambiDown' and (getProperty('gf.curCharacter') == 'bambi-piss-3d' or getProperty('dad.curCharacter') == 'bambi-piss-3d') then
        doTweenY('bambiUp', dad, originalPos -posAmount, speedAmount, tweenType)
    end

    if tag == 'bambiUp' and (getProperty('gf.curCharacter') == 'bambi-piss-3d' or getProperty('dad.curCharacter') == 'bambi-piss-3d') then
        doTweenY('bambiDown', dad, originalPos, speedAmount, tweenType)
    end
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
    if songName ~= 'Applecore' then
	    setProperty('health', getProperty('health') -(healthtolower / 2.65))
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