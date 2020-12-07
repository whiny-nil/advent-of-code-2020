# Parse the damn input
file_name = File.dirname(__FILE__) + '/input.txt'
@lines = File.read(file_name).strip.split("\n")

test_input = <<~TESTINPUT
  dark orange bags contain 3 bright white bags, 4 muted yellow bags.
  bright white bags contain 1 shiny gold bag.
  muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.
  shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.
  dark olive bags contain 3 faded blue bags, 4 dotted black bags.
  vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.
  faded blue bags contain no other bags.
  dotted black bags contain no other bags.
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
def rules1
  @rules1
end

def parse1(line)
  clean_line = line.gsub("bags", "bag").gsub(".", "")
  parts = clean_line.split(" contain ")
  container = parts[0]
  contents = parts[1]
  parts[1].split(", ").each do |content|
    next if content == "no other bag"
    normalized_content = content.sub(/[0-9]+ /, "")
    
    if @rules1[normalized_content]
      @rules1[normalized_content] << container
    else
      @rules1[normalized_content] = [container]
    end
  end 
end

def parse_rules1(lines)
  @rules1 = {}
  
  lines.map { |line| parse1(line) }
end

def trace1(bag)
  return if rules1[bag].nil?

  rules1[bag] + rules1[bag].map { |b| trace1(b) }
end

def solution1
  parse_rules1(lines)
  trace1("shiny gold bag").flatten.compact.uniq.length
end

def solution2
  return "Not implemented!"
end

# assert(solution1, 355)

puts "Solution 1: #{solution1}"
puts "Solution 2: #{solution2}"
