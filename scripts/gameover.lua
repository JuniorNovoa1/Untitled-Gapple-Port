function onUpdate()
	if boyfriendName == '3d-bf' then
		setPropertyFromClass('GameOverSubstate', 'characterName', '3d-bf-dead')
	else
		setPropertyFromClass('GameOverSubstate', 'characterName', 'bf-dead')
	end
end