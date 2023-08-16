function onEvent(name, value1, value2)
	if name == 'Call Lua Function' then
		local arrayString = value2;
		local arrayTable = {}

		-- Remove the brackets from the string
		local cleanedString = arrayString:sub(2, -2)

		-- Split the cleaned string into individual elements
		local elements = {}
		for element in cleanedString:gmatch("[^,]+") do
    		table.insert(elements, element)
		end

		-- Convert the elements to numbers and store in the arrayTable
		for _, element in ipairs(elements) do
 		   table.insert(arrayTable, tonumber(element))
		end

		-- Now arrayTable contains the extracted array
		for i, v in ipairs(arrayTable) do
    		print(i, v)
		end
		callOnLuas(value1, arrayTable)
	end
end