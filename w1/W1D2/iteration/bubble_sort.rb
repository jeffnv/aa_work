def bubble_sort(array_to_sort)
  swap_required = true
  sorted_array = array_to_sort.dup
  while swap_required do
    swap_required = false

    sorted_array.each_with_index do |item, index|
      at_end  = index == sorted_array.count  - 1

      next_item = sorted_array[index + 1]

      if(!at_end and item > next_item)
        sorted_array[index], sorted_array[index + 1] = next_item, item
        swap_required = true
      end

    end
  end

  sorted_array
end