#Enumerables
#My Each
class Array

  def my_each
    i = 0
    return_value = []
    until i == self.length
      yield self[i]
      return_value << self[i]
      i += 1
    end
    return_value
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
    self.my_each { |x| return true if yield(x) }
    false
  end

  def my_all?
    my_each { |x| return false unless yield(x) }
    true
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
    (0...self.length).to_a.my_each do |i|
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
    my_each { |x| string.length == 0 ? string = x.to_s : string = string + space + x.to_s }
    string
  end

  def my_reverse
    copy = self.dup
    reversed = []
    until copy.empty?
      reversed << copy.pop
    end
    reversed
  end

end
