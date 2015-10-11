class Hand
  attr_accessor :cards

  def initialize(cards = [])
    @cards = cards
  end

  def push(card)
    @cards << card unless @cards.size == 5
    @cards
  end

  def hand_values
    values = cards.each_with_object([]) { |card, vals| vals << card.value }
  end

  def hand_suits
    suits = cards.each_with_object([]) { |card, suitz| suitz << card.suit }
  end

  def check_hand
    values = hand_values #values is an arry of fixnums
    high_card_hand = high_card(values)
    pair_hand = pair(values)
    # three_of_a_kind_hand = three_of_a_kind(values)
    #
    # flush_hand = flush(hand_suits)

    pair_hand || high_card_hand

  end

  def high_card(values)
    @cards.find {|card| card.value == values.max}
  end

  def pair(values)
    possible_pair_value = values.uniq.select {|val| values.count(val) == 2 }.shift
    @cards.select { |card| card.value == possible_pair_value } unless possible_pair_value.nil?
  end

  def three_of_a_kind
    values = hand_values
  end

  def best
  end


end
