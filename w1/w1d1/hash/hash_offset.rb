def correct_hash(hash)
  temp_val = nil
  temp_key = nil
  result = {}
  hash.each do |key, val|
    puts "#{key} - #{val}"
    if(temp_val.nil?)
      temp_val = val
    else
      result[key] = temp_val
      temp_val = val
    end
  end
  result[temp_val[0].to_sym] = temp_val

  result
end