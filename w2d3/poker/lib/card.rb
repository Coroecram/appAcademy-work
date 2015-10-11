class Card

  attr_reader :face, :suit, :value, :color

  def initialize(face, suit)
    @face = face
    @suit = suit
    @value = value_calc
    @color = color_calc
  end

  def value_calc
    return face if face.is_a?(Fixnum)
    case face
    when "J"; 11
    when "Q"; 12
    when "K"; 13
    when "A"; 14
    end
  end

  def color_calc
    return :black if (suit == :clubs || suit == :spades)
    return :red if (suit == :hearts || suit == :diamonds)
  end

end
