class Array
  def my_uniq
    [].tap do |uniq_array|
      self.each do |el|
        uniq_array << el unless uniq_array.include? el
      end
    end
  end
end