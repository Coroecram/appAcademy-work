def my_min_i(array)

  (0...array.length).each do |i|
    count = 0
    (i+1...array.length).each do |j|
      count += 1 if array[i] > array[j]
    end

    return array[i] if count == 0
  end


end

def my_min_ii(array)
  min = array.first
  i = 1
  while i < array.length do
      min = array[i] if array[i] < min
      i += 1
  end

  min
end

# list = [ 0, 3, 5, 4, -5, 10, 1, 90 ]
#   puts my_min_ii(list)

def largest_subsum_i(array)
  greatest_subsum = array.first
  sub_arrays = []
  (0...array.length).each do |i|
    sub_arrays << [array[i]]
    (i+1...array.length).each do |j|
      sub_arrays << array[i..j]
    end
  end # n**2 loop returning sub_array with n! elements
  sub_arrays.each do |array|
    array_sum = 0
    sub_total = array.each do |el|
      array_sum += el
      greatest_subsum = array_sum if array_sum > greatest_subsum
    end
  end #n! arrays with at least n! elements (not sure about worst case)
  #O(n**2 * n!**2)

  greatest_subsum
end

def largest_subsum_ii(array)
  max_sum = 0
  curr_sum = 0
  array.each do |el|
    curr_sum += el
    max_sum = curr_sum if curr_sum > max_sum
    curr_sum = 0 if curr_sum < 0
  end

  max_sum
end




list = [1,2,-6,0,0]
puts largest_subsum_ii(list) # => 8
