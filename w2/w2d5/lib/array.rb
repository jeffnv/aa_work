class Array
  def my_uniq
    [].tap do |uniq_array|
      self.each do |el|
        uniq_array << el unless uniq_array.include? el
      end
    end
  end

  def two_sum
    two_sums = []
    self.each_index do |start_idx|
      ((start_idx + 1)...self.length).each do |end_idx|
        two_sums << [start_idx, end_idx] if (self[start_idx] + self[end_idx]).zero?
      end
    end
    two_sums
  end
end