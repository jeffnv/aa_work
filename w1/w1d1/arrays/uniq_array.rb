class Array
	def my_uniq
		result = []
		self.each do |item|
			result << item unless result.include? item
		end
		result
	end
end