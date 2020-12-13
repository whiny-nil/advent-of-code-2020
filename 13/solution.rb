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

def solution2(id_string, earliest_time = 0)
  bus_ids = parse2(id_string)
  iter = bus_ids[0][ID]

  # find the first multiple of the first id after the earliest time
  until earliest_time % iter == 0
    earliest_time += 1
  end

  while true do
    return earliest_time if bus_ids.all? { |el| (earliest_time + el[OFFSET]) % el[ID] == 0 }
    earliest_time += iter
  end
end

assert(solution1(@test_lines), 295)
assert(solution2(@test_lines[1]), 1068781)
assert(solution2('17,x,13,19'), 3417)
assert(solution2('67,7,59,61'), 754018)
assert(solution2('67,x,7,59,61'), 779210)
assert(solution2('67,7,x,59,61'), 1261476)
assert(solution2('1789,37,47,1889'), 1202161486)

puts "Solution 1: #{solution1(@lines)}"
# puts "Solution 2: #{solution2(@lines[1], 100000000000000)}"
