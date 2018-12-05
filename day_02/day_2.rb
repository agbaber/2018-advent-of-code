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

def run_part_1
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

@matches = []

def run_part_2
  @input.each do |i|
    split = i.split('')
    compare = @input - [i]
    compare.each do |c|
      result = split.zip(c.split('')).collect {|x,y| x==y }.group_by {|x| x} #.map {|k,v| [k,v.count]}
      if result[false].size == 1
        @matches << [i, c]
        @input -= [c]
      end
    end
  end
end


read_file
# run_part_1
# puts "#{@with_three_chars * @with_two_chars}"
run_part_2
puts @matches.inspect

nvosmkcdtdbfhyxsphzgraljq
nvosmkcdtdbfhyxsphzgeraljq
nvosmkcdtdbfhyxsphzgeraljq
nvosmkcdtdbfhyxsphzgrraljq