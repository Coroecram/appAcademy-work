class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    sum = 0
    each_with_index { |el, i| sum = sum ^ (el.hash + i.hash) }
    sum
  end

end

class String

  def hash
    split.inject(0) { |accum, char| accum ^ (char.ord + length) }
  end

end

class Hash
  def hash
    (keys.sort + values.sort).hash

  end
end
