isEnabled = false
function onCreatePost()
	 initLuaShader("PulseShader")

	 makeLuaSprite("PulseShaderSpr")
	 makeGraphic("PulseShaderSpr", screenWidth, screenHeight)

	 setSpriteShader("PulseShaderSpr", "PulseShader")
    setShaderFloat("PulseShaderSpr", "uSpeed", 1)
    setShaderFloat("PulseShaderSpr", "uFrequency", 2)
    setShaderFloat("PulseShaderSpr", "uWaveAmplitude", 1)

	 addHaxeLibrary("ShaderFilter", "openfl.filters")
	 runHaxeCode([[
	 	 game.camGame.setFilters([new ShaderFilter(game.getLuaObject("PulseShaderSpr").shader)]);
	 ]])
end
function enableEyeSores(thing)
   setShaderBool("PulseShaderSpr", "uEnabled", thing)
end
function onEvent(n)
   if n == 'eyesores' then
      if not shadersEnabled or not getDataFromSave('Juniors Ports Stuff', 'epilepsy', false) then
         return;
      end
      isEnabled = not isEnabled
      enableEyeSores(isEnabled)
   end
end
function onUpdate()
    songPos = getSongPosition()
    currentBeat = (songPos/5000)*(curBpm/60)
	 setShaderFloat("PulseShaderSpr", "uTime", currentBeat)

    if getShaderBool("PulseShaderSpr", "uEnabled") then
      setShaderFloat("PulseShaderSpr", "uampmul", 0.5)
      if getDataFromSave('Juniors Ports Stuff', 'screenshake', true) then
		   runHaxeCode[[
			   FlxG.camera.shake(0.010, 0.010);
		   ]]
      end
      playAnim('gf', 'scared', false)
   else
      setShaderFloat("PulseShaderSpr", "uampmul", getShaderFloat("PulseShaderSpr", "uampmul") - 0.01)
   end
end
