require 'rspec'
require 'array'

describe "Array" do
  describe "#uniq" do
    #Array has a uniq method that removes duplicates from an array. It returns the unique elements in the order in which they first appeared
    it "returns the unique elements from the array" do
      [1, 2, 1, 3, 3].my_uniq.should == [1,2,3]
    end
  end

  describe "#two_sum" do
    it "finds all pairs of positions where elements sum to zero" do
      [-1, 0, 2, -2, 1].two_sum.should == [[0, 4], [2, 3]]
    end
  end
end



