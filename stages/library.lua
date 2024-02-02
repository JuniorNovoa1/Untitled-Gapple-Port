function onCreate()
	makeLuaSprite('libraryBG', 'extras/bookworm/library', 0, 0)
	scaleObject("libraryBG", 0.6, 0.6, true)
	screenCenter("libraryBG", 'xy')
	setProperty("libraryBG.x", getProperty("libraryBG.x") + 200)
	addLuaSprite('libraryBG', false)

	if not lowQuality then
		makeLuaSprite('tableFG', 'extras/bookworm/table', 0, 0)
		screenCenter("tableFG", 'xy')
		setProperty("tableFG.x", getProperty("tableFG.x") + 625)
		setProperty("tableFG.y", getProperty("tableFG.y") - 275)
		addLuaSprite('tableFG', true)
	end
end