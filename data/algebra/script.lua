local originalSpeed = 3;
local swagSpeed = 1.6;

function onCreatePost()
	makeLuaSprite('thunderBlack', '', getProperty("bg.x"), getProperty("bg.y"))
    makeGraphic('thunderBlack', getProperty("bg.width"), getProperty("bg.height"), '000000')
    setProperty('thunderBlack.antialiasing', getPropertyFromClass('ClientPrefs', 'globalAntialiasing'))
    setProperty('thunderBlack.alpha', 0)
    addLuaSprite('thunderBlack', true)
end

local lockCam = false;
local camZoomA = 1.25;

function onUpdate()
	if lockCam then
        setDataFromSave('settings', 'camZoom', false)
        doTweenZoom('camZoomGame', 'camGame', camZoomA, 1, "")
    else
        setDataFromSave('settings', 'camZoom', true)
    end

	runHaxeCode([[game.set_songSpeed(]]..swagSpeed..[[);]])
end

function onBeatHit()
	if curBeat == 8 or curBeat == 72 or curBeat == 104 or curBeat == 152 or curBeat == 224 or curBeat == 256 or curBeat == 288 or curBeat == 320 or curBeat == 416 or curBeat == 472 or curBeat == 504 or curBeat == 544 
	or curBeat == 576 or curBeat == 608 or curBeat == 640 or curBeat == 672 or curBeat == 704 or curBeat == 736 or curBeat == 740 or curBeat == 772 or curBeat == 804 or curBeat == 860 or curBeat == 907 or curBeat == 923 
	or curBeat == 931 or curBeat == 935 or curBeat == 939 or curBeat == 942 or curBeat == 1008 or curBeat == 1072 or curBeat == 1168 or curBeat == 1232 or curBeat == 1295 and flashingLights then
		cameraFlash('other', 'FFFFFF', 1.5) --cam flash simulator
	end

	if curBeat == 160 then
		swagSpeed = originalSpeed - 0.5;
		setProperty("daveJunk.visible", true)
	end

	if curBeat == 224 then
		camZoomA = getProperty("defaultCamZoom") + 0.3;
		lockCam = true;
	end

	if curBeat == 256 then
		lockCam = false;
	end

	if curBeat == 288 then
		lockCam = true;
		doTweenAlpha("thunderBlack", "thunderBlack", 0.35, crochet / 500, "")
	end

	if curBeat == 320 then
		lockCam = false;
		doTweenAlpha("thunderBlack", "thunderBlack", 0, crochet / 500, "")
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

	if curBeat == 436 then
		lockCam = true;
	end

	if curBeat == 439 then
		lockCam = false;
	end

	if curBeat == 440 then
		setProperty("spike.visible", true)
		setProperty("davePiss.visible", false)
	end

	if curBeat == 472 then
		camZoomA = getProperty("defaultCamZoom") + 0.1;
		lockCam = true;
	end

	if curBeat == 504 then
		setProperty("defaultCamZoom", getProperty("defaultCamZoom") + 0.15)
        lockCam = false;
	end

	if curBeat == 512 then
		setProperty("diamondJunk.visible", true)
		setProperty("davePiss.visible", true)
		swagSpeed = 2;
	end

	if curBeat == 672 then
		setProperty("defaultCamZoom", getProperty("defaultCamZoom") + 0.05)
	end

	if curBeat == 740 then
		setProperty("defaultCamZoom", getProperty("defaultCamZoom") - 0.05)
	end

	if curBeat == 836 then
		setProperty("diamondJunk.visible", false)
		setProperty("monitorJunk.visible", true)
		swagSpeed = originalSpeed - 0.5;
	end

	if curBeat == 862 then
		setProperty("defaultCamZoom", getProperty("defaultCamZoom") + 0.05)
	end

	if curBeat == 876 then
		setProperty("defaultCamZoom", getProperty("defaultCamZoom") - 0.05)
	end

	if curBeat == 942 then
		camZoomA = getProperty("defaultCamZoom") + 0.4;
		lockCam = true;
	end

	if curBeat == 943 then
		lockCam = false;
	end

	if curBeat == 1008 then
		camZoomA = 0.9;
		lockCam = true;
		setProperty("defaultCamZoom", 1)
	end

	if curBeat == 1344 then
		--setProperty("monitorJunk.visible", true)
		--swagSpeed = originalSpeed - 0.5;
	end

	if curBeat == 1136 then
		--[[makeLuaSprite('diamondJunk', 'main/algebra/bgJunkers/Crafters_Ohno', 645 + 75, -16);
		setProperty("diamondJunk.scale.x", 0.6)
		setProperty("diamondJunk.scale.y", 0.6)
		addLuaSprite('diamondJunk', false);--]]
		setProperty("diamondJunk.visible", true)
		lockCam = false;
		setProperty("defaultCamZoom", 1.1)
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
		setProperty("monitorJunk.visible", false)
		setProperty("diamondJunk.visible", false)
		setProperty("davePiss.visible", false)
		setProperty("robotJunk.visible", false)
	end
	if curBeat == 1588 then
		swagSpeed = originalSpeed + 0.9;
	end
end

function goodNoteHit(membersIndex, noteData, noteType, isSustainNote) spikeHit(noteData, isSustainNote) end
function opponentNoteHit(membersIndex, noteData, noteType, isSustainNote) spikeHit(noteData, isSustainNote) end
function spikeHit(noteData, isSustainNote)
	if isSustainNote then return; end
	local singAnims = {'singLEFT', 'singDOWN', 'singUP', 'singRIGHT'};
	runHaxeCode([[spike.holdTimer = 0;]])
	playAnim('spike', singAnims[noteData + 1], true)
end


function onEvent(eventName, value1, value2)
	if eventName == 'Change Character' then
		if flashingLights then
			cameraFlash('other', 'FFFFFF', 1)
		end
	end
end