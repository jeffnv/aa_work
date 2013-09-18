def set_add_el(my_hash, element)
  my_hash[element] = true
  my_hash
end

def set_remove_el(my_hash, element)
  my_hash.delete(element)
  my_hash
end

def set_list_els(my_hash)
  my_hash.keys
end

def set_member?(my_hash, element)
  my_hash.include?(element)
end

def set_union(first_hash, second_hash)
  first_hash.merge(second_hash)
end

def set_intersection(first_hash, second_hash)
  result = {}

  first_hash.each do |key, value|
    if second_hash.include?(key)
      result[key] = value
    end
  end

  result
end

def set_minus(first_hash, second_hash)
  result = {}

  first_hash.each do |key, value|
    unless second_hash.include?(key)
      result[key] = value
    end
  end

  second_hash.each do |key, value|
    unless first_hash.include?(key)
      result[key] = value
    end
  end

  result
end

