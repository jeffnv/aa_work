def my_transpose my_array
  result = []
  #temp_array = []

  my_array.each do |row|
    row.each_with_index do |element, row_index|
      if result[row_index].nil?
        result << []
      end
      result[row_index] << element
    end
  end

  result
end