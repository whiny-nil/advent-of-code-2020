require 'byebug'

TIMES_SPOKEN = 0
FIRST_SPOKEN = 1
LAST_SPOKEN = 2

# Parse the damn input
# file_name = File.dirname(__FILE__) + '/input.txt'
# @lines = File.read(file_name).strip.split("\n") if File.exist?(file_name)
@input = [8,0,17,4,1,12]

# helper methods
def assert(value, expected_value)
  puts (value == expected_value ? "." : "Failed: Expected #{expected_value.inspect}, got #{value.inspect}")
end

# stuff for this problem
def solution1(seeds)
  turn_map = {}
  seeds.each_with_index { |n, turn| turn_map[n] = [1, turn + 1, turn + 1] }
  last_number = seeds.last

  ((seeds.length+1)..2020).each do |turn|
    last_stats = turn_map[last_number]
    if last_stats[TIMES_SPOKEN] == 1
      zero = turn_map[0] || [0, turn, turn]
      zero[TIMES_SPOKEN] += 1
      zero[FIRST_SPOKEN] = zero[LAST_SPOKEN]
      zero[LAST_SPOKEN] = turn
      
      turn_map[0] = zero
      last_number = 0
    else
      age = last_stats[LAST_SPOKEN] - last_stats[FIRST_SPOKEN]

      num = turn_map[age] || [0, turn, turn]
      num[TIMES_SPOKEN] += 1
      num[FIRST_SPOKEN] = num[LAST_SPOKEN]
      num[LAST_SPOKEN] = turn
      
      turn_map[age] = num
      last_number = age
    end
  end

  last_number
end

def solution2(seeds)
  turn_map = {}
  seeds.each_with_index { |n, turn| turn_map[n] = [1, turn + 1, turn + 1] }
  last_number = seeds.last

  ((seeds.length+1)..30000000).each do |turn|
    last_stats = turn_map[last_number]
    if last_stats[TIMES_SPOKEN] == 1
      zero = turn_map[0] || [0, turn, turn]
      zero[TIMES_SPOKEN] += 1
      zero[FIRST_SPOKEN] = zero[LAST_SPOKEN]
      zero[LAST_SPOKEN] = turn
      
      turn_map[0] = zero
      last_number = 0
    else
      age = last_stats[LAST_SPOKEN] - last_stats[FIRST_SPOKEN]

      num = turn_map[age] || [0, turn, turn]
      num[TIMES_SPOKEN] += 1
      num[FIRST_SPOKEN] = num[LAST_SPOKEN]
      num[LAST_SPOKEN] = turn
      
      turn_map[age] = num
      last_number = age
    end
  end

  last_number
end

# assert(solution1([0,3,6]), 436)
# assert(solution1([1,3,2]), 1)
# assert(solution1([2,1,3]), 10)
# assert(solution1([1,2,3]), 27)
# assert(solution1([2,3,1]), 78)
# assert(solution1([3,2,1]), 438)
# assert(solution1([3,1,2]), 1836)

# assert(solution2([0,3,6]), 175594)
# assert(solution2([1,3,2]), 1)
# assert(solution2([2,1,3]), 10)
# assert(solution2([1,2,3]), 27)
# assert(solution2([2,3,1]), 78)
# assert(solution2([3,2,1]), 438)
# assert(solution2([3,1,2]), 1836)

puts "Solution 1: #{solution1(@input)}"
puts "Solution 2: #{solution2(@input)}"
