--funcs are: createDeformartionSprites(charName), deformationPreJumpscare(charName), deformationJumpscare
function onCreatePost()
	setProperty("iconP2.alpha", 0)
	setProperty("dad.alpha", 0)
	setProperty("thunderBlack.alpha", 0.45)
	callOnLuas("deformationPreJumpscare", {"alg"})
end

function onStepHit()
	if curStep == 496 then
		callOnLuas("deformationJumpscare")
	end

	if curStep == 1536 then
		callOnLuas("deformationPreJumpscare", {"butch"})
	end

	if curStep == 2044 then
		callOnLuas("createDeformartionSprites", {"butch", 15})
		callOnLuas("deformationJumpscare")
	end

	if curStep == 3328 then
		callOnLuas("deformationPreJumpscare", {"bad"})
	end

	if curStep == 3840 then
		callOnLuas("createDeformartionSprites", {"bad"}, 40)
		callOnLuas("deformationJumpscare")
	end

	if curStep == 4864 then
		callOnLuas("deformationPreJumpscare", {"bad"}) --only used to fade out dad
	end
end