#Write a recursive method, range,
#that takes a start and an end and returns an array of all numbers between.
def range(start_num, end_num)
  range_array = []
  range_array <<  start_num

  if(start_num < end_num)
    range_array += range(start_num + 1, end_num)
  end

  range_array
end

#Write both a recursive and iterative version of sum of an array.
def sum_array_rec(array_to_sum)
  if(array_to_sum.length > 0)
    sum = array_to_sum[0]
    sum += sum_array_rec(array_to_sum[1..-1])
  else
    0
  end
end

def sum_array_iterative(array_to_sum)
  array_to_sum.inject(:+)
end

#Write two versions of exponent that use two different recursions:
def recursive_exponent_1(base, exponent)
  puts "#{__method__} called"
  return 1 if exponent.zero?
  base * recursive_exponent_1(base, exponent - 1)
end

def recursive_exponent_2(base, exponent)
  puts "#{__method__} called"
  return 1 if exponent.zero?

  if exponent.even?
    recursive_exponent_2(base, (exponent/2)) **2
  else
    base * ((recursive_exponent_2(base, (exponent -1) / 2)) ** 2)
  end

end

#The #dup method doesn't make a deep copy:
def deep_dup(array_to_dup)
  [].tap do |duplicated_array|

    array_to_dup.each do |item|

      puts "item is #{item}"

      if item.is_a?(Array)
        duplicated_array << deep_dup(item)
      else
        duplicated_array << item
      end
    end
  end
end