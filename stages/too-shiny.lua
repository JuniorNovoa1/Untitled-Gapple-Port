function onCreate()
	makeLuaSprite('bg', 'main/algebra/diamondBg', 0, 0);
	updateHitbox("bg")
	screenCenter("bg", 'xy')
	addLuaSprite('bg', false);
end