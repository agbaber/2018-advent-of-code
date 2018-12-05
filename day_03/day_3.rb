require 'matrix'

FORMAT = /#(?<num>.+) @ (?<lpad>\d+),(?<vpad>\d+): (?<x>\d+)x(?<y>\d+)/

@input = []
@all_cuts = []

def read_file
  File.open("input.txt", "r") do |f|
    f.each_line do |line|
      match_data = line.chomp.match(FORMAT)
      @input << match_data
      @all_cuts << match_data['num']
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
  @matrix = Matrix.zero(2000)
end

def plot_cuts
  @input.each do |i|
    x = i['x'].to_i
    y = i['y'].to_i
    lpad = i['lpad'].to_i
    vpad = i['vpad'].to_i

    y.times do |index_y|
      x.times do |index_x|
        if @matrix[lpad+index_x,vpad+index_y] == 0
          @matrix[lpad+index_x,vpad+index_y] = i['num']
        else
          @all_cuts -= [@matrix[lpad+index_x,vpad+index_y]]
          @matrix[lpad+index_x,vpad+index_y] = 'X'
          @all_cuts -= [i['num']]
        end
      end
    end
  end
end

def find_overlaps
  counts = @matrix.to_a.flatten.group_by {|x| x}.map {|k,v| [k,v.count] if k == 'X' }.compact.inspect
end

def run
  read_file
  create_matrix
  plot_cuts
  puts find_overlaps
  puts @all_cuts
end

run

# puts @input.inspect
# puts @input.last['y']

# puts @matrix.to_readable