require 'MinMaxStackQueue'
def naive_window_max_range(arr, w)
  current_max_range = 0
  arr.each_index do |i|
    break if w+i > arr.length
    window = arr[i...w+i]
    current_range = window.max - window.min
    current_max_range = current_range if current_range > current_max_range
  end


  current_max_range
end

p naive_window_max_range([1, 0, 2, 5, 4, 8], 2) #== 4 # 4, 8
p naive_window_max_range([1, 0, 2, 5, 4, 8], 3) #== 5 # 0, 2, 5
p naive_window_max_range([1, 0, 2, 5, 4, 8], 4) #== 6 # 2, 5, 4, 8
p naive_window_max_range([1, 3, 2, 5, 4, 8], 5) #== 6 # 3, 2, 5, 4, 8
