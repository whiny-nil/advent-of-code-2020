# Parse the damn input
file_name = File.dirname(__FILE__) + '/input.txt'
@lines = File.read(file_name).strip.split("\n") if File.exist?(file_name)

test_input = <<~TESTINPUT
TESTINPUT
@test_lines = test_input.strip.split("\n")

# helper methods
def assert(value, expected_value)
  puts (value == expected_value ? "." : "Failed: Expected #{expected_value}, got #{value}")
end

def lines
  @lines
end

def test_lines
  @test_lines
end

# stuff for this problem
def solution1(lines)
  return "Not implemented!"
end

def solution2(lines)
  return "Not implemented!"
end

assert(solution1(test_lines), nil)
assert(solution2(test_lines), nil)

puts "Solution 1: #{solution1(lines)}"
puts "Solution 2: #{solution2(lines)}"
