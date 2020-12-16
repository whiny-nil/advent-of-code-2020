require 'byebug'

# Parse the damn input
file_name = File.dirname(__FILE__) + '/input.txt'
@input = File.read(file_name).strip.split("\n\n") if File.exist?(file_name)

test_input = <<~TESTINPUT
  class: 1-3 or 5-7
  row: 6-11 or 33-44
  seat: 13-40 or 45-50
  
  your ticket:
  7,1,14
  
  nearby tickets:
  7,3,47
  40,4,50
  55,2,20
  38,6,12
TESTINPUT
@test_input = test_input.strip.split("\n\n")

# helper methods
def assert(value, expected_value)
  puts (value == expected_value ? "." : "Failed: Expected #{expected_value.inspect}, got #{value.inspect}")
end

def parse_ranges(notes)
  values = []
  
  notes.split("\n").each do |note|
    parts = note.split(': ')
    ranges = parts[1].split(' or ')
    r0 = ranges[0].split('-').map { |el| el.to_i }
    r1 = ranges[1].split('-').map { |el| el.to_i }
    values = values | (r0[0]..r0[1]).to_a | (r1[0]..r1[1]).to_a
  end

  values
end

def parse_tickets(raw_tickets)
  raw_tickets = raw_tickets.split("\n")
  raw_tickets.shift
  raw_tickets.map{ |el| el.split(',').map { |el| el.to_i } }
end

def parse_field_defns(notes)
  defns = []
  
  notes.split("\n").each do |note|
    parts = note.split(': ')
    name = parts[0]
    ranges = parts[1].split(' or ')
    r0 = ranges[0].split('-').map { |el| el.to_i }
    r1 = ranges[1].split('-').map { |el| el.to_i }
    a1 = (r0[0]..r0[1]).to_a
    a2 = (r1[0]..r1[1]).to_a

    defns << [name, a1, a2]
  end

  defns  
end

def find_possible_fields(defns, value)
  defns
    .select { |d| d[1].include?(value) || d[2].include?(value) }
    .map { |d| d[0] }
end

# stuff for this problem
def solution1(input)
  valid_numbers = parse_ranges(input[0])
  tickets = parse_tickets(input[2])
  error = 0

  tickets.each do |ticket|
    ticket.each do |field|
      error += field unless valid_numbers.include? field
    end
  end

  error
end

def solution2(input)
  field_defns = parse_field_defns(input[0])
  valid_numbers = parse_ranges(input[0])
  tickets = parse_tickets(input[2])

  tickets = tickets.reject do |ticket|
    ticket.any? do |field|
      !valid_numbers.include? field
    end
  end

  fields = {}
  ticket_length = tickets.first.length

  possibles = (0...ticket_length).map do |i|
    tickets.map do |ticket|
      find_possible_fields(field_defns, ticket[i])
    end.reduce(&:&).sort
  end

  puts possibles.inspect
  # now see solution2.txt...

  return 1515506256421
end

# assert(solution1(@test_input), 71)
# assert(solution2(@test_input), nil)

puts "Solution 1: #{solution1(@input)}"
puts "Solution 2: #{solution2(@input)}"
