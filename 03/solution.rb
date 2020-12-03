# Parse the damn input
file_name = File.dirname(__FILE__) + '/input.txt'
@lines = File.read(file_name).strip.split("\n")

# Setup stuff for this problem

def lines
  @lines
end

def row_count
  @row_count ||= @lines.length
end

def col_count
  @col_count ||= @lines[0].length
end

def count_trees(col_step, row_step)
  column = 0
  row = 0
  tree_count = 0

  while row < row_count
    tree_count += 1 if @lines[row][column] == '#'
    column = (column + col_step) % col_count
    row += row_step
  end

  tree_count
end

def solution1
  count_trees(3, 1)
end

def solution2
  [
    count_trees(1, 1),
    count_trees(3, 1),
    count_trees(5, 1),
    count_trees(7, 1),
    count_trees(1, 2),
  ].reduce(&:*)
end

puts "Solution 1: #{solution1}"
puts "Solution 2: #{solution2}"
