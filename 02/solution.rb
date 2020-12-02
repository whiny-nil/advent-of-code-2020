# Parse the damn input
file_name = File.dirname(__FILE__) + '/input.txt'
lines = File.read(file_name).strip.split("\n")

# Setup stuff for this problem
@passwords = lines.map do |l| 
  parts = l.split(':')
  policy = parts[0].split(' ')
  nums = policy[0].split('-')
  num1 = nums[0].to_i
  num2 = nums[1].to_i
  char = policy[1]
  password = parts[1].strip
  [password, char, num1, num2]
end

def solution1
  valid_passwords = 0
  @passwords.each do |pw|
    char_count = pw[0].count(pw[1])
    valid_passwords += 1 if pw[2] <= char_count && char_count <= pw[3]
  end
  
  valid_passwords
end

def solution2
  valid_passwords = 0
  @passwords.each do |pw|
    password = pw[0]
    char = pw[1]
    pos1 = pw[2] - 1
    pos2 = pw[3] - 1
    
    pos1_ok = password[pos1] == char
    pos2_ok = password[pos2] == char

    valid_passwords += 1 if (pos1_ok && !pos2_ok) || (pos2_ok && !pos1_ok)
  end
  
  valid_passwords
end

puts "Solution 1: #{solution1}"
puts "Solution 2: #{solution2}"
