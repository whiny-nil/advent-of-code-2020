require 'byebug'

ID = 0
OFFSET = 1

# Parse the damn input
file_name = File.dirname(__FILE__) + '/input.txt'
@lines = File.read(file_name).strip.split("\n") if File.exist?(file_name)

test_input = <<~TESTINPUT
  939
  7,13,x,x,59,x,31,19
TESTINPUT
@test_lines = test_input.strip.split("\n")

# helper methods
def assert(value, expected_value)
  puts (value == expected_value ? "." : "Failed: Expected #{expected_value.inspect}, got #{value.inspect}")
end

def parse1(lines)
  start_time = lines[0].to_i
  bus_ids = lines[1].split(',').reject { |el| el == 'x' }.map(&:to_i).sort

  [start_time, bus_ids]
end

def parse2(id_string)
  ids = []
  id_string.split(',').each_with_index { |el, i| ids << [el.to_i, i] unless el == 'x' }

  ids
end

def calc(a, b, offset)
  i = 0
  while true
    i += 1
    x = (a * i) + offset
    return x if (x + b[OFFSET]) % b[ID] == 0
  end
end

# stuff for this problem
def solution1(lines)
  start_time, bus_ids = parse1(lines)
  i = 0

  while true do
    bus_ids.each do |id|
      return i * id if (start_time + i) % id == 0
    end
    i += 1
  end
end

def solution2(id_string)
  # Made a graph of some numbers to figure this shit out
  buses = parse2(id_string)

  # Take first two (number+offset) from ids (call a and b)
  p = buses.shift[0]
  o = 0

  buses.each do |bus|
    # Calculate first number which works for them:
    o = calc(p, bus, o)
  
    # Calculate p, which is product of a[ID] and b[ID]
    p = p * bus[ID]
  
    # Now, each subsequent number which works for them is (n * p) + o, where n is some integer
    # So now, we can calculate every number which works for a and b
    # We can repeat these steps for c, and d, etc until we have the answer
  end

  o
end

assert(solution1(@test_lines), 295)
assert(solution2(@test_lines[1]), 1068781)
assert(solution2('17,x,13,19'), 3417)
assert(solution2('67,7,59,61'), 754018)
assert(solution2('67,x,7,59,61'), 779210)
assert(solution2('67,7,x,59,61'), 1261476)
assert(solution2('1789,37,47,1889'), 1202161486)

puts "Solution 1: #{solution1(@lines)}"
puts "Solution 2: #{solution2(@lines[1])}"
