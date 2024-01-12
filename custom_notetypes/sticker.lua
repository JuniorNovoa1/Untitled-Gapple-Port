function onCreatePost()
	--Iterate over all notes
	for i = 0, getProperty('unspawnNotes.length')-1 do
		--Check if the note is an Instakill Note
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'sticker' then
			setPropertyFromGroup('unspawnNotes', i, 'texture', 'ui/notes/sticker_notes'); --Change texture
			setPropertyFromGroup('unspawnNotes', i, 'hitHealth', '0.023'); --Default value is: 0.023, health gained on hit
			setPropertyFromGroup('unspawnNotes', i, 'missHealth', '0.0475'); --Default value is: 0.0475, health lost on miss
			--[[if getPropertyFromGroup('unspawnNotes', i, 'noteData') == 0 then
				setPropertyFromGroup('unspawnNotes', i, 'offset.x', 85); --offset
			elseif getPropertyFromGroup('unspawnNotes', i, 'noteData') == 1 then
				setPropertyFromGroup('unspawnNotes', i, 'offset.x', 80); --offset
			elseif getPropertyFromGroup('unspawnNotes', i, 'noteData') == 2 then
				setPropertyFromGroup('unspawnNotes', i, 'offset.x', 65); --offset
			elseif getPropertyFromGroup('unspawnNotes', i, 'noteData') == 3 then
				setPropertyFromGroup('unspawnNotes', i, 'offset.x', 75); --offset
			end
			setPropertyFromGroup('unspawnNotes', i, 'offset.y', 0); --offset--]]
			setPropertyFromGroup('unspawnNotes', i, 'hitCausesMiss', false);

			if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then --Doesn't let Dad/Opponent notes get ignored
				setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', true); --Miss has no penalties
			end
		end
	end
	--debugPrint('Script started!')
end

-- Function called when you hit a note (after note hit calculations)
-- id: The note member id, you can get whatever variable you want from this note, example: "getPropertyFromGroup('notes', id, 'strumTime')"
-- noteData: 0 = Left, 1 = Down, 2 = Up, 3 = Right
-- noteType: The note type string/tag
-- isSustainNote: If it's a hold note, can be either true or false
local scale = 0.8;
local timer = 0.2;
local minAmount = 20;
local maxAmount = 20;
function goodNoteHit(id, noteData, noteType, isSustainNote)
	if getPropertyFromGroup("notes", id, 'noteType') ~= 'sticker' then return; end
	for i = 1, getRandomInt(minAmount, maxAmount) do
		makeLuaSprite("Sticker"..i, "RECOVER_assets/stickers/"..getRandomInt(1, 32), getRandomInt(-200, screenWidth / 1.35), getRandomInt(-200, screenHeight / 1.35))
		setObjectCamera("Sticker"..i, "other")
		setProperty("Sticker"..i..".alpha", 0)
		addLuaSprite("Sticker"..i)
		doTweenAlpha("StickerAA"..i, "Sticker"..i, 1, timer, "")
		doTweenX("StickerX"..i, "Sticker"..i..".scale", scale + 0.2, timer, "")
		doTweenY("StickerY"..i, "Sticker"..i..".scale", scale + 0.2, timer, "")
		runTimer("stickers", 6, 1)
	end
end

function onTweenCompleted(tag)
	for i = 1, maxAmount do
		if tag == 'StickerY'..i then
			doTweenY("StickerY"..i, "Sticker"..i..".scale", scale, timer, "")
		end
		if tag == 'StickerA'..i then
			removeLuaSprite("Sticker"..i, true)
		end
	end
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == "stickers" then
		for i = 1, maxAmount do
			doTweenAlpha("StickerA"..i, "Sticker"..i, 0, timer, "")
		end
	end
end