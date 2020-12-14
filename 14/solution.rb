require 'byebug'

COMMAND = 0
VALUE = 1

MASK_INDEX = 0
MASK_BIT = 1

ADDRESS = 0
ADDRESS_VALUE = 1

# Parse the damn input
file_name = File.dirname(__FILE__) + '/input.txt'
@lines = File.read(file_name).strip.split("\n") if File.exist?(file_name)

test_input = <<~TESTINPUT
  mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X
  mem[8] = 11
  mem[7] = 101
  mem[8] = 0
TESTINPUT
@test_lines = test_input.strip.split("\n")

test_input2 = <<~TESTINPUT
  mask = 000000000000000000000000000000X1001X
  mem[42] = 100
  mask = 00000000000000000000000000000000X0XX
  mem[26] = 1
TESTINPUT
@test_lines2 = test_input2.strip.split("\n")

# helper methods
def assert(value, expected_value)
  puts (value == expected_value ? "." : "Failed: Expected #{expected_value.inspect}, got #{value.inspect}")
end

# Solution 1
def parse1(lines)
  lines.map do |line|
    parts = line.split(" = ")
    if parts[COMMAND] == 'mask'
      mask = []
      parts[VALUE].scan(/\w/).each_with_index { |bit, i| mask << [i, bit] unless bit == 'X' }
      parts[VALUE] = mask
    else
      command = parts[COMMAND]
      address = command.sub('mem[', '').sub(']', '')
      value = parts[VALUE].to_i.to_s(2).rjust(36, '0')
      parts[COMMAND] = 'mem'
      parts[VALUE] = [address, value]
    end

    parts
  end
end

def update_registers1(command)
  value = apply_mask1(command[ADDRESS_VALUE])
  @registers[command[ADDRESS]] = value
end

def apply_mask1(value)
  @mask.each { |m| value[m[MASK_INDEX]] = m[MASK_BIT] }

  value
end

def solution1(lines)
  code = parse1(lines)
  @mask = ''
  @registers = {}

  code.each do |instruction|
    @mask = instruction[VALUE] if instruction[COMMAND] == 'mask'
    update_registers1(instruction[VALUE]) if instruction[COMMAND] == 'mem'
  end

  sum = 0
  @registers.each do |_k, v|
    sum += v.to_i(2)
  end

  sum
end

# Solution 2
def parse2(lines)
  lines.map do |line|
    parts = line.split(" = ")
    if parts[COMMAND] == 'mask'
      mask = []
      parts[VALUE].scan(/\w/).each_with_index { |bit, i| mask << [i, bit] unless bit == '0' }
      parts[VALUE] = mask
    else
      command = parts[COMMAND]
      address = command.sub('mem[', '').sub(']', '').to_i.to_s(2).rjust(36, '0')
      value = parts[VALUE].to_i
      parts[COMMAND] = 'mem'
      parts[VALUE] = [address, value]
    end

    parts
  end
end

def update_registers2(command)
  registers = apply_mask2(command[ADDRESS])
  registers.each { |r| @registers[r] = command[ADDRESS_VALUE] }
end

def apply_mask2(register)
  registers = [register]

  @mask.each do |m| 
    if m[MASK_BIT] == '1'
      registers.each_with_index do |r, i|
        registers[i][m[MASK_INDEX]] = '1'
      end
    elsif m[MASK_BIT] == 'X'
      new_registers = []
      registers.each do |r|
        reg0 = r.dup
        reg1 = r.dup
        reg0[m[MASK_INDEX]] = '0'
        reg1[m[MASK_INDEX]] = '1'
        new_registers << reg0
        new_registers << reg1
      end
      registers = new_registers
    end
  end

  registers
end

def solution2(lines)
  code = parse2(lines)
  @mask = ''
  @registers = {}

  code.each do |instruction|
    @mask = instruction[VALUE] if instruction[COMMAND] == 'mask'
    update_registers2(instruction[VALUE]) if instruction[COMMAND] == 'mem'
  end

  sum = 0
  @registers.each do |_k, v|
    sum += v.to_i
  end

  sum
end

assert(solution1(@test_lines), 165)
assert(solution2(@test_lines2), 208)

puts "Solution 1: #{solution1(@lines)}"
puts "Solution 2: #{solution2(@lines)}"
