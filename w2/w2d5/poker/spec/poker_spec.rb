require 'rspec'
require 'poker'

describe Poker do

  describe "#initialize" do
  end

end

describe Hand do
  subject (:hand) {Hand.new}

  describe "#compare hands" do
    let(:straight) do
      cards                           = []
      cards << double("card1", :value => 4, :suit => :h )
      cards << double("card2", :value => 5, :suit => :d )
      cards << double("card3", :value => 6, :suit => :h )
      cards << double("card4", :value => 7, :suit => :h )
      cards << double("card5", :value => 8, :suit => :h )
      Hand.new(cards)
    end

    let(:straight_flush) do
      cards                           = []
      cards << double("card1", :value => 4, :suit => :h )
      cards << double("card2", :value => 5, :suit => :h )
      cards << double("card3", :value => 6, :suit => :h )
      cards << double("card4", :value => 7, :suit => :h )
      cards << double("card5", :value => 8, :suit => :h )
      Hand.new(cards)
    end

    it "should correctly indicate the better hand" do
      expect(straight_flush.compare(straight)).to eq(1)
    end
  end

  describe "#straight_flush?" do
    let(:test_hand) do
      cards                           = []
      cards << double("card1", :value => 4, :suit => :h )
      cards << double("card2", :value => 5, :suit => :h )
      cards << double("card3", :value => 6, :suit => :h )
      cards << double("card4", :value => 7, :suit => :h )
      cards << double("card5", :value => 8, :suit => :h )
      Hand.new(cards)
    end

    it "should be true if has four of a kind" do
      expect(test_hand.straight_flush?).to be_true
    end
  end

  describe "#four_of_a_kind?" do
    let(:test_hand) do
      cards                           = []
      cards << double("card1", :value => 10, :suit => :d )
      cards << double("card2", :value => 10, :suit => :c )
      cards << double("card3", :value => 10, :suit => :h )
      cards << double("card4", :value => 10, :suit => :c )
      cards << double("card5", :value => 3, :suit => :h )
      Hand.new(cards)
    end

    it "should be true if has four of a kind" do
      expect(test_hand.four_of_a_kind?).to be_true
    end
  end

  describe "#full_house?" do
    let(:test_hand) do
      cards                           = []
      cards << double("card1", :value => 10, :suit => :d )
      cards << double("card2", :value => 10, :suit => :d )
      cards << double("card3", :value => 10, :suit => :d )
      cards << double("card4", :value => 7, :suit => :d )
      cards << double("card5", :value => 7, :suit => :d )
      Hand.new(cards)
    end

    it "should be true if has a full house" do
      expect(test_hand.full_house?).to be_true
    end
  end

  describe "#flush?" do
    let(:test_hand) do
      cards                           = []
      cards << double("card1", :value => 10, :suit => :d )
      cards << double("card2", :value => 10, :suit => :d )
      cards << double("card3", :value => 10, :suit => :d )
      cards << double("card4", :value => 7, :suit => :d )
      cards << double("card5", :value => 3, :suit => :d )
      Hand.new(cards)
    end

    it "should be true if has a flush" do
      expect(test_hand.flush?).to be_true
    end
  end

  describe "#straight" do
    let(:test_hand) do
      cards                           = []
      cards << double("card1", :value => 4, :suit => :d )
      cards << double("card2", :value => 5, :suit => :c )
      cards << double("card3", :value => 6, :suit => :h )
      cards << double("card4", :value => 7, :suit => :c )
      cards << double("card5", :value => 8, :suit => :h )
      Hand.new(cards)
    end

    it "should be true if has a straight" do
      expect(test_hand.straight?).to be_true
    end
  end

  describe "#three_of_a_kind?" do
    let(:test_hand) do
      cards                           = []
      cards << double("card1", :value => 10, :suit => :d )
      cards << double("card2", :value => 10, :suit => :c )
      cards << double("card3", :value => 10, :suit => :h )
      cards << double("card4", :value => 7, :suit => :c )
      cards << double("card5", :value => 3, :suit => :h )
      Hand.new(cards)
    end

    it "should be true if has three of a kind" do
      expect(test_hand.three_of_a_kind?).to be_true
    end
  end

  describe "#two_pair?" do
    let(:test_hand) do
      cards                           = []
      cards << double("card1", :value => 10, :suit => :d )
      cards << double("card2", :value => 10, :suit => :c )
      cards << double("card3", :value => 6, :suit => :h )
      cards << double("card4", :value => 6, :suit => :c )
      cards << double("card5", :value => 3, :suit => :h )
      Hand.new(cards)
    end

    it "should be true if has two pairs" do
      expect(test_hand.two_pair?).to be_true
    end
  end

  describe "#pair?" do
    let(:test_hand) do
      cards                           = []
      cards << double("card1", :value => 10, :suit => :d )
      cards << double("card2", :value => 10, :suit => :c )
      cards << double("card3", :value => 6, :suit => :h )
      cards << double("card4", :value => 7, :suit => :c )
      cards << double("card5", :value => 3, :suit => :h )
      Hand.new(cards)
    end

    it "should be true if has pair" do
      expect(test_hand.pair?).to be_true
    end
  end

  describe "#discard" do
    let(:test_hand) do
      cards = []
      cards << double("card1", :value => 10, :suit => :d )
      cards << double("card2", :value => 10, :suit => :c )
      cards << double("card3", :value => 6, :suit => :h )
      cards << double("card4", :value => 7, :suit => :c )
      cards << double("card5", :value => 3, :suit => :h )
      Hand.new(cards)
    end

    let(:card1) { double("card1", :value => 10, :suit => :d ) }
    let(:card2) { double("card2", :value => 10, :suit => :c ) }
    let(:card3) { double("card3", :value => 6, :suit => :h ) }
    let(:card4) { double("card4", :value => 7, :suit => :c ) }
    let(:card5) { double("card5", :value => 3, :suit => :h ) }

    it "should remove cards from hand" do
     expect(test_hand.discard([card1, card2, card3])).to match_array([card4, card5])
    end


  end

  describe "#show" do
  end
end

describe Card do
  subject(:card) { Card.new({:value   => 8, :suit => :h}) }

  describe "#suit" do
    it "should have suit" do
      expect(card.suit).to eq(:h)
    end
  end

  describe "#value" do
    it "should have value" do
      expect(card.value).to eq(8)
    end
  end


end

describe Player do
  subject(:player){Player.new()}



  describe "#fold" do
  end

  describe "#bet" do
  end

  describe "#raise" do
  end


end

describe Deck do
  subject(:deck){Deck.new}

  describe "#draw" do
    it "draw return correct number of cards" do
      expect(deck.draw(3).count).to eq(3)
    end

    it "removes drawn cards from deck" do
      deck.draw(3)
      expect(deck.count).to eq(49)
    end
  end

  describe "#reset" do
    it "returns number of cards in deck to 52" do
      deck.draw(3)
      deck.reset
      expect(deck.count).to eq(52)
    end
  end
end

