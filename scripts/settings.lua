--settings!!
local settingsAlert = true; --disable to remove message in the top left!!!
--main settings
local modcharts = true; --determines wether modcharts are enabled.
local epilepsy = false; --determines if screen flashes many colors at once. (disable if you have Epilepsy)
local screenshake = true; --determines wether the screen can shake.
local dialogue = true; --determine wether dialogue pops up on compatible songs.
--dave and bambi settings
local newCamZoom = false; --very buggy! only used on some sections of Nice!

--IGNORE EVERYTHING BELOW!!!!!!
function onCreate()
    initSaveData("Juniors Ports Stuff")
    setDataFromSave("Juniors Ports Stuff", 'modcharts', modcharts)
    setDataFromSave("Juniors Ports Stuff", 'epilepsy', epilepsy)
    setDataFromSave("Juniors Ports Stuff", 'screenshake', screenshake)
    setDataFromSave("Juniors Ports Stuff", 'dialogue', dialogue)
    setDataFromSave("Juniors Ports Stuff", 'newCamZoom', newCamZoom)
    setDataFromSave("Juniors Ports Stuff", 'camZoom', true)
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