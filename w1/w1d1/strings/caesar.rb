def caesar (str, shift)
  result = ""
  str.each_char do |chr|
    if(chr.ord + shift < (122))
      result << chr.ord + shift
    else
      result << chr.ord + shift - 26
    end
  end
  result
end