# THIS WOULD BE A LOT EASIER IF I KNEW HOW TO DO MATRIX ARITHMETIC IN RUBY

# Parse the damn input
file_name = File.dirname(__FILE__) + '/input.txt'
@lines = File.read(file_name).strip.split("\n").map { |el| [el[0], el[1..-1].to_i] } if File.exist?(file_name)

test_input = <<~TESTINPUT
  F10
  N3
  F7
  R90
  F11
TESTINPUT
@test_lines = test_input.strip.split("\n").map { |el| [el[0], el[1..-1].to_i] }

# helper methods
def assert(value, expected_value)
  puts (value == expected_value ? "." : "Failed: Expected #{expected_value.inspect}, got #{value.inspect}")
end

class Solution1
  def initialize(instructions)
    @instructions = instructions

    @directions = ['E', 'S', 'W', 'N']
    @direction_index = 0

    @x = 0
    @y = 0
  end

  def heading
    @directions[@direction_index]
  end

  def rotate(dir, value)
    value = value % 360
    return if value == 0

    inc = 1 if value == 90 
    inc = 2 if value == 180
    inc = 3 if value == 270
    inc *= -1 if dir == 'L'

    @direction_index = (@direction_index + inc) % 4
  end

  def move(dir, value)
    case dir
    when 'E' then @x += value
    when 'W' then @x -= value
    when 'N' then @y += value
    when 'S' then @y -= value
    end
  end

  def run
    @instructions.each do |inst|
      command = inst[0]
      command = heading if command == 'F'
      value = inst[1]

      move(command, value) if ['N', 'S', 'E', 'W'].include? command
      rotate(command, value) if ['R', 'L'].include? command
    end
  end

  def distance
    @x.abs + @y.abs
  end
end

class Solution2
  def initialize(instructions)
    @instructions = instructions

    @ship_x = 0
    @ship_y = 0

    @waypoint_x = 10
    @waypoint_y = 1
  end

  def rotate_waypoint(dir, value)
    value = value % 360
    return if value == 0

    new_x = 0
    new_y = 0

    case value
    when 90
      new_x = @waypoint_y
      new_y = -1 * @waypoint_x 
      if dir == 'L'
        new_x *= -1
        new_y *= -1
      end
    when 180
      new_x = -1 * @waypoint_x
      new_y = -1 * @waypoint_y
    when 270
      new_x = -1 * @waypoint_y
      new_y = @waypoint_x
      if dir == 'L'
        new_x *= -1
        new_y *= -1
      end
    end

    @waypoint_x = new_x
    @waypoint_y = new_y
  end

  def move_waypoint(dir, value)
    case dir
    when 'E' then @waypoint_x += value
    when 'W' then @waypoint_x -= value
    when 'N' then @waypoint_y += value
    when 'S' then @waypoint_y -= value
    end
  end

  def move_ship(value)
    @ship_x += (value * @waypoint_x)
    @ship_y += (value * @waypoint_y)
  end

  def run
    @instructions.each do |inst|
      command = inst[0]
      value = inst[1]

      move_waypoint(command, value) if ['N', 'S', 'E', 'W'].include? command
      rotate_waypoint(command, value) if ['R', 'L'].include? command
      move_ship(value) if command == 'F'
    end
  end

  def distance
    @ship_x.abs + @ship_y.abs
  end
end

# stuff for this problem
def solution1(instructions)
  s = Solution1.new(instructions)
  s.run
  s.distance  
end

def solution2(instructions)
  s = Solution2.new(instructions)
  s.run
  s.distance  
end

assert(solution1(@test_lines), 25)
assert(solution2(@test_lines), 286)

puts "Solution 1: #{solution1(@lines)}"
puts "Solution 2: #{solution2(@lines)}"
