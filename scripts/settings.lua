--settings!!
local settingsAlert = false; --disable to remove message in the top left!!!
--
local modcharts = true; --determines wether modcharts are enabled.
local epilepsy = true; --determines if screen flashes many colors at once. (disable if you have Epilepsy)
local screenshake = true; --determines wether the screen can shake.
local dialogue = true; --determine wether dialogue pops up on compatible songs.
local sensitiveContent = true; --determines if sensitive content gets enabled (ie gore)
local newCamZoom = false; --very buggy! only used on some sections of "Nice!"
--
local unfinishedStuff = false; --determines if anything unfinished gets activated, enabling this might lead to crashes, high memory usage, high cpu usage, or more bad stuff. 
--modding!!!
local debugMode = false; --wether to enable modding tools to help out me (Junior) import songs!!! (DISABLES MANY THINGS TO HURRY UP LOADING!!, DECREASES MEMORY)

local settingStringArray = {"modcharts", "epilepsy", "screenshake", "dialogue", "charSelect", "newCamZoom", "unfinishedStuff", "debugMode"}

--cross script shit

--IGNORE EVERYTHING BELOW!!!!!!
function onCreate()
    --luaDebugMode = true;
    --luaDeprecatedWarnings = true;
    initSaveData("UnNamedGapplePortSettings", "UnNamedGapplePort")
    --main
    setDataFromSave("UnNamedGapplePortSettings", 'hasBeenCreated', true) 
    setDataFromSave("UnNamedGapplePortSettings", 'settingsAlert', settingsAlert)
    setDataFromSave("UnNamedGapplePortSettings", 'modcharts', modcharts)
    setDataFromSave("UnNamedGapplePortSettings", 'epilepsy', epilepsy)
    setDataFromSave("UnNamedGapplePortSettings", 'screenshake', screenshake)
    setDataFromSave("UnNamedGapplePortSettings", 'dialogue', dialogue)
    setDataFromSave("UnNamedGapplePortSettings", 'sensitiveContent', sensitiveContent)
    setDataFromSave("UnNamedGapplePortSettings", 'newCamZoom', newCamZoom)
    --misc
    setDataFromSave("UnNamedGapplePortSettings", 'camZoom', true)
    setDataFromSave("UnNamedGapplePortSettings", 'unfinishedStuff', unfinishedStuff)
    --modding
    setDataFromSave("UnNamedGapplePortSettings", 'debugMode', debugMode)

    --cross script shit
    setDataFromSave("UnNamedGapplePortSettings", "canFloat", true)
    setDataFromSave("UnNamedGapplePortSettings", "badaiTime", false)

    if debugMode then
        setDataFromSave("UnNamedGapplePortSettings", 'dialogue', false)
        setDataFromSave("UnNamedGapplePortSettings", 'charSelect', false)
        luaDebugMode = true;
        luaDeprecatedWarnings = true;
    end
    --if stringStartsWith(version, '0.7') then flushSaveData("UnNamedGapplePortSettings") end
    --flushSaveData("UnNamedGapplePortSettings")
    --initSaveData("UnNamedGapplePortSettings")
end

function onCreatePost()
    if getDataFromSave("UnNamedGapplePortSettings", "debugMode", false) then
        makeLuaText('debugTxt', '', 0, 18, 164) --18, 32
	    setObjectCamera('debugTxt', 'other')
	    setTextAlignment('debugTxt', 'center')
	    setTextFont('debugTxt', 'comic.ttf')
	    setTextSize('debugTxt', 24)
	    updateHitbox('debugTxt')
	    addLuaText('debugTxt')

        makeLuaText('debugTxt2', '', 0, screenWidth - 200, getProperty("debugTxt.y") + 32)
	    setObjectCamera('debugTxt2', 'other')
	    setTextAlignment('debugTxt2', 'center')
	    setTextFont('debugTxt2', 'comic.ttf')
	    setTextSize('debugTxt2', 24)
	    updateHitbox('debugTxt2')
	    addLuaText('debugTxt2')

        setProperty("chartingMode", true)
    end
end

--THANK GOD THE INTERNET EXISTS
function math.clamp(x,min,max)return math.max(min,math.min(x,max))end
function math.lerp(from, to, t)
	return from + (to - from) * math.clamp(t, 0, 1)
end

