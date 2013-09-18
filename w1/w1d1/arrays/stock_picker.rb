def stock_picker days
  max = 0
  result = [0, 0]
  days.each_with_index do|day, index|
    days[(index + 1)..-1].each_with_index do |inner_day, inner_index|
      if  (inner_day - day) > max
        max = inner_day - day
        result[0] = index
        result[1] = inner_index + index + 1
      end

    end
  end
  result
end