--settings!!
local settingsAlert = true; --disable to remove message in the top left!!! (GOTTA FIND A WAY TO LET PEOPLE KNOW TO CHANGE THEIR SETTINGS!!!!)
--main settings (all mods)
local modcharts = true; --determines wether modcharts are enabled.
local epilepsy = true; --determines if screen flashes many colors at once. (disable if you have epilepsy)
local screenshake = true; --determines wether the screen can shake.
local dialogue = true; --determine wether dialogue pops up on compatible songs.
--dave and bambi settings
local newCamZoom = false;

local saveFileName = 'settings';

function onCreate()
    initSaveData(saveFileName)
    setDataFromSave(saveFileName, 'settingsAlert', settingsAlert)
    setDataFromSave(saveFileName, 'modcharts', modcharts)
    setDataFromSave(saveFileName, 'epilepsy', epilepsy)
    setDataFromSave(saveFileName, 'screenshake', screenshake)
    setDataFromSave(saveFileName, 'dialogue', dialogue)
    setDataFromSave(saveFileName, 'newCamZoom', newCamZoom)
    setDataFromSave(saveFileName, 'camZoom', true)
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
    local duration = crochet / 1050 * getProperty('gfSpeed');
    doTweenZoom('camZoomGame', 'camGame', getProperty('defaultCamZoom'), duration, 'sineOut')
    doTweenZoom('camZoomHUD', 'camHUD', 1, duration, 'sineOut')
end

function onSectionHit()
    if getDataFromSave('camZoom') then
        setProperty('camGame.zoom', getProperty('camGame.zoom') + 0.015 * getProperty('camZoomingMult'))
        setProperty('camHUD.zoom', getProperty('camHUD.zoom') + 0.03 * getProperty('camZoomingMult'))
    end
end