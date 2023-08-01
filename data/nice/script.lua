local lockCam = false;
local zoomCam = false;
local zoomCamVal = 1;
local zoomCamTime = 1;

function onCreate() precacheImage("modly_pad_notes") end

function onUpdate(elapsed)
    if lockCam then moveCam(650, 450) end

    if zoomCam then
        setDataFromSave("Juniors Ports Stuff", 'camZoom', false)
        doTweenZoom('camZoomGame', 'camGame', zoomCamVal, zoomCamTime, "")
    end
end

local camItems = {'scoreTxt', 'creditsWatermark', 'timeTxt', 'iconP1', 'iconP2', 'healthBarBG', 'healthBar'}

function onStepHit()
    if curStep == 544 or curStep == 1583 or curStep == 1840 or curStep == 2096 or curStep == 2672 or curStep == 4063 or curStep == 4191 or curStep == 7824 and flashingLights then 
        cameraFlash('other', 'FFFFFF', 1) --cam flash simulator dlc
    end
    if curStep == 512 then
        zoomCamVal = getProperty("defaultCamZoom") + 0.2;
        zoomCamTime = 3;
        zoomCam = true;
    end

    if curStep == 544 then
        zoomCamVal = getProperty("defaultCamZoom") - 0.2;
        zoomCamTime = 3;
    end

    if curStep == 555 then zoomCam = false; end

    if curStep == 1364 then
        setProperty("defaultCamZoom", getProperty("defaultCamZoom") + 0.2)
    end

    if curStep == 1374 then
        setProperty("defaultCamZoom", getProperty("defaultCamZoom") - 0.2)
    end

    if curStep == 2096 then 
        lockCam = true; 
        setProperty("defaultCamZoom", getProperty("defaultCamZoom") + 0.2)
    end

    if curStep == 2140 then 
        setProperty("boyfriend.visible", false)
        setProperty("dad.visible", false)
        playAnim("schoolEntrance", "animEnter", true)
        setDataFromSave("Juniors Ports Stuff", 'newCamZoom', true) --this is where this shit needs to kick in
    end

    if curStep == 2144 then
        setProperty("defaultCamZoom", getProperty("defaultCamZoom") - 0.2)
        setProperty("boyfriend.visible", true)
        setProperty("dad.visible", true)
        setProperty("defaultCamZoom", 0.9)
        lockCam = false;
    end

    if curStep == 3290 then
        setProperty("boyfriend.visible", false)
        setProperty("boyfriend.x", getProperty("boyfriend.x") + 200)
        setProperty("boyfriend.y", getProperty("boyfriend.y") + 100)
        setProperty("dad.visible", false)
        removeLuaSprite("schoolEntrance", true)
        playAnim("schoolBamber", "animEnter", true)
        lockCam = true;
    end

    if curStep == 3296 then 
        setProperty("boyfriend.visible", true)
        setProperty("dad.visible", true)
        setProperty("defaultCamZoom", 0.65)
        lockCam = false;
    end

    --3935 bambi dancer!!

    if curStep == 4063 then
        for i = 1, 2 do
            setProperty("cornBG"..i..'.visible', true)
        end
        for i = 1, #camItems do
            doTweenAlpha("object"..i, camItems[i], 0, 1, "")
        end
        for i = 1, getProperty("strumLineNotes.length") do
            noteTweenAlpha("note"..i, i, 0, 1)
        end
        setProperty("funGames.visible", true)
    end

    if curStep == 4191 then
        for i = 1, 2 do
            removeLuaSprite("cornBG"..i, true)
        end
        for i = 1, #camItems do
            setProperty(camItems[i]..'.alpha', 1)
        end
        for i = 1, getProperty("strumLineNotes.length") do
            noteTweenAlpha("note"..i, i, 1, 0.01)
        end
        removeLuaSprite("funGames", true)
    end

    if curStep == 5023 then
        doTweenAlpha("bambi", "bambiCutscene", 1, 0.2, "")
        playAnim("bambiCutscene", "grr")
    end

    if curStep == 5055 then
        removeLuaSprite("bambiCutscene", true)
        setProperty("bfCutscene.visible", true)
    end

    if curStep == 5071 then
        doTweenAlpha("bf", "bfCutscene", 0, 0.2, "")
        zoomCamVal = getProperty("defaultCamZoom") + 0.3;
        zoomCam = true;
    end

    --5080 bambi screamm

    if curStep == 5087 then
        zoomCamVal = zoomCamVal - 0.25;
        zoomCamTime = 2;
    end

    if curStep == 5160 then zoomCam = false; end

    if curStep == 5471 then
        zoomCamVal = getProperty("defaultCamZoom") + 0.25;
        zoomCamTime = 2.25;
        zoomCam = true;
    end

    if curStep == 5727 then
        zoomCamVal = zoomCamVal - 0.25;
    end

    if curStep == 5791 then
        zoomCam = false;
        doTweenY("phone", "phone", -150, 0.8, "")
        for i = 0, getProperty("strumLineNotes.length") do
            noteTweenAlpha("notes"..i, i, 0, 0.8, "")
        end
    end

    if curStep == 5804 then
        changeNoteSkin(true, 'modly_pad_notes')
        for i = 0, getProperty("playerStrums.length") do
            scaleObject("playerStrums.members["..i.."]", 1.8, 1.8)
            setPropertyFromGroup("playerStrums", i, 'x', getPropertyFromGroup("playerStrums", i, 'x') - 275)
            setPropertyFromGroup("playerStrums", i, 'y', getPropertyFromGroup("playerStrums", i, 'y') + 135)
            if downscroll then setPropertyFromGroup("playerStrums", i, 'y', getPropertyFromGroup("playerStrums", i, 'y') - (215 + 135)) end
            noteTweenAlpha("note"..i, 4 + i, 1, 0.5 * (i + 1), "")
        end

        --[[for i = 0, getProperty("unspawnNotes.length") do
            if getPropertyFromGroup("unspawnNotes", i, 'mustPress') then
                setPropertyFromGroup("unspawnNotes", i, 'offset.x', 50)
            end
        end--]]
    end

    if curStep == 6447 then
        doTweenY("phoneExit", "phone", 600, 0.4, "")
        changeNoteSkin(false, 'NOTE_assets')
        for i = 0, getProperty("strumLineNotes.length") do
            setPropertyFromGroup("strumLineNotes", i, 'alpha', 1)
        end
        for i = 0, getProperty("playerStrums.length") do
            scaleObject("playerStrums.members["..i.."]", 0.7, 0.7)
            setPropertyFromGroup("playerStrums", i, 'x', getPropertyFromGroup("playerStrums", i, 'x') + 275)
            setPropertyFromGroup("playerStrums", i, 'y', getPropertyFromGroup("playerStrums", i, 'y') - 135)
            if downscroll then setPropertyFromGroup("playerStrums", i, 'y', getPropertyFromGroup("playerStrums", i, 'y') + (215 + 135)) end
        end
        changeNoteSkin(false, 'NOTE_assets')
    end

    if curStep == 7626 then
        setProperty("errung.x", getProperty("dad.x") -1000)
        setProperty("errung.y", getProperty("dad.y") + 50)
        setProperty("errung.visible", true)
        doTweenX('errung', 'errung', getProperty("dad.x") - 100, 0.5)
    end

    if curStep == 7824 then
        setProperty("errung.color", getColorFromHex("FFFFFF"))
    end
