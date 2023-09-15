function onCreate()
	makeLuaSprite('bg', 'main/algebra/diamondBg', 0, 0);
	updateHitbox("bg")
	screenCenter("bg", 'xy')
	addLuaSprite('bg', false);
end

function onUpdate(elapsed)
	local bfCamStuff = {};
	bfCamStuff[1] = getMidpointX('boyfriend') - 100 - getProperty('boyfriend.cameraPosition[0]') - getProperty('boyfriendCameraOffset[0]')
	bfCamStuff[2] = getProperty("bg.y") + (getProperty("bg.height") / 2)
	local dadCamStuff = {};
	dadCamStuff[1] = getMidpointX('dad') + 150 + getProperty('dad.cameraPosition[0]') + getProperty('opponentCameraOffset[0]')
	dadCamStuff[2] = getProperty("bg.y") + (getProperty("bg.height") / 2)

	setDataFromSave("Juniors Ports Stuff", "bf cam", bfCamStuff)
	setDataFromSave("Juniors Ports Stuff", "dad cam", dadCamStuff)
end