local hasActivatedEvents = false;
function onUpdate()
    if inChartEditor and not hasActivatedEvents then
        hasActivatedEvents = true;
        for i = 1, curStep do
            runHaxeCode([[game.setOnLuas('curStep', ]]..i..[[);]])
            runHaxeCode([[game.callOnLuas("onStepHit", []);]])
        end
    end
    if getDataFromSave("UnNamedGapplePortSettings", "debugMode", false) then
        if getProperty("health") <= 0 then setProperty("health", 0.01) end
        if keyboardJustPressed("P") then setProperty("cpuControlled", not getProperty("cpuControlled")) end
        if keyboardJustPressed("O") then 
            setProperty("debugTxt.visible", not getProperty("debugTxt.visible"))
            setProperty("debugTxt2.visible", not getProperty("debugTxt2.visible"))
        end
    end

    setProperty('camZooming', false)
    if not getDataFromSave("UnNamedGapplePortSettings", 'camZoom', true) then
        return;
    end
    if stringStartsWith(version, '0.6') then
        local duration = crochet / 1050 * getProperty('gfSpeed');
        doTweenZoom('camZoomGame', 'camGame', getProperty('defaultCamZoom'), duration / playbackRate, 'sineOut')
        doTweenZoom('camZoomHUD', 'camHUD', 1, duration / playbackRate, 'sineOut')
    else
        setProperty('camZooming', true)
    end
end

local floorIt = false;
function onStepHit()
    if getDataFromSave("UnNamedGapplePortSettings", "debugMode", false) and getProperty("debugTxt.visible") then --using math.floor to round up character values, 80% accurate
        setProperty("debugTxt2.x", getProperty("debugTxt.x") + getProperty("debugTxt.width") + 16)
        if floorIt then
            setTextString("debugTxt", "Debug\nBotplay: "..tostring(getProperty("cpuControlled")).."\nCharacter\nDad Pos = ["..math.floor(getProperty("dad.x"), 2)..", "..math.floor(getProperty("dad.y"), 2).."]\nBf Pos = ["..math.floor(getProperty("boyfriend.x"), 2)..", "..math.floor(getProperty("boyfriend.y"), 2).."]".."\nGf Pos = ["..math.floor(getProperty("gf.x"), 2)..", "..math.floor(getProperty("gf.y"), 2).."]")
        else
            setTextString("debugTxt", "Debug\nBotplay: "..tostring(getProperty("cpuControlled")).."\nCharacter\nDad Pos = ["..getProperty("dad.x")..", "..getProperty("dad.y").."]\nBf Pos = ["..getProperty("boyfriend.x")..", "..getProperty("boyfriend.y").."]".."\nGf Pos = ["..getProperty("gf.x")..", "..getProperty("gf.y").."]")
        end
        setTextString("debugTxt2", 'Stage\nCam Zoom: '..getProperty("defaultCamZoom")..'\nStage: "'..curStage..'"\nDad: "'..dadName..'"\nBf: "'..boyfriendName..'"\nGf: "'..gfName..'"')
        setTextString("debugTxt", getTextString("debugTxt").."\nSettings\n")
        for i = 1, #settingStringArray do
            local settingBool = getDataFromSave("UnNamedGapplePortSettings", settingStringArray[i])
            local boolIntoString = "true";
            if settingBool ~= true then boolIntoString = "false"; end
            setTextString("debugTxt", getTextString("debugTxt")..settingStringArray[i]..": "..boolIntoString.."\n")
        end
        setTextString("debugTxt2", getTextString("debugTxt2").."\nLua\nScripts: "..getProperty("luaArray.length"))
        runHaxeCode([[
            var sprsLua = 0;
            var txtsLua = 0;
            var tweensLua = 0;
            var timesLua = 0;
            var soundsLua = 0;
            for (integer in game.modchartSprites.keys()) {
                sprsLua++;
			}
            for (integer in game.modchartTexts.keys()) {
                txtsLua++;
			}
            for (integer in game.modchartTweens.keys()) {
                tweensLua++;
			}
            for (integer in game.modchartTimers.keys()) {
                timesLua++;
			}
            for (integer in game.modchartSounds.keys()) {
                soundsLua++;
			}
            game.modchartTexts.get("debugTxt2").text += "\nSprites: " + sprsLua + "\nTexts: " + txtsLua + "\nTweens: " + tweensLua + "\nTimers: " + timesLua + "\nSounds: " + soundsLua;
        ]])
    end
end

function onSectionHit()
    if getDataFromSave("UnNamedGapplePortSettings", 'camZoom', true) and stringStartsWith(version, '0.6') then
        setProperty('camGame.zoom', getProperty('camGame.zoom') + 0.015 * getProperty('camZoomingMult'))
        setProperty('camHUD.zoom', getProperty('camHUD.zoom') + 0.03 * getProperty('camZoomingMult'))
    end
end