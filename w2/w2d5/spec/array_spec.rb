require 'rspec'
require 'array'

describe "#uniq" do
  #Array has a uniq method that removes duplicates from an array. It returns the unique elements in the order in which they first appeared
  it "returns the unique elements from the array" do
    [1, 2, 1, 3, 3].my_uniq.should == [1,2,3]
  end
end