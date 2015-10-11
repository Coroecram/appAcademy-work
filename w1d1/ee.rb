#Enumerables
#My Each
class Array

  def my_each
    for i in (0..self.length-1)
      yield self[i]
    end
  end

  def my_select
    selected = []
    my_each { |x| selected << x if yield(x) }
    selected
  end

  def my_reject
    rejected = []
    my_each { |x| rejected << x unless yield(x) }
    rejected
  end

  def my_any?
    my_each do |x|
      return true if yield(x)
    end
    return false
  end

  def my_all?
    my_each do |x|
      return false unless yield(x)
    end
    return true
  end

  def my_flatten(flattened = [])
    my_each do |x|
      if x.class == Array
        x.my_flatten(flattened)
      else
        flattened << x
      end
    end
    flattened
  end

  def my_zip(*inputs)
    result = Array.new(self.length) { Array.new }
    (0..self.length-1).to_a.my_each do |i|
      result[i] << self[i]
      inputs.my_each do |array|
        result[i] << array[i]
      end
    end
    result
  end

  def my_rotate(n=1)
      (n%self.length).times do
        x=self.shift
        self << x
      end
    self
  end

  def my_join(space = "")
    string = ""
    my_each do |x|
      string.length == 0 ? string = x.to_s : string = string + space + x.to_s
    end
    string
  end

  def my_reverse
    copy = self.dup
    reversed = []
    while copy.length > 0
      reversed << copy.pop
    end
    reversed
  end

end
