function onUpdate() --camera now follows characters!!!!
	if mustHitSection then
		setProperty('camFollow.x', getMidpointX('boyfriend') - 100 - getProperty('boyfriend.cameraPosition[0]') - getProperty('boyfriendCameraOffset[0]'));
		setProperty('camFollow.y', getMidpointY('boyfriend') - 100 + getProperty('boyfriend.cameraPosition[1]') + getProperty('boyfriendCameraOffset[1]'));
	else
		setProperty('camFollow.x', getMidpointX('dad') + 150 + getProperty('dad.cameraPosition[0]') + getProperty('opponentCameraOffset[0]'));
		setProperty('camFollow.y', getMidpointY('dad') - 100 + getProperty('dad.cameraPosition[1]') + getProperty('opponentCameraOffset[1]'));
	end
end