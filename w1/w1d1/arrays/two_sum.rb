class Array
  def two_sum
    result = []
    self.each_with_index do  |item, index|
      self.each_with_index do |element, inner_index|
        if index != inner_index
          if element + item == 0 && index < inner_index
            result << [index, inner_index]
          end
        end
      end
    end
    result
  end
end