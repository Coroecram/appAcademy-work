require_relative 'p05_hash_map'
require_relative 'p04_linked_list'
require 'byebug'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if @map.include?(key)
      update_link!(@map[key])
    else
      @map[key] = calc!(key)
      eject! if count > @max
    end

    @map[key].val
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    @store.insert(key, @prc.call(key))
    @store.tail
  end

  def update_link!(link)
    # suggested helper method; move a link to the end of the list
    next_link = link.next
    prev_link = link.prev
    prev_link.next = next_link unless prev_link.nil?
    next_link.prev = prev_link unless next_link.nil?
    @store.insert(link.key, link.val)
  end

  def eject!
    key = @store.head.key
    @map.delete(key)
    @store.remove(key)
  end
end
