def concat(my_array)
  my_array.inject('') do |accum, element|
    accum << element
  end
end