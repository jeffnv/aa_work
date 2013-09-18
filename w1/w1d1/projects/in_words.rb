class Fixnum

  def in_word_less_than_thousand num
    digits =[nil] + %w(one two three four five six seven eight nine)
    teens= %w(ten eleven twelve thirteen fourteen fifteen sixteen seventeen eighteen nineteen)
    tens = [nil] + (%w(ten twenty thirty forty fifty sixty seventy eighty ninety))
    result = []
    temp = 1
    index = 1

    if(num >= 100)
      result << digits[((num / 100) % 10)]
      result << 'hundred'
    end

    less_than_hundred = num % 100

    if(less_than_hundred >= 10 && less_than_hundred < 20)
      result << teens[less_than_hundred % 10]
    else
      result << tens[(less_than_hundred / 10) % 10]
      result << digits[less_than_hundred % 10]
    end

    result.compact.join(' ')
  end

  def in_words
    return 'zero' if self == 0
    mag = [nil] + (%w(thousand million billion trillion))
    result = []
    divisor = 1
    thousands_places = 0
    temp_num = self

    groups_of_three = [temp_num % 1000]

    while temp_num >= 1000 do
      temp_num /= 1000
      groups_of_three << ( temp_num % 1000)
    end

    p groups_of_three

    groups_of_three.each_with_index do |group,  index|
      if(! (group == 0))
        group_words = in_word_less_than_thousand(group)
        group_words += " #{mag[index]}" unless mag[index].nil?
        result << group_words
      end
    end

    result.reverse.compact.join(' ').strip
  end
end