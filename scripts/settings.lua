--settings!!
local settingsAlert = true; --disable to remove message in the top left!!!
--main settings
local modcharts = true; --determines wether modcharts are enabled.
local epilepsy = false; --determines if screen flashes many colors at once. (disable if you have Epilepsy)
local screenshake = true; --determines wether the screen can shake.
local dialogue = true; --determine wether dialogue pops up on compatible songs.
--dave and bambi settings
local newCamZoom = false; --very buggy! only used on some sections of "Nice!"
--misc
local unfinishedStuff = false; --determines if anything unfinished gets activated, enabling this might lead to crashes, high memory usage, high cpu usage, or more bad stuff. 
--modding!!!
local debugMode = false; --wether to enable modding tools to help out me (Junior) import songs!!! (DISABLES MANY THINGS TO HURRY UP LOADING!!)

--cross script shit
local gappleSongs = {'maze', 'disruption', 'applecore', 'disability', 'wireframe', 'algebra', 'fresh-and-toasted', 'nice', 'ferocious', 'glamrock', 'sugar-rush', 'gift-card', 'ready-loud', 'cuberoot', 'sart-producer', 'og', 'mine', 
'apple-leak', 'awesome', 'badcorn', 'crap!', 'ticking', 'kooky'}
local CharactersWith3D = {'bambi-unfair', 'bambi-piss-3d', 'bandu', 'bandu-sad', 'tunnel-dave', 'badai', 'unfair-junker', 'split-dave-3d', 'garrett', '3d-bf', '3d-bf-flipped', '3d-bf-shoulder', 'garrett-animal', 'playtime', 'palooseMen', 'garrett-ipad', 'wizard', 'piano-guy', 'pedophile', 'garrett-angry', 'garrett-car',
'bandu-candy', 'dinnerbambi', 'insanidave', 'bamb-root', 'sart-producer', 'sart-producer-glitch', 'ticking', 'fat-bandu-3d', 'gary', '3d-bambi-leak', 'bandu-trolled', 'sammy', 
'duelExpunged', '3d-bambi-leak-finale', 'og-dave', 'og-dave-angey', 'spike', 'spike-bg', 'playrobot', 'playrobot-crazy', 'hall-monitor', 'diamond-man', 'dave-wide', 'awesomeBambiCrack',
'brob', 'barbu', 'gfreddy', 'cameo', 'facecam', 'bandu-card'}

--IGNORE EVERYTHING BELOW!!!!!!
function onCreate()
    initSaveData("Juniors Ports Stuff")
    --main
    setDataFromSave("Juniors Ports Stuff", 'modcharts', modcharts)
    setDataFromSave("Juniors Ports Stuff", 'epilepsy', epilepsy)
    setDataFromSave("Juniors Ports Stuff", 'screenshake', screenshake)
    setDataFromSave("Juniors Ports Stuff", 'dialogue', dialogue)
    --dave and bambi settings
    setDataFromSave("Juniors Ports Stuff", 'newCamZoom', newCamZoom)
    --misc
    setDataFromSave("Juniors Ports Stuff", 'camZoom', true)
    setDataFromSave("Juniors Ports Stuff", 'unfinishedStuff', unfinishedStuff)
    --modding
    setDataFromSave("Juniors Ports Stuff", 'debugMode', debugMode)

    --cross script shit
    setDataFromSave("Juniors Ports Stuff", "gappleSongs", gappleSongs)
    setDataFromSave("Juniors Ports Stuff", "CharactersWith3D", CharactersWith3D)
end

function onCreatePost()
    if getDataFromSave("Juniors Ports Stuff", "debugMode") then
        makeLuaText('debugTxtLEFT', '', 0, 18, 6) --18, 6 (18, 36)
	    setObjectCamera('debugTxtLEFT', 'other')
	    setTextAlignment('debugTxtLEFT', 'left')
	    setTextFont('debugTxtLEFT', 'comic.ttf')
	    setTextSize('debugTxtLEFT', 26)
	    updateHitbox('debugTxtLEFT')
	    addLuaText('debugTxtLEFT')

        --[[makeLuaText('debugTxtRIGHT', '', 0, screenWidth - 200, 6)
	    setObjectCamera('debugTxtRIGHT', 'other')
	    setTextAlignment('debugTxtRIGHT', 'center')
	    setTextFont('debugTxtRIGHT', 'comic.ttf')
	    setTextSize('debugTxtRIGHT', 26)
	    updateHitbox('debugTxtRIGHT')
	    addLuaText('debugTxtRIGHT')--]]

        setProperty("chartingMode", true)
    end
end

function onUpdatePost(elapsed)
    if getDataFromSave("Juniors Ports Stuff", "debugMode") then
        setTextString("debugTxtLEFT", "Character\nDad Pos = ["..getProperty("dad.x")..", "..getProperty("dad.y").."]\nBf Pos = ["..getProperty("boyfriend.x")..", "..getProperty("boyfriend.y").."]".."\nGf Pos = ["..getProperty("gf.x")..", "..getProperty("gf.y").."]")
        setTextString("debugTxtLEFT", getTextString("debugTxtLEFT")..'\n\nStage\nCam Zoom: '..getProperty("defaultCamZoom")..'\nStage: "'..curStage..'"\nDad: "'..dadName..'"\nBf: "'..boyfriendName..'"\nGf: "'..gfName..'"')
        setTextString("debugTxtLEFT", getTextString("debugTxtLEFT").."\n\nLua\nScripts: "..getProperty("luaArray.length"))
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
            game.modchartTexts.get("debugTxtLEFT").text += "\nSprites: " + sprsLua + "\nTexts: " + txtsLua + "\nTweens: " + tweensLua + "\nTimers: " + timesLua + "\nSounds: " + soundsLua;
        ]])
    end
end

--THANK GOD THE INTERNET EXISTS
function math.clamp(x,min,max)return math.max(min,math.min(x,max))end
function math.lerp(from, to, t)
	return from + (to - from) * math.clamp(t, 0, 1)
end

function onUpdate()
    setProperty('camZooming', false)
    if getDataFromSave('camZoom') == false then
        return;
    end
    --[[local maxxed = 0.95;
    setProperty('camGame.zoom', math.lerp(getProperty('defaultCamZoom'), getProperty('camGame.zoom'), maxxed))
    setProperty('camHUD.zoom', math.lerp(1, getProperty('camHUD.zoom'), maxxed))--]]
    if stringStartsWith(version, '0.6') then
        local duration = crochet / 1050 * getProperty('gfSpeed');
        doTweenZoom('camZoomGame', 'camGame', getProperty('defaultCamZoom'), duration, 'sineOut')
        doTweenZoom('camZoomHUD', 'camHUD', 1, duration, 'sineOut')
    else
        setProperty('camZooming', true)
    end
end

function onSectionHit()
    if getDataFromSave('camZoom') and stringStartsWith(version, '0.6') then
        setProperty('camGame.zoom', getProperty('camGame.zoom') + 0.015 * getProperty('camZoomingMult'))
        setProperty('camHUD.zoom', getProperty('camHUD.zoom') + 0.03 * getProperty('camZoomingMult'))
    end
end