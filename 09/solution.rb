# Parse the damn input
file_name = File.dirname(__FILE__) + '/input.txt'
@lines = File.read(file_name).strip.split("\n").map(&:to_i) if File.exist?(file_name)

test_input = <<~TESTINPUT
  35
  20
  15
  25
  47
  40
  62
  55
  65
  95
  102
  117
  150
  182
  127
  219
  299
  277
  309
  576
TESTINPUT
@test_lines = test_input.strip.split("\n").map(&:to_i)

# helper methods
def assert(value, expected_value)
  puts (value == expected_value ? "." : "Failed: Expected #{expected_value.inspect}, got #{value.inspect}")
end

def lines
  @lines
end

def test_lines
  @test_lines
end

def init(preamble)
  @preamble = preamble
  @permutation_array = []

  (0...(preamble.length-1)).each do |i|
    @permutation_array[i] = []
    ((i+1)...(preamble.length)).each do |j|
      @permutation_array[i] << @preamble[i] + @preamble[j]
    end
  end

  @permutations = @permutation_array.flatten
end

def iterate(value)
  @preamble.shift
  @permutation_array.shift
  @permutation_array.push([])
  
  (0...(@preamble.length)).each do |i|
    @permutation_array[i] << @preamble[i] + value
  end

  @permutations = @permutation_array.flatten
  @preamble.push(value)
end

# stuff for this problem
def solution1(lines, preamble_length)
  input = lines.clone # don't change the original input
  preamble = input.shift(preamble_length) # also affects input!
  init(preamble)
  input.each do |i|
    return i unless @permutations.include?(i)

    iterate(i)
  end
end

def solution2(lines, target)
  (0...(lines.length)).each do |i|
    smallest = largest = sum = lines[i]
    ((i+1)...(lines.length)).each do |j|
      smallest = lines[j] if lines[j] < smallest
      largest = lines[j] if lines[j] > largest
      sum += lines[j]

      break if sum > target
      return smallest + largest if sum == target
    end
  end
end

assert(solution1(test_lines, 5), 127)
assert(solution2(test_lines, 127), 62)

s1 = solution1(lines, 25)
puts "Solution 1: #{s1}"
puts "Solution 2: #{solution2(lines, s1)}"
