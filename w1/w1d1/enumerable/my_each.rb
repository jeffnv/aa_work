class Array
  def my_each
    self.length.times do |index|
      yield(self[index])
    end
    self
  end
end