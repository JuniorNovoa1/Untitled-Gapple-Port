function onEvent(name, value1, value2)
	if name == 'camFlash' and flashingLights then
		if value2 == '' then
			value2 = 'FFFFFF';
		end
		cameraFlash('other', 'FFFFFF', value1 / playbackRate)
	end
end