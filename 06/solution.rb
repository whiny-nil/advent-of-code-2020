# Parse the damn input
file_name = File.dirname(__FILE__) + '/input.txt'
@lines = File.read(file_name).strip.split("\n\n")

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

# stuff for this problem
def parse1(line)
  line.split("\n")
      .map { |x| x.split("") }
      .flatten
      .map { |x| x.split("") }
      .uniq
      .length
end

def parse2(line)
  line.split("\n")
      .map { |x| x.split("") }
      .reduce(&:&)
      .length
end

def solution1
  lines.map{ |line| parse1(line) }.reduce(&:+)
end

def solution2
  lines.map{ |line| parse2(line) }.reduce(&:+)
end

# assert(parse1("abc"), 3)
# assert(parse1("a\nb\nc"), 3)
# assert(parse1("ab\nac"), 3)
# assert(parse1("a\na\na\na"), 1)
# assert(parse1("b"), 1)

# assert(parse2("abc"), 3)
# assert(parse2("a\nb\nc"), 0)
# assert(parse2("ab\nac"), 1)
# assert(parse2("a\na\na\na"), 1)
# assert(parse2("b"), 1)

puts "Solution 1: #{solution1}"
puts "Solution 2: #{solution2}"
