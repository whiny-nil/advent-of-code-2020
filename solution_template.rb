# Parse the damn input
file_name = File.dirname(__FILE__) + '/input.txt'
@lines = File.read(file_name).strip.split("\n")

# helper methods
def assert(value, expected_value)
  if value == expected_value
    puts "Passed: #{value} == #{expected_value}"
  else
    puts "Failed: #{value} != #{expected_value}"
  end
end

def lines
  @lines
end

# stuff for this problem

def solution1
  return "Not implemented!"
end

def solution2
  return "Not implemented!"
end

puts "Solution 1: #{solution1}"
puts "Solution 2: #{solution2}"
