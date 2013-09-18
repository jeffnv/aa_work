def num_to_s (number, base)
	temp = 1
	result = []
	index = 0

	while (temp < number)
		stored_num = ((number / temp) % base)
		if stored_num > 9
			stored_num = (55 + stored_num).chr
		end
		result.unshift(stored_num)
		index += 1
		temp = base ** index
	end

	result.join('')
end