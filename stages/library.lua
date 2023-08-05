function onCreate()
	makeLuaSprite('libraryBG', 'extras/bookworm/library', 0, 0)
	scaleObject("libraryBG", 0.6, 0.6, true)
	screenCenter("libraryBG", 'xy')
	callOnLuas("addToVal", {"libraryBG.x", 200})
	addLuaSprite('libraryBG', false)

	if not lowQuality then
		makeLuaSprite('tableFG', 'extras/bookworm/table', 0, 0)
		screenCenter("tableFG", 'xy')
		callOnLuas("addToVal", {"tableFG.x", 625})
		callOnLuas("takeFromVal", {"tableFG.y", 275})
		addLuaSprite('tableFG', true)
	end
end