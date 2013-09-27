class Poker
end

class Hand
  HANDS = { straight_flush: 8, four_of_a_kind: 7, full_house: 6, flush: 5,
           straight: 4, three_of_a_kind: 3, two_pair: 2, pair: 1, high_card: 0 }
  def initialize(cards)
    @cards = cards
  end

  def get_hand_rank
    return HANDS[:straight_flush] if straight_flush?
    return HANDS[:four_of_a_kind] if four_of_a_kind?
    return HANDS[:full_house] if full_house?
    return HANDS[:flush] if flush?
    return HANDS[:straight] if straight?
    return HANDS[:three_of_a_kind] if three_of_a_kind?
    return HANDS[:two_pair] if two_pair?
    return HANDS[:pair] if pair?
    return HANDS[:high_card]
  end

  def compare(other_hand)



  end

  def full_house?
    pair? && three_of_a_kind?
  end

  def straight_flush?
    straight? && flush?
  end

  def flush?
    suits.all?{|suit| suits[0] == suit}
  end

  def straight?
    (values.sort.first .. values.sort.first + 4).to_a == values.sort
  end

  def three_of_a_kind?
    values.each do |value|
      return true if values.count(value) == 3
    end
    false
  end

  def four_of_a_kind?
    values.each do |value|
      return true if values.count(value) == 4
    end
    false
  end


  def two_pair?
    cards_array = []
    pair_count = 0
    @cards.each do |card|
      cards_array << card.value
      if cards_array.count(card.value) == 2
        pair_count += 1
        cards_array.delete(card.value)
      end
    end
    pair_count  == 2
  end

  def pair?
    values.each do |value|
      return true if values.count(value) == 2
    end
    false

  end

  private

  def suits
    suits = []
    @cards.each do |card|
      suits << card.suit
    end
    suits
  end

  def values
    [].tap do |values|
      @cards.each do |card|
        values << card.value
      end
    end
  end

end

class Deck
end

class Player
end

class Card
  attr_reader :suit, :value

  def initialize(properties)
    @suit = properties[:suit]
    @value = properties[:value]
  end


end

