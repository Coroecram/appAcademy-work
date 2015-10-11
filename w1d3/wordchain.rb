require 'byebug'
require 'set'

class WordChainer

  attr_reader :dictionary
  attr_accessor :current_words, :all_seen_words

  def initialize(dictionary_file = "dictionary.txt")
    @dictionary = Set.new(
      File.readlines(
        File.expand_path("../#{dictionary_file}", __FILE__ )
      ).map(&:chomp)
    )
    @current_words = []
    @all_seen_words = {}
  end

  def adjacent_words(word)
    sub_dictionary = dictionary.select { |entry| word.length == entry.length }

    adjacent_words = []

    word_array = word.split("")
    word_array.each_index do |idx|
      word_store = word_array.dup
      word_store[idx] = '\w'
      word_str = word_store.join

      adjacent_words << sub_dictionary.find_all do |entry|
        entry =~ /\A#{word_str}\z/
      end
    end

    adjacent_words.flatten
  end

  def run(source, target)
    current_words << source
    all_seen_words[source] = nil

    until current_words.empty?
      self.current_words = explore_current_words(current_words)
    end
  end

  def explore_current_words(current_words)
    new_current_words = []
    current_words.each do |current_word|
      adjacent_words(current_word).each do |word|
        new_current_words << word unless all_seen_words.include?(word)
        all_seen_words[word] = current_word unless all_seen_words.key?(word)
      end
    end
    new_current_words.each { |word| puts "#{word} : #{all_seen_words[word]}" }
  end

end

wordchainer = WordChainer.new
p wordchainer.run("cat", "boa")
