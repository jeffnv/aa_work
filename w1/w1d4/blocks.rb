class Array
  def my_each(&prc)
    self.length.times do |index|
      prc.call(self[index])
    end
  end

  def my_map(&prc)
    [].tap do |new_array|
      self.my_each{|item| new_array << prc.call(item)}
    end
  end

  def my_map_yield
    if block_given?
      [].tap do |new_array|
        self.my_each{|item| new_array << yield(item)}
      end
    end
  end

  def my_select(&prc)
    [].tap do |new_array|
      self.my_each{|item| new_array << item if prc.call(item)}
    end
  end

  def my_inject(&prc)
    unless self.empty?
      accumulator = self[0]
      self[1..-1].my_each{|item| accumulator = prc.call(accumulator, item)}
      accumulator
    else
      nil
    end

  end

  def my_sort!(&prc)
    sorted = false
    unless self.empty?
      until sorted do
        sorted = true
        (self.length - 1).times do |index|
          if prc.call(self[index], self[index + 1]) > 0
            self[index], self[index+1] = self[index+1], self[index]
            sorted = false
          end
        end
      end
    end
  end

  def splat_block(*args, &prc)
    if prc.nil?
      puts "NO BLOCK GIVEN!"
    else
      prc.call(*args, &prc)
    end

  end

end