require 'rspec'
require 'towers'

describe "Towers of Hanoi" do
  subject(:tower) { Towers.new }
  its(:state) { should eq [[4,3,2,1],[],[]] }

  describe "#move" do
    it "legal move" do
      tower.move(0, 1)
      tower.state.should eq([[4,3,2],[1],[]])
    end

    describe "illegal move" do
      it "should throw an error for an illegal move" do
        expect do
          tower.move(1,2)
        end.to raise_error

        expect do
          tower.move(0,1)
          tower.move(0,1)
        end.to raise_error

      end
    end

  end

  describe "#won?" do
    it "should be true when state is in winning position" do
      tower.state = [[],[],[4,3,2,1]]
      expect(tower.won?).to be_true
    end
  end
end

