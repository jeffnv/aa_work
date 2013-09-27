require 'rspec'
require 'stock'

describe "#stock_prices" do
  it "returns best days to buy and sell" do
    calendar = [50,3,2,60,5,600,2]
    stock_prices(calendar).should == [2, 5]
  end
end