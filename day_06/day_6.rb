def read_file
  File.open("input.txt", "r") do |f|
    f.each_line do |line|
      @input << line.chomp
    end
  end
end

class Matrix
  def to_readable
    i = 0
    self.each do |number|
      print number.to_s + " "
      i+= 1
      if i == self.column_size
        print "\n"
        i = 0
      end
    end
  end

  def []=(i, j, x)
    @rows[i][j] = x
  end
end

def create_matrix
  @matrix = Matrix.zero(400)
end

def plot_points
  @input.each_with_index do |point, i|
    @matrix[point[0], point[1]] = i
  end
end

def calculate_distances
end

def run
  read_file
  create_matrix
  plot_points
  calculate_distances
  puts @matrix.to_readable
end

run