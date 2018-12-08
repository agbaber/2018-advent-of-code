require 'matrix'
@input = []


def read_file
  File.open("input.txt", "r") do |f|
    f.each_line do |line|
      @input << line.chomp.split(', ').map(&:to_i)
    end
  end
end

class Numeric
  Alpha26 = ("a".."z").to_a
  def to_s26
    return "" if self < 1
    s, q = "", self
    loop do
      q, r = (q - 1).divmod(26)
      s.prepend(Alpha26[r]) 
      break if q.zero?
    end
    s
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
    @rows[j][i] = x
  end
end

def create_matrix
  @matrix = Matrix.zero(400)
end

def plot_points
  @input.each_with_index do |point, i|
    # alphabet = ('A'..'Z').to_a
    @matrix[point[0], point[1]] = i.to_s26.upcase

    # for each point on the grid, find the distance to all available points
    # sort those distances, if one is the min, assign that letter, if one is tied, set .


    # if @matrix[point[1] + @x, point[0] + @y]
    # require 'pry';binding.pry
  end

  # row = @matrix.index()
  # p [row.index('S'), array.index(row)]
end

def calculate_distances
  @matrix.each_with_index do |point, y, x|
    if @matrix[x,y] == 0
      distances = {}
      @input.each_with_index do |input_point, i|
        # alphabet = ('A'..'Z').to_a
        letter = i.to_s26.upcase
        # require 'pry';binding.pry
        distance = (input_point[0]-y).abs + (input_point[1]-x).abs
        # puts "point #{y},#{x} is #{distance} distance from #{letter}"
        distances[letter] = distance
      end

      closest = distances.sort_by(&:last)
      if closest[0][1] == closest[1][1]
        @matrix[y,x] = '.'
      else
        @matrix[y,x] = closest[0][0].downcase
      end
    end
  end
end
@infinite_chars = []

def find_non_infinite_max
  # require 'pry';binding.pry
  @matrix.each_with_index do |point, y, x|
    # require 'pry';binding.pry
    if x == 0 || x == @matrix.row_size - 1
      unless @infinite_chars.include?(point)
        @infinite_chars << point
      end
    end

    if y == 0 || y == @matrix.column_size - 1
      unless @infinite_chars.include?(point)
        @infinite_chars << point
      end
    end
  end
end

def count_instances
  flat = @matrix.to_a.flatten.map(&:upcase)
  @counts = Hash.new(0)
  flat.each { |letter| @counts[letter] += 1 }
  # require 'pry';bindi/ng.pry
  @counts.reject! {|k,v| @infinite_chars.map(&:upcase).include?(k)}

  puts @counts.inspect
end


def run
  read_file
  create_matrix
  plot_points
  calculate_distances
  puts @matrix.to_readable
  find_non_infinite_max
  puts @infinite_chars
  count_instances

  puts "answer:"
  puts @counts.max_by(&:last)
end

run