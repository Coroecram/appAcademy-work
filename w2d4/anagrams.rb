
def first_anagram?(string)
  return string if string.length == 2 && string == string.reverse
  result = []
  return (result + [string, string.reverse]) if string.length == 2

  string_arr = string.split("")

  (0...string.length).each do |i|
    first_letter = string_arr[i]
    string_arr_copy = string_arr.dup
    string_arr_copy.delete_at(i)
    shorter_string = string_arr_copy.join("")
    poss_ends = first_anagram(shorter_string)

    result << poss_ends.map{ |el| first_letter + el }
  end


  result.flatten
end

# p first_anagram("abc")

def second_anagram(string1, string2)
  string1.each_char do |char|
    string1.sub!(char, "") unless string2.empty?
    string2.sub!(char,"") if string2.include?(char)
  end

  string1.empty? && string2.empty?
end

# p second_anagram("elvis", "lives") => true
# p second_anagram("green", "greene") => false
# p second_anagram("happens", "happen") => false

def third_anagram(string1, string2)
  string1.split("").sort == string2.split("").sort
end

# p third_anagram("elvis", "lives")  # => true
# p third_anagram("green", "greene") # => false
# p third_anagram("happens", "happen") # => false

def fourth_anagram_i(str1, str2)
  count1 = Hash.new(0)
  count2 = Hash.new(0)
  str1.each_char do |char|
    count1[char] += 1
  end
  str2.each_char do |char|
    count2[char] += 1
  end
  count1 == count2

end

def fourth_anagram_ii(str1, str2)
  count = Hash.new(0)

  str1.each_char do |char|
    count[char] += 1
  end
  str2.each_char do |char|
    return false if count[char] == 0
    count[char] -= 1
  end
  count.values.all? { |val| val == 0 }
end





p fourth_anagram("elvis", "lives")  # => true
p fourth_anagram("green", "greeene") # => false
p fourth_anagram("happens", "happen") # => false
