def median(my_array)
  my_array = my_array.sort
  size = my_array.length
  avg = 0

  if size % 2 == 0
    sum = my_array[size/2] + my_array[(size/2) - 1]
    avg = sum / 2.0
  else
    avg = my_array[size/2]
  end

  avg
end