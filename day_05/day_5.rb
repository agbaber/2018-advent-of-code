def read_file
  File.open("input.txt", "r") do |f|
    f.each_line do |line|
      @input = line.split('')
    end
  end
end


def kill_matches
  @run_count = 0

  @input.each_with_index do |l,i|
    if @input[i+1]
      if (l == @input[i+1])
      elsif (l == @input[i+1].upcase)
        @input.slice!(i+1)
        @input.slice!(i)
        @run_count += 1
        break
      elsif (l == @input[i+1].downcase)
        @input.slice!(i+1)
        @input.slice!(i)
        @run_count += 1
        break
      end
    end
  end
end

@letter_sizes = []

def remove_each_letter
  ('a'..'z').to_a.each do |letter|
    @run_count = nil
    read_file
    @input.reject! { |l| l == letter }
    @input.reject! { |l| l == letter.upcase }
    until @run_count == 0
      kill_matches
    end
    @letter_sizes << [letter, @input.size]
  end
end

def run
  read_file
  puts "original size"
  puts @input.size
  until @run_count == 0
    kill_matches
  end
  puts "reduced size"
  puts @input.size

  remove_each_letter
  puts @letter_sizes.min_by(&:last)
end

run

