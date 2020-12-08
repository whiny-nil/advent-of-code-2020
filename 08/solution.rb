INST_COMMAND = 0
INST_VALUE   = 1
INST_VISITED = 2

RES_VALUE = 0
RES_JMPS  = 1
RES_DONE  = 2

#Parse the damn input
file_name = File.dirname(__FILE__) + '/input.txt'
@lines = File.read(file_name).strip.split("\n")

test_input = <<~TESTINPUT
  nop +0
  acc +1
  jmp +4
  acc +3
  jmp -3
  acc -99
  acc +1
  jmp -4
  acc +6
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

def instructions(lines)
  lines.map do |l|
    parts = l.split(" ")
    inst = []
    inst[INST_COMMAND] = parts[0]
    inst[INST_VALUE] = parts[1].to_i
    inst[INST_VISITED] = false

    inst
  end
end

def run(instructions)
  acc = 0
  pointer = 0
  jmps = []
  done = false
  while true do
    current = instructions[pointer] 

    if current.nil?
      done = true
      break
    end
    if current[INST_VISITED]
      break
    end

    case current[INST_COMMAND]
    when "nop"
      pointer += 1
    when "acc"
      acc += current[INST_VALUE]
      pointer += 1
    when "jmp"
      jmps << pointer
      pointer += current[INST_VALUE]
    end
    current[INST_VISITED] = true
  end

  result = []
  result[RES_VALUE] = acc
  result[RES_JMPS] = jmps
  result[RES_DONE] = done
  
  result
end

def solution1(lines)
  return run(instructions(lines))[RES_VALUE]
end

def solution2(lines)
  jmps = run(instructions(lines))[RES_JMPS]
  solution = 0

  jmps.each do |jmp|
    instructions = instructions(lines)
    instructions[jmp][INST_COMMAND] = "nop"
    result = run(instructions)
    if result[RES_DONE]
      solution = result[RES_VALUE]
      break
    end
  end
  
  solution
end

assert(solution1(test_lines), 5)
assert(solution2(test_lines), 8)

puts "Solution 1: #{solution1(lines)}"
puts "Solution 2: #{solution2(lines)}"
