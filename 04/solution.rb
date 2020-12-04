# Parse the damn input
file_name = File.dirname(__FILE__) + '/input.txt'
@records = File.read(file_name).strip.split("\n\n")

def records
  @records
end

def parse(record)
  record.strip.split("\n")
    .map { |part| part.split(" ") }.flatten
    .map { |part| part.split(":") }.to_h
end

def parsed_records
  @parsed_records ||= @records.map { |record| parse(record) }
end

# byr (Birth Year)
# iyr (Issue Year)
# eyr (Expiration Year)
# hgt (Height)
# hcl (Hair Color)
# ecl (Eye Color)
# pid (Passport ID)
# cid (Country ID)

def required_fields
  # "cid" is not required
  [
    "byr",
    "ecl",
    "eyr",
    "hcl",
    "hgt",
    "iyr",
    "pid",
  ]
end

def valid?(record)
  valid_byr?(record["byr"]) && valid_ecl?(record["ecl"]) && valid_eyr?(record["eyr"]) &&
  valid_hcl?(record["hcl"]) && valid_hgt?(record["hgt"]) && valid_iyr?(record["iyr"]) &&
  valid_pid?(record["pid"]) 
end

# byr (Birth Year) - four digits; at least 1920 and at most 2002.
def valid_byr?(data)
  return false unless data

  1920 <= data.to_i && data.to_i <= 2002
end

# ecl (Eye Color) - exactly one of: amb blu brn gry grn hzl oth.
def valid_ecl?(data)
  return false unless data

  ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"].include?(data)
end

# eyr (Expiration Year) - four digits; at least 2020 and at most 2030.
def valid_eyr?(data)
  return false unless data

  2020 <= data.to_i && data.to_i <= 2030
end

# hcl (Hair Color) - a # followed by exactly six characters 0-9 or a-f.
def valid_hcl?(data)
  return false unless data

  data.length == 7 && (data.match? /#[0-9abcdef]{6}/)
end

# hgt (Height) - a number followed by either cm or in:
#     If cm, the number must be at least 150 and at most 193.
#     If in, the number must be at least 59 and at most 76.
def valid_hgt?(data)
  return false unless data

  if (data.match? "cm")
    150 <= data.to_i && data.to_i <= 193
  elsif (data.match? "in")
    59 <= data.to_i && data.to_i <= 76
  else
    false
  end
end

# iyr (Issue Year) - four digits; at least 2010 and at most 2020.
def valid_iyr?(data)
  return false unless data

  2010 <= data.to_i && data.to_i <= 2020
end

# pid (Passport ID) - a nine-digit number, including leading zeroes.
def valid_pid?(data)
  return false unless data

  data.length == 9 && (data.match /[0-9]{9}/)
end

def solution1
  valid_count = 0
  
  parsed_records.each do |record|
    valid_count += 1 if (record.keys & required_fields).sort == required_fields
  end

  valid_count
end

def solution2
  valid_count = 0

  parsed_records.each do |record|
    valid_count += 1 if valid?(record)
  end
  
  valid_count
end

puts "Solution 1: #{solution1}"
puts "Solution 2: #{solution2}"
