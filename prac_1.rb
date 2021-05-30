# Define a method `rec_sum(nums)` that returns the sum of all elements in an 
# array recursively

def rec_sum(nums)
  return 0 if nums.empty?

  nums.shift + rec_sum(nums)
end

# Using recursion and the `is_a?` method, write an `Array#deep_dup` method that 
# will perform a "deep" duplication of the interior arrays.

def deep_dup(arr)
  arr.map { |ele| ele.is_a?(Array) ? deep_dup(ele) : ele }
end

class Array
  # Define a method `Array#my_zip(*arrays)` that merges elements from the 
  # receiver with the corresponding elements from each provided argument. You 
  # CANNOT use Ruby's built-in `Array#zip` method

  # example => [1,2,3].my_zip([4,5,6], [7,8,9]) 
  # should return => [[1,4,7], [2,5,8], [3,6,9]]

  def my_zip(*arrays)
    max_length = self.length
    arrays.each { |sub| max_length = sub.length if sub.length > max_length }
    zipped_arr = Array.new(self.length) { Array.new(max_length, nil) }
    self.each_with_index do |ele, idx|
      zipped_arr[idx][0] = ele
    end
    arrays.each_with_index do |sub_arr, idx|
      sub_arr.each_with_index do |ele, idx2|
        zipped_arr[idx2][idx + 1] = ele unless zipped_arr[idx2].nil?
      end
    end

    zipped_arr
  end
end

class String
  # Define a method `String#symmetric_substrings` that returns an array of 
  # substrings that are palindromes.  Only include substrings of length > 1.

  # example: "cool".symmetric_substrings => ["oo"]

  def symmetric_substrings
    all_palindromes = []
    (0...self.length).each do |idx1|
      (idx1...self.length).reverse_each do |idx2|
        str = self[idx1..idx2]
        all_palindromes << str if str == str.reverse && str.length > 1
      end
    end
    all_palindromes
  end
end

class Array
  # Write an `Array#my_each(&prc)` method that calls a proc on each element.
  # **Do NOT use the built-in `Array#each`, `Array#each_with_index`, or 
  # `Array#map` methods in your implementation.**

  def my_each(&prc)
    new_arr = []
    (0...self.length).each do |idx|
      new_arr << prc.call(self[idx])
    end
    self
  end
end

class Array
  # Write an `Array#my_reject(&prc)` method. This method should return a new 
  # array excluding all the elements in the original array that satisfy the proc.
  # **Do NOT use the built-in `Array#reject` or `Array#select` methods in your 
  # implementation.**
  
  # Example: `[1,2,3].my_reject {|n| n.even?}` => [1,3]

  def my_reject(&prc)
    new_arr = []
    self.each { |ele| new_arr << ele unless prc.call(ele) }
    new_arr
  end
end

class Array
  # Define a method `Array#quick_sort` that implements the quick sort method. 
  # The method should be able to accept a block. **Do NOT use the built-in
  # `Array#sort` or `Array#sort_by` methods in your implementation.**

  def my_quick_sort(&prc)
    return self if self.length < 2
    prc ||= Proc.new { |a, b| a <=> b }
    pivot = self.first
    first_half = self[1..-1].select { |ele| prc.call(ele, pivot) == -1 }
    second_half = self[1..-1].select { |ele| prc.call(ele, pivot) != -1 }
    first_half.my_quick_sort(&prc) + [pivot] + second_half.my_quick_sort(&prc)
  end
end