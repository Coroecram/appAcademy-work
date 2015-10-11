require 'card'

class Deck
  attr_reader :cards

  CARD_FACES = (2..10).to_a + ["J", "Q", "K", "A"]
  SUITS = [:hearts, :diamonds, :clubs, :spades]

  def initialize
    @cards = []
    populate_deck
  end

  def shuffle_cards
    cards.shuffle!
  end

  private

  def populate_deck
    CARD_FACES.each do |face|
      SUITS.each do |suit|
        @cards << Card.new(face, suit)
      end
    end
    nil
  end

end
