local originalSpeed = 3;
local swagSpeed = 1.6;

function onUpdate()
	setProperty("SONG.speed", swagSpeed)
end

function onBeatHit()
	if curBeat == 160 then
		swagSpeed = originalSpeed - 0.5;
		setProperty("daveJunk.visible", true)
	end

	if curBeat == 352 then
		setProperty("spike.visible", true)
		setProperty("daveJunk.visible", false)
		swagSpeed = originalSpeed - 0.3;
	end

	if curBeat == 432 then
		setProperty("spike.visible", false)
		setProperty("davePiss.visible", true)
	end

	if curBeat == 440 then
		setProperty("spike.visible", true)
		setProperty("davePiss.visible", false)
	end

	if curBeat == 512 then
		setProperty("diamondJunk.visible", true)
		setProperty("davePiss.visible", true)
		swagSpeed = 2;
	end

	if curBeat == 836 then
		setProperty("diamondJunk.visible", false)
		setProperty("monitorJunk.visible", true)
		swagSpeed = originalSpeed - 0.5;
	end

	if curBeat == 1344 then
		--setProperty("monitorJunk.visible", true)
		--swagSpeed = originalSpeed - 0.5;
	end

	if curBeat == 1136 then
		makeLuaSprite('diamondJunk', 'main/algebra/bgJunkers/Crafters_Ohno', 645 + 75, -16);
		addLuaSprite('diamondJunk', false);
		setProperty("diamondJunk.visible", true)
		swagSpeed = 1.6;
	end

	if curBeat == 1293 then
		doTweenX("davePiss", "davePiss", getProperty("davePiss.x") -250, 0.5, "quadOut")
		playAnim("davePiss", "d")
	end

	if curBeat == 1295 then
		swagSpeed = originalSpeed;
	end
	if curBeat == 1436 then
		setProperty("davePiss.visible", false)
		setProperty("robotJunk.visible", true)
	end
	if curBeat == 1588 then
		swagSpeed = originalSpeed + 0.9;
	end
end

function goodNoteHit(membersIndex, noteData, noteType, isSustainNote) spikeHit(noteData) end
function opponentNoteHit(membersIndex, noteData, noteType, isSustainNote) spikeHit(noteData) end
function spikeHit(noteData)
	local singAnims = {'singLEFT', 'singDOWN', 'singUP', 'singRIGHT'};
	runHaxeCode([[spike.holdTimer = 0;]])
	playAnim('spike', singAnims[noteData + 1], true)
end


function onEvent(eventName, value1, value2)
	if eventName == 'Change Character' then
		if flashingLights then
			cameraFlash('other', 'FFFFFF', 1.5)
		end
	end
end