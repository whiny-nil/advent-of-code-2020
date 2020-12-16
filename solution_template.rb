require 'byebug'

# Parse the damn input
file_name = File.dirname(__FILE__) + '/input.txt'
@input = File.read(file_name).strip.split("\n") if File.exist?(file_name)

test_input = <<~TESTINPUT
TESTINPUT
@test_input = test_input.strip.split("\n")

# helper methods
def assert(value, expected_value)
  puts (value == expected_value ? "." : "Failed: Expected #{expected_value.inspect}, got #{value.inspect}")
end

# stuff for this problem
def solution1(input)
  return "Not implemented!"
end

def solution2(input)
  return "Not implemented!"
end

assert(solution1(@test_input), nil)
assert(solution2(@test_input), nil)

puts "Solution 1: #{solution1(@input)}"
puts "Solution 2: #{solution2(@input)}"
