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
    puts "#{@players[0].name} won the game!"
  end

  def display_standings
    puts
    puts "Current Standings:"
    @players.each do |player|
      puts player.name + ": " + record(player)
    end
  end

end

class Player
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def take_turn(game)
    puts "#{current_player.name} enter a letter:"
    guess = player.make_guess(game)
    rescue GuessError => e
      puts e.message
      retry
    end
    guess
  end

  def make_guess(game)
    guess = gets.chomp
    raise GuessError.new  "Please enter another letter" if valid_play?(guess, game)
  end


  def valid_play?(string, game)
    return false unless string =~ /[a-z]/
    check = game.fragment + string
    game.dictionary.any? { |word| word =~ /\A#{check}/}
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
      possibilities.select! do |word|
        word.length <= game.fragment.length+game.players.length-1 && word =~ /\A#{game.fragment}/
      end
      if possibilities.nil?
        possibilities = game.dictionary.dup
        possibilities.select! do |word|
          word =~ /\A#{game.fragment}/
        end
      end
      possibilities.to_a.sample[game.fragment.length]
    end
  end
end

class GuessError < ArgumentError
end

a = Player.new("William")
b = Player.new("Mike")
c = AiPlayer.new("Computer")

g = Game.new([a, b, c])
g.run
