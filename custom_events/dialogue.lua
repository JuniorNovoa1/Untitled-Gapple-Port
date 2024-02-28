local dialogue = {};

function onEvent(eventName, value1, value2, strumTime)
	if eventName == "dialogue" then
		createDialogue(value1, tonumber(typeSpeed), nil, nil)
	end
end
function createDialogue(textString, typeSpeed, startTime, textSize)
	local textValue = ""..textString;
	if typeSpeed == nil then typeSpeed = 0.02; end
	if startTime == nil then startTime = #startTime * 0.25; end
	if textSize == nil then textSize = 36; end
	typeSpeed = typeSpeed / playbackRate;
	startTime = startTime / playbackRate;

	runHaxeCode([[
		var dialogueTxt = new ModchartText(400, 55, "", 0);
		game.add(dialogueTxt);
		game.modchartTexts.set("dialogueTxt", dialogueTxt)
	]])
	--makeLuaText("dialogueTxt", "", 36, 400, 55)
	setTextFont("dialogueTxt", "comic.ttf")
	setProperty("dialogueTxt.y", (screenHeight / 2) - 200)
	setTextColor('dialogueTxt', "FFFFFF")

	setTextSize("dialogueTxt", textSize)
	setTextBorder("dialogueTxt", 2, color)
	setProperty("dialogueTxt.antialiasing", true)
	runHaxeCode([[
		var txt = game.modchartTexts.get('dialogueTxt');
		game.modchartTexts.set("dialogueTxt", null);
		var textToAdd = "]]..textValue..[[";
		var maxTxt = ]]..#textValue..[[;
		var timeForEach = ]]..typeSpeed..[[;
		var showTime = ]]..startTime..[[;
		txt.alpha = 0.99999;

		for (i in 0...maxTxt) {
			new FlxTimer().start(timeForEach * i, function(tmr) {
				//if (i == 0) FlxTween.tween(txt, {alpha: 1}, 0.5);
				txt.text += textToAdd.charAt(i);
				txt.updateHitbox();
				txt.screenCenter();
				txt.y = (FlxG.height / 2) - 200;
			});
		
			new FlxTimer().start(showTime, function(tmr) {
				FlxTween.tween(txt, {alpha: 0}, 0.5, {onComplete: function(twn)
					{
						txt.destroy();
					}
				});
			});
		}
	]])
end