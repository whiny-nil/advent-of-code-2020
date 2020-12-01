# Parse the damn input
file_name = File.dirname(__FILE__) + '/input.txt'
lines = File.read(file_name).strip.split("\n")

# Setup stuff for this problem
@nums = lines.map(&:to_i)

def solution1
  @nums.each do |n1|
    @nums.each do |n2|
      next if n1 == n2
      return n1 * n2 if n1 + n2 == 2020
    end
  end

end

def solution2
  @nums.each do |n1|
    @nums.each do |n2|
      @nums.each do |n3|
        next if n1 == n2 || n1 == n3 || n2 == n3
        return n1 * n2 * n3 if n1 + n2 + n3 == 2020
      end
    end
  end
end

puts "Solution 1: #{solution1}"
puts "Solution 2: #{solution2}"
