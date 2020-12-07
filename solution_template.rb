# Parse the damn input
file_name = File.dirname(__FILE__) + '/input.txt'
@lines = File.read(file_name).strip.split("\n")

test_input = <<~TESTINPUT
  dark orange bags contain 3 bright white bags, 4 muted yellow bags.
  bright white bags contain 1 shiny gold bag.
  muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.
  shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.
  dark olive bags contain 3 faded blue bags, 4 dotted black bags.
  vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.
  faded blue bags contain no other bags.
  dotted black bags contain no other bags.
TESTINPUT
@test_lines = test_input.strip.split("\n")

# helper methods
def assert(value, expected_value)
  if value == expected_value
    puts "."
  else
    puts "Failed: Expected #{expected_value}, got #{value}"
  end
end

def lines
  @lines
end

def test_lines
  @test_lines
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
