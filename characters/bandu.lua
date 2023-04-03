local originalPos = 0;
local posAmount = 1075;
local speedAmount = 1.5;
local tweenType = 'sineInOut';

function onCreatePost()
    changeNoteSkin(false, 'NOTE_assets_3D')
    setObjectOrder('dadGroup', getObjectOrder('boyfriendGroup') -1)
    originalPos = getProperty('dad.x')
end

function onCountdownTick(tick)
    if tick == 69 then
        doTweenX('banduRight', 'dad', originalPos +posAmount, speedAmount, tweenType)
    end
end

function onTweenCompleted(tag)
    if tag == 'banduLeft' and (getProperty('dad.curCharacter') == 'bandu' or getProperty('dad.curCharacter') == 'bandu-sad') then
        doTweenX('banduRight', 'dad', originalPos +posAmount, speedAmount, tweenType)
        setObjectOrder('dadGroup', getObjectOrder('boyfriendGroup') -1)
    end

    if tag == 'banduRight' and (getProperty('dad.curCharacter') == 'bandu' or getProperty('dad.curCharacter') == 'bandu-sad') then
        doTweenX('banduLeft', 'dad', originalPos, speedAmount, tweenType)
        setObjectOrder('dadGroup', getObjectOrder('boyfriendGroup') +1)
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