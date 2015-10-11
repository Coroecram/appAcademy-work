require 'byebug'

def range(start, finish)
  return [] if finish <= start
	range(start, finish-1) << finish
end

def rec_sum_array(array)
  return array[0] if array.count == 1

  array.shift + rec_sum_array(array)
end

def iter_sum_array(array)
  sum = 0
  array.each { |number| sum += number }
	sum
 end

  sum
end

def exp1(b, n)
  return 1 if n == 0

  b * exp1(b, n - 1)

end

def exp2(b, n)
  return 1 if n == 0
  return b if n == 1

  if n.even?
    exp2(b, n / 2) * exp2(b, n / 2)
  else
    (b * (exp2(b, (n - 1) / 2))) * (b * (exp2(b, (n - 1) / 2)))
  end

end
#exp1 will take 256 steps if n == 256; exp2 will take 9 steps ""

class Array

  def deep_dup
    clone = []
    self.each do |item|
      if item.is_a?(Array)
        clone << item.deep_dup
      else
        clone << item
      end
    end

    clone
  end
end

def fibonacci(n)
  return [] if n == 0
  return [0] if n == 1
  return [0, 1] if n == 2

  next_number = n - 1

  current_number = fibonacci(next_number)[-2] + fibonacci(next_number)[-1]

  fibonacci(next_number) + [current_number]
end

def bsearch(array, target)
  if array.count == 1
    return 0 if array[0] == target
  end

  midpoint = (array.length - 1) / 2
  if array[midpoint] == target
    return midpoint
  else
    return if array[midpoint].nil?
    if array[midpoint] > target
      bsearch(array[0...midpoint], target)
    else
      subarray = array[midpoint + 1..-1]
      return if bsearch(subarray, target).nil?
      midpoint + 1 + bsearch(subarray, target)
    end
  end
end

def make_change(amount = 14, coins = [10, 7, 1])

  return [] if coins[-1] > amount
  return [amount] if coins.include?(amount)
  return make_change(amount, coins[1..-1]) if coins[0] > amount

  best = [0]

  coins.each do |current_coin|
    total = amount - best.reduce(:+)
    (total / current_coin).times do
      best << current_coin
    end
  end

  best.shift

  return best if coins.count == 1

  [best, make_change(amount, coins[1..-1])].min_by { |change| change.length }


end

def merge_sort(array)
  return array if array.length <= 1

  midpoint = (array.length) / 2
  left, right = array[0...midpoint], array[midpoint..-1]

  left, right = merge_sort(left), merge_sort(right)

  merge(left, right)
end

def merge(left, right)

  merged = []

  until left.empty? || right.empty?
    if left.first > right.first
      merged << right.shift
    else
      merged << left.shift
    end
  end

  left.empty? ? merged += right : merged += left


end
'''
def subsets(array)

  all_subsets = [[]]

  return all_subsets << array if array.length == 1

  array.each do |element|
    all_subsets += subsets(array - [element])
  end

  (all_subsets << array).uniq

end
'''

def subsets(array)

  all_subsets = [[]]

  return all_subsets if array.length == 0
  return all_subsets << array if array.length == 1

  mapped_sets = subsets(array[0...-1]).map do |el|
    el << array[-1]
  end

  subsets(array[0...-1]) + mapped_sets
end


p subsets([]) # => [[]]
p subsets([1]) # => [[], [1]]
p subsets([1, 2]) # => [[], [1], [2], [1, 2]]
p subsets( [1,2,3] )
