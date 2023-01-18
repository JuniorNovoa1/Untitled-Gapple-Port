--DON'T STEAL KIDS!
--BY JUNIORNOVOA

local songNames = {'Wireframe', 'Ferocious', 'Apple-Leak', 'OG'};
local arrowXoffset = 35;
local arrowYoffset = 0;

function onCreatePost()
	for i = 1, #songNames do
		--print(songName..songNames[i]);
		if songName == songNames[i] then
			for direction = 0, 3 do
				setPropertyFromGroup('playerStrums', direction, 'x', getPropertyFromGroup('playerStrums', direction, 'x') - arrowXoffset)
				setPropertyFromGroup('opponentStrums', direction, 'x', getPropertyFromGroup('opponentStrums', direction, 'x') - arrowXoffset / 1.5)
			end
		end
	end
end