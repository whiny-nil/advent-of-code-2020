# Parse the damn input
file_name = File.dirname(__FILE__) + '/input.txt'
@lines = File.read(file_name).strip.split("\n").map(&:to_i).sort if File.exist?(file_name)
@lines.unshift(0)

test_input1 = <<~TESTINPUT1
  16
  10
  15
  5
  1
  11
  7
  19
  6
  12
  4
TESTINPUT1

test_input2 = <<~TESTINPUT2
  28
  33
  18
  42
  31
  14
  46
  20
  48
  47
  24
  23
  49
  45
  19
  38
  39
  11
  1
  32
  25
  35
  8
  17
  7
  9
  4
  2
  34
  10
  3
TESTINPUT2
@test_lines1 = test_input1.strip.split("\n").map(&:to_i).sort
@test_lines1.unshift(0)
@test_lines2 = test_input2.strip.split("\n").map(&:to_i).sort
@test_lines2.unshift(0)

# helper methods
def assert(value, expected_value)
  puts (value == expected_value ? "." : "Failed: Expected #{expected_value.inspect}, got #{value.inspect}")
end

# stuff for this problem
def fib(n)
  return 1 if n == 0
  return 1 if n == 1

  fib(n-1) + fib(n-2)
end

def calc_paths(n)
  return 1 if n == 0
  return 1 if n == 1
  fib(n-1) + calc_paths(n-1)
end

def solution1(adapters)
  diff1 = 0
  diff2 = 0
  diff3 = 0

  adapters.each_with_index do |adapter, i|
    diff3 += 1 and break if adapter == adapters.last

    diff = adapters[i+1] - adapter
    diff1 += 1 if diff == 1
    diff2 += 1 if diff == 2
    diff3 +=1 if diff == 3
  end

  diff1 * diff3
end

def solution2(adapters)
  # THERE ARE NO DIFFERENCES OF 2!!!
  # So, what we do is scan through our adapters to parse out chunks where
  # the difference is 1, and we calculate how many paths there are through
  # that chunk.  If we find a diff. of 3, that is a bottleneck where there
  # is only one path through, so we start again.
  idx = 0
  paths = 1
  chunks = [0]
  chunk = 0
  former = -1

  adapters.each do |adapter|
    if adapter - former == 3
      chunk += 1
      chunks[chunk] = 0
    end
    
    chunks[chunk] += 1
    former = adapter
  end

  chunks.each do |chunk|
    paths *= calc_paths(chunk - 1)
  end

  paths
end

assert(calc_paths(1), 1)
assert(calc_paths(2), 2)
assert(calc_paths(3), 4)
assert(calc_paths(4), 7)
assert(calc_paths(5), 12)

assert(solution1(@test_lines1), 35)
assert(solution1(@test_lines2), 220)
assert(solution2(@test_lines1), 8)
assert(solution2(@test_lines2), 19208)

puts "Solution 1: #{solution1(@lines)}"
puts "Solution 2: #{solution2(@lines)}"