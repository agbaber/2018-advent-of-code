@input = []
@value = 0
@new_vals = [0]
@i = 0

def read_file
  File.open("input.txt", "r") do |f|
    f.each_line do |line|
      @input << line.chomp
    end
  end
end

def run
  @input.each do |i|
    # puts "sending #{i[0]} #{i[1..-1]} "
    @value = @value.send(i[0], i[1..-1].to_i)

    if @new_vals.include?(@value)
      puts "Returned to:"
      puts @value
      puts "#{@i} iterations"
      exit
    else
      @new_vals << @value
      @i += 1
    end
  end

  run
end

read_file
run

