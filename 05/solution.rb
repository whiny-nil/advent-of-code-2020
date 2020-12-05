file_name = File.dirname(__FILE__) + '/input.txt'
@lines = File.read(file_name).strip.split("\n")

def assert(value, expected_value)
  if value == expected_value
    puts "Passed: #{value} == #{expected_value}"
  else
    puts "Failed: #{value} != #{expected_value}"
  end
end

def lines
  @lines
end

def parse(bp)
  8 * parse_row(bp) + parse_column(bp)
end

def parse_row(bp)
  bp[0..6].gsub('F', '0').gsub('B', '1').to_i(2)
end

def parse_column(bp)
  bp[7..-1].gsub('L', '0').gsub('R', '1').to_i(2)
end

def solution1
  max = 0
  
  lines.each do |line|
    id = parse(line)
    max = id if id > max
  end

  max
end

def solution2
  sorted = lines.map {|line| parse(line) }.sort
  previous = sorted[0] - 1
  sorted.each do |current|
    if current - previous == 2
      return current - 1
    else
      previous = current
    end
  end
end

# assert(parse("FBFBBFFRLR"), 357)
# assert(parse("BFFFBBFRRR"), 567)
# assert(parse("FFFBBBFRRR"), 119)
# assert(parse("BBFFBBFRLL"), 820)

puts "Solution 1: #{solution1}"
puts "Solution 2: #{solution2}"
