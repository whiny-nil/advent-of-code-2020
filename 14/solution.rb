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

# helper methods
def assert(value, expected_value)
  puts (value == expected_value ? "." : "Failed: Expected #{expected_value.inspect}, got #{value.inspect}")
end

def parse(lines)
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

def update_registers(command)
  value = apply_mask(command[ADDRESS_VALUE])
  @registers[command[ADDRESS]] = value
end

def apply_mask(value)
  @mask.each { |m| value[m[MASK_INDEX]] = m[MASK_BIT] }

  value
end

# stuff for this problem
def solution1(lines)
  code = parse(lines)
  @mask = ''
  @registers = {}

  code.each do |instruction|
    @mask = instruction[VALUE] if instruction[COMMAND] == 'mask'
    update_registers(instruction[VALUE]) if instruction[COMMAND] == 'mem'
  end

  sum = 0
  @registers.each do |_k, v|
    sum += v.to_i(2)
  end

  sum
end

def solution2(lines)
  return "Not implemented!"
end

assert(solution1(@test_lines), 165)
# assert(solution2(@test_lines), nil)

puts "Solution 1: #{solution1(@lines)}"
# puts "Solution 2: #{solution2(@lines)}"
