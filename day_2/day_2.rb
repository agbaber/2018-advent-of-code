@input = []
@with_two_chars = 0
@with_three_chars = 0

def read_file
  File.open("input.txt", "r") do |f|
    f.each_line do |line|
      @input << line.chomp
    end
  end
end

def run
  @input.each do |i|
    h = Hash[i.split('').group_by {|x| x}.map {|k,v| [k,v.count]}]
    # puts h
    if h.has_value?(2)
      @with_two_chars += 1
    end

    if h.has_value?(3)
      @with_three_chars += 1
    end
  end
end


read_file
run
puts "#{@with_three_chars * @with_two_chars}"