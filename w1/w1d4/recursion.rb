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

#Write a recursive and an iterative Fibonacci method.
#The method should take in an integer n and return the
#first n Fibonacci numbers in an array.

def fib_rec(sequence_length)
  if sequence_length == 0
    return [0]
  elsif sequence_length == 1
    return [0,1]
  end

  return fib_rec(sequence_length - 1) << fib_rec(sequence_length - 1)[-1] + fib_rec(sequence_length - 2)[-1]


end


def fib_itr(sequence_length)
  sequence = Array.new(sequence_length, 0)
  sequence.each_with_index do |num, sequence_position|
    if(sequence_position < 1)
      next
    elsif(sequence_position == 1)
      sequence[sequence_position] = 1
    else
      sequence[sequence_position] = sequence[sequence_position - 2] + sequence[sequence_position - 1]
    end
  end
end

def binary_search_rec(array, target)
  sorted_array = array.sort
  middle_index = (array.length)/2
  middle_item = array[middle_index]
  if middle_item == target
    return middle_index
  elsif array.length == 1
    return nil
  else
    if middle_item > target
      return binary_search_rec(array[0..middle_index], target)
    else
      return binary_search_rec(array[middle_index..-1], target) + middle_index
    end
  end
end

def make_change_rec(amount, coins = [25, 10, 5, 1])
  change = []
  if amount > 0
    coins.each do |coin|
      if coin <= amount
        difference = amount - coin
        change << coin
        change += make_change_rec(difference, coins)
        break
      end
    end
  end
  change
end

def make_change(amount, coins = [25, 10, 5, 1])
  ways_of_change = []
  coins.each_with_index do |coin, index|
    mod_coins = coins[index..-1]
    ways_of_change << make_change_rec(amount, mod_coins)
  end
  #sort by number of coins
  ways_of_change.sort!{|a1, a2|a1.length <=> a2.length}
  #return least amount of coins
  ways_of_change[0]
end

#You shouldn't have to pass any arrays between
#methods; you should be able to do this just passing a
#single argument for the number of Fibonacci numbers requested.