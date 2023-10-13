local bgName = 'dale_bg_new_maybe';
function onCreate()
	if not getDataFromSave("UnNamedGapplePortSettings", "sensitiveContent") then bgName = "dale_bg_safe" end
	makeLuaSprite('bg',  'extras/dale_and_dingle/'..bgName, 0, 0);
	scaleObject("bg", 1.5, 1.5, true)
	screenCenter("bg", 'xy')
	setProperty("bg.y", getProperty("bg.y") - 315)
	addLuaSprite("bg", false)
end

function onCreatePost()
	setProperty('thunderBlack.alpha', 0.35)
end