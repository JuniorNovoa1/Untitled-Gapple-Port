function onUpdate()
	if boyfriendName == '3d-bf' then
		setPropertyFromClass('GameOverSubstate', 'characterName', '3d-bf-dead')
	else
		setPropertyFromClass('GameOverSubstate', 'characterName', 'bf-dead')
	end

	if string.lower(dadName) == 'brob' then
		setPropertyFromClass('GameOverSubstate', 'loopSoundName', 'FreshAndToasted/win-brobgonal')
	elseif string.lower(dadName) == 'barbu' or (luaSpriteExists("barbu") and getProperty("barbu.y") ~= -500) then
		setPropertyFromClass('GameOverSubstate', 'loopSoundName', 'FreshAndToasted/win-barbu')
	else
		setPropertyFromClass('GameOverSubstate', 'loopSoundName', 'gameOver')
	end

	if string.lower(dadName) == 'sart-producer' or string.lower(dadName) == 'sart-producer-glitch' then
		setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'fnf_loss_sfx-sart')
	else
		setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'fnf_loss_sfx')
	end
end

function onGameOver()
	setProperty("defaultCamZoom", 1)
end