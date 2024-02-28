isEnabled = false
function onCreatePost()
   initLuaShader("BlockedGlitchShader")

   makeLuaSprite("BlockedGlitchShaderSpr")
   makeGraphic("BlockedGlitchShaderSpr", screenWidth, screenHeight)

   setSpriteShader("BlockedGlitchShaderSpr", "BlockedGlitchShader")
   setShaderFloat("BlockedGlitchShaderSpr", "time", 1)
end
eT = 0

function onUpdate(e)
   eT = e + eT
   setShaderFloat("BlockedGlitchShaderSpr", "time", eT)
end

function onEvent(n, val1)
	if n == 'GlitchEffect' then
		if not shadersEnabled then
			return;
		end
		isEnabled = not isEnabled
		if isEnabled then
			runHaxeCode([[
				game.]]..val1..[[.setFilters([new ShaderFilter(game.getLuaObject("BlockedGlitchShaderSpr").shader)]);
			]])
		else
			runHaxeCode([[
				game.]]..val1..[[.setFilters([]);
			]])
		end
	end
end