require 'set'

class Game
  attr_accessor :players, :fragment, :dictionary

  def initialize(players)
    @players = players
    @dictionary = Set.new
    File.open('ghost-dictionary.txt').each do |line|
      @dictionary << line.chomp
    end
    @fragment = ''
    @losses = Hash.new
    @players.each do |player|
      @losses[player] = 0
    end
  end

  def play_round
    until @dictionary.include?(@fragment)
      puts "#{current_player.name} enter a letter:"
      guess = take_turn(current_player)
      @fragment += guess
      p @fragment
      next_player!
    end
    @losses[previous_player] += 1
    puts "#{previous_player.name} loses the round!"
  end

  def current_player
    @players[0]
  end

  def previous_player
    @players[-1]
  end

  def next_player!
    @players.rotate!
    if @losses[current_player] == 5
      next_player!
    end
  end

  def take_turn(player)
    until valid_play?(guess = current_player.guess(self))
      current_player.alert_invalid_guess
    end
    guess
  end

  def valid_play?(string)
    string =~ /[a-z]/
    check = @fragment + string
    dictionary.any? { |word| word =~ /\A#{check}/}
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

  def guess(game)
    gets.chomp
  end

  def alert_invalid_guess
    puts "Please enter another letter"
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

a = Player.new("William")
b = Player.new("Mike")
c = AiPlayer.new("Computer")

g = Game.new([a, b, c])
g.run
