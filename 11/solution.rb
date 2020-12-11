require 'byebug'

# Parse the damn input
file_name = File.dirname(__FILE__) + '/input.txt'
@lines = File.read(file_name).strip.split("\n").map{ |l| l.strip.split('') } if File.exist?(file_name)

test_input = <<~TESTINPUT
  L.LL.LL.LL
  LLLLLLL.LL
  L.L.L..L..
  LLLL.LL.LL
  L.LL.LL.LL
  L.LLLLL.LL
  ..L.L.....
  LLLLLLLLLL
  L.LLLLLL.L
  L.LLLLL.LL
TESTINPUT
@test_lines = test_input.strip.split("\n").map{ |l| l.strip.split('') }

# helper methods
def assert(value, expected_value)
  puts (value == expected_value ? "." : "Failed: Expected #{expected_value.inspect}, got #{value.inspect}")
end

# Solution 1
def iterate1(seats)
  new_seats = []

  seats.each_with_index do |row, r|
    new_seats[r] = []
    row.each_with_index do |seat, c|
      new_seats[r][c] = iterate_seat1(seats, r, c)
    end
  end

  new_seats
end

def iterate_seat1(seats, row, column)
  seat = seats[row][column]
  return '.' if seat == '.'

  if seat == 'L'
    return count_occupied_adjacent1(seats, row, column) == 0 ? '#' : 'L'
  elsif seat == "#"
    return count_occupied_adjacent1(seats, row, column) >= 4 ? 'L' : '#'
  end
end

def count_occupied_adjacent1(seats, row, column)
  min_row = 0
  max_row = seats.length - 1
  min_col = 0
  max_col = seats[0].length - 1

  count = 0
  [-1, 0, 1].each do |r|
    [-1, 0, 1].each do |c|
      check_row = row + r
      check_col = column + c
      next if check_row < min_row ||
              check_row > max_row ||
              check_col < min_col ||
              check_col > max_col ||
              (r == 0 && c == 0)

      count += 1 if seats[check_row][check_col] == '#'
    end
  end

  count
end

# Solution 2
def iterate2(seats)
  new_seats = []

  seats.each_with_index do |row, r|
    new_seats[r] = []
    row.each_with_index do |seat, c|
      new_seats[r][c] = iterate_seat2(seats, r, c)
    end
  end

  new_seats
end

def iterate_seat2(seats, row, column)
  seat = seats[row][column]
  return '.' if seat == '.'

  if seat == 'L'
    return count_occupied_adjacent2(seats, row, column) == 0 ? '#' : 'L'
  elsif seat == "#"
    return count_occupied_adjacent2(seats, row, column) >= 5 ? 'L' : '#'
  end
end

def count_occupied_adjacent2(seats, row, column)
  min_row = 0
  max_row = seats.length - 1
  min_col = 0
  max_col = seats[0].length - 1

  count = 0
  [-1, 0, 1].each do |r|
    [-1, 0, 1].each do |c|
      check_row = row
      check_col = column

      while true do
        check_row += r
        check_col += c

        break if check_row < min_row ||
                check_row > max_row ||
                check_col < min_col ||
                check_col > max_col ||
                (r == 0 && c == 0)

        count += 1 if seats[check_row][check_col] == '#'
        break if seats[check_row][check_col] != '.'
      end
    end
  end

  count
end

# stuff for this problem
def deep_dup(ary)
  ary.map { |sub_ary| sub_ary.map { |el| el } }
end

def count_occupied(seats)
  seats.flatten.count("#")
end

def solution1(seats)
  seats1 = []
  seats2 = deep_dup(seats)
  done = false

  until done do
    seats1 = seats2
    seats2 = iterate1(seats1)

    done = seats1 == seats2
  end
  
  count_occupied(seats2)
end

def solution2(seats)
  seats1 = []
  seats2 = deep_dup(seats)
  done = false

  until done do
    seats1 = seats2
    seats2 = iterate2(seats1)

    done = seats1 == seats2
  end
  
  count_occupied(seats2)
end

test_seats1 = [
  ["#", ".", "#", "#", ".", "#", "#", ".", "#", "#"],
  ["#", "#", "#", "#", "#", "#", "#", ".", "#", "#"],
]
assert(count_occupied_adjacent1(test_seats1, 0, 5), 4)
assert(count_occupied_adjacent1(test_seats1, 0, 6), 3)

assert(solution1(@test_lines), 37)
assert(solution2(@test_lines), 26)

puts "Solution 1: #{solution1(@lines)}"
puts "Solution 2: #{solution2(@lines)}"
