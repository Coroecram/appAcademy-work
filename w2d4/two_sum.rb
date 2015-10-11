#bad_two_sum (brute force) time complexity = O(n * (n-1/2)) => O(n**2)
require "byebug"
def bad_two_sum?(arr, target_sum)
  arr.each_with_index do |el, idx|
    (idx+1...arr.length).each do |idx2|
      return true if (arr[idx] + arr[idx2]) == target_sum
    end
  end

  false
end

# arr = [0, 1, 5, 7]
# p bad_two_sum?(arr, 6) # => should be true
# p bad_two_sum?(arr, 10) # => should be false

#okay_two_sum time complexity = O((n-upper_bound)**2 + (n-upper_bound)/2) => O(n**2)
def okay_two_sum?(arr, target_sum)
  arr.sort!
  upper_bound = arr.length

  arr.each_with_index do |el, idx|
    upper_bound = idx if el > target_sum
  end

  sub_array = arr[0...upper_bound]
  sub_array.each_with_index do |num, idx|
    complement = target_sum - num
    if complement == num
      return true if bsearch(sub_array[0...idx], complement)
    else
      return true if bsearch(sub_array, complement)
    end
  end

  #the old riffraff way
  # (0...upper_bound).each do |idx|
  #   (idx+1...upper_bound).each do |idx2|
  #     return true if arr[idx] +  arr[idx2] == target_sum
  #   end
  # end

  false
end

def bsearch(arr, target)
  # byebug
  return false if arr.empty?
  mid = arr.length/2

  case arr[mid] <=> target
  when -1; bsearch(arr[mid+1..-1], target)
  when 0; return true
  when 1; bsearch(arr[0...mid], target)
  end
end

arr = [0, 1, 5, 7]
p okay_two_sum?(arr, 6) # => should be true
p okay_two_sum?(arr, 10) # => should be false

#hash_two_sum time complexity = O(n)
def hash_two_sum(array, target)
  values = Hash.new(false)
  array.each do |num|
    diff = target - num
    return true if values[diff]
    values[num] = true
  end

  false
end


# arr = [0, 1, 5, 7]
# p hash_two_sum(arr, 5) # => should be true
# p hash_two_sum(arr, 10) # => should be false
