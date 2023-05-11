--settings!!
local settingsAlert = true; --disable to remove message in the top left!!! (GOTTA FIND A WAY TO LET PEOPLE KNOW TO CHANGE THEIR SETTINGS!!!!)
--main settings (all mods)
local modcharts = true; --determines wether modcharts are enabled.
local epilepsy = true; --determines if screen flashes many colors at once. (disable if you have epilepsy)
local screenshake = true; --determines wether the screen can shake.
local dialogue = true; --determine wether dialogue pops up on compatible songs.

local saveFileName = 'settings';

function onCreate()
    initSaveData(saveFileName)
    setDataFromSave(saveFileName, 'settingsAlert', settingsAlert)
    setDataFromSave(saveFileName, 'modcharts', modcharts)
    setDataFromSave(saveFileName, 'epilepsy', epilepsy)
    setDataFromSave(saveFileName, 'screenshake', screenshake)
    setDataFromSave(saveFileName, 'dialogue', dialogue)
end