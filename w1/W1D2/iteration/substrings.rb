def substrings(input_string)
  substrings = []
  (0...input_string.length).each do |start_index|
    (start_index...input_string.length).each do |end_index|
      substrings << input_string[start_index..end_index]
    end
  end
  substrings
end

def subwords(input_string)
  substrings = substrings(input_string)
  words = []

  File.foreach("dict.txt") do |line|
    words << line.chomp
  end

  substrings.select do |sub_string|
    words.include?(sub_string)
  end
end