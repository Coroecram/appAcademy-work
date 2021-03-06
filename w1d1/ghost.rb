require 'set'

class Game
  attr_accessor :players, :fragment, :dictionary

  def initialize(players)
    @players = players
    @dictionary = Set.new
    File.open('ghost-dictionary.txt').each { |line| @dictionary << line.chomp }
    @fragment = ''
    @losses = Hash.new
    @players.each { |player| @losses[player] = 0 }
  end

  def play_round
    until @dictionary.include?(@fragment) && !@dictionary.any?{ |word| word =~ /^#{@fragment}\w+\z/ }
      guess = current_player.take_turn(self)
      @fragment += guess
      p @fragment
      next_player!
    end
    round_loss
  end

  def current_player
    @players[0]
  end

  def previous_player
    @players[-1]
  end

  def next_player!
    @players.rotate!
    next_player! if @losses[current_player] == 5
  end

  def round_loss
    @losses[previous_player] += 1
    puts "#{previous_player.name} loses the round!"
  end

  def record(player)
    "GHOST".slice(0, @losses[player])
  end

  def run
    until @losses.one? { |name, losses| losses < 5 }
      @fragment = ""
      play_round
      display_standings
    end
    puts "\\n#{@players[0].name} won the game!"
  end

  def display_standings
    puts "\\nCurrent Standings:"
    @players.each { |player| puts player.name + ": " + record(player) }
  end

end

class Player
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def take_turn(game)
    puts "#{game.current_player.name} enter a letter:"
    guess = make_guess(game)
    rescue GuessError => e
      puts e.message
      retry
    guess
  end

  def make_guess(game)
    guess = gets.chomp
    raise GuessError.new  "Please enter another letter" unless valid_play?(guess, game)
  end


  def valid_play?(string, game)
    return false unless string =~ /[a-z]/
    check = game.fragment + string
    game.dictionary.any? { |word| word =~ /\A#{check}/ }
  end

end

class AiPlayer
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def guess(game)
    if game.fragment == ""
      ('a'..'z').to_a.sample
    else
      possibilities = game.dictionary.dup
      possibilities.select! { |word| word.length <= game.fragment.length+game.players.length-1 && word =~ /\A#{game.fragment}/ }
      if possibilities.nil?
        possibilities = game.dictionary.dup
        possibilities.select! { |word| word =~ /\A#{game.fragment}/ }
      end
      possibilities.to_a.sample[game.fragment.length]
    end
  end

end

class GuessError < ArgumentError
end

if $PROGRAM_NAME == __FILE__
  a, b, c = Player.new("William"), Player.new("Mike"), AiPlayer.new("Computer")
  g = Game.new([a, b, c])
  g.run
end
