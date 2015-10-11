class Array
  def my_uniq
    self.each_with_object([]) do | el, uniq |
      uniq << el unless uniq.count(el) > 0
    end
  end

  def two_sum
    output = []
    self[0...length].each_with_index do |el, index|
      self[index+1...length].each_with_index do |el2, sec|
        second_index = sec + index + 1
        output << [index, second_index] if el + el2 == 0
      end
    end

    output
  end

  def my_transpose
    return self if count <= 1

    result = Array.new(self.first.length) { Array.new(self.length) }

    length.times do |row_indx|
      self[row_indx].length.times do |col_indx|
        result[col_indx][row_indx] = self[row_indx][col_indx]
      end
    end

    result
  end
end
