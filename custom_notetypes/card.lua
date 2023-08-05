function onCreatePost()
    --Iterate over all notes
    for i = 0, getProperty('unspawnNotes.length')-1 do
        if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'card' then
            setPropertyFromGroup('unspawnNotes', i, 'texture', 'noteSkins/giftcard_notes');
            if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then --Doesn't let Dad/Opponent notes get ignored
                setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', true); --Miss has no penalties
            end
        end
    end

    makeLuaSprite("card", "cardy", 0, 0)
    setObjectCamera("card", 'hud')
    updateHitbox("card")
    screenCenter("card", 'y')
    addLuaSprite("card", false)

    makeLuaText("cardValue", "", 0, getProperty("card.width") + 2, getProperty("card.height") * 2 + 8)
    setObjectCamera("cardValue", 'hud')
    setTextFont("cardValue", "comic.ttf")
    setTextColor("cardValue", "FFFFFF")
    setTextSize("cardValue", 24)
    addLuaText("cardValue")
end

local money = 10;

function onUpdate(elapsed)
    setTextString("cardValue", "$"..money)
end

function goodNoteHit(id, noteData, noteType, isSustainNote)
    if isSustainNote then return; end
	if noteType == 'card' then
        money = money + 5;
    else
        money = money + 1;
    end
end

function noteMiss(membersIndex, noteData, noteType, isSustainNote)
    money = money - 1;
end
function noteMissPress(direction)
    money = money - 1;
end