end

function onEvent(eventName, value1, value2)
	if eventName == 'Change Character' then
		if flashingLights then
			cameraFlash('other', 'FFFFFF', 1)
		end
	end
end

function onTweenCompleted(tag) 
    if tag == 'bf' then removeLuaSprite("bfCutscene", true) end
    if tag == 'phoneExit' then removeLuaSprite("phone", true) end
    if tag == 'errung' then
        cameraFlash('other', 'FFFFFF', 1) --cam flash simulator dlc
        playAnim("errung", 'scare', true, false, 0)
        playAnim("dad", "scare", true, false, 0)
        runTimer("badRum", 1, 1)
    end
end

function onTimerCompleted(tag, loops, loopsLeft) 
    if tag == 'badRum' then 
        doTweenX('dad', 'dad', getProperty("dad.x") + 3000, 1)
        playAnim("dad", "run", false, false, 0)
        setProperty("errung.holdTimer", 0)
        runHaxeCode([[
            game.iconP2.changeIcon('errung');
            game.reloadHealthBarColors();
        ]])
    end 
end

local singAnim = {'singLEFT', 'singDOWN', 'singUP', 'singRIGHT'}

function opponentNoteHit(membersIndex, noteData, noteType, isSustainNote)
    playAnim("errung", singAnim[noteData +1], true, false, 0)
    runHaxeCode([[
        var AnimName = "]]..singAnim[noteData +1]..[[";
        var daOffset = errung.animOffsets.get(AnimName);
		if (errung.animOffsets.exists(AnimName))
		{
			errung.offset.set(daOffset[0], daOffset[1]);
		}
		else
			errung.offset.set(0, 0);
    ]])
    --runHaxeCode([[errung.playAnim(']]..singAnim[noteData +1]..[[');]])
    setProperty("errung.holdTimer", 0)
end

function onBeatHit() if curBeat % 4 == 0 then playAnim("errung", 'idle', true, false, 0) end end

function moveCam(x, y) triggerEvent('Camera Follow Pos', ''..x, ''..y) end

function changeNoteSkin(player, skin)
	if player == true then
		for i = 0, 4, 1 do
			setPropertyFromGroup('playerStrums', i, 'texture', 'noteSkins/'..skin)
		end
	end
    if not player then
		for i = 0, 4, 1 do
			setPropertyFromGroup('opponentStrums', i, 'texture', 'noteSkins/'..skin)
		end
	end

    for i = 0, getProperty('notes.length') -1 do
        if getPropertyFromGroup('notes', i, 'mustPress') == player then --only "player" side
            setPropertyFromGroup('notes', i, 'texture', 'noteSkins/'..skin)
        end
    end

    for i = 0, getProperty('unspawnNotes.length') -1 do
        if getPropertyFromGroup('unspawnNotes', i, 'mustPress') == player then --only "player" side
            setPropertyFromGroup('unspawnNotes', i, 'texture', 'noteSkins/'..skin)
        end
    end
end
