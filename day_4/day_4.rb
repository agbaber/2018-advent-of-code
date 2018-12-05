require 'date'
require 'active_support/all'

FORMAT = /\[(?<date>.+)\] (?<action>\w+) (?<mod>(#)\w+|\w++)/

@input = []

#[1518-02-28 00:47] falls asleep
#[1518-10-23 23:47] Guard #1627 begins shift
#[1518-10-25 00:41] wakes up

def read_file
  File.open("input.txt", "r") do |f|
    f.each_line do |line|
      match_data = line.chomp.match(FORMAT).named_captures
      match_data['date'] = DateTime.parse(match_data['date'])
      @input << match_data
    end
  end
end

def build_minutes_hash
  minutes = (0..59).to_a
  @minutes_hash = {}

  minutes.each do |minute|
    @minutes_hash[minute] = {}
  end
end

@guards_hash = {}
@guard_mins_hash = {}

def parse_input
  sorted = @input.sort_by {|k| k['date']}

  sorted.each do |event|
    case event['action']
    when 'falls'
      @sleep_minute = event['date'].minute
    when 'wakes'
      @wakes_minute = event['date'].minute
      # puts "guard #{@current_guard} slept from #{@sleep_minute} until #{@wakes_minute}"
      (@sleep_minute...@wakes_minute).to_a.each do |sleep_min|
        if @minutes_hash[sleep_min][@current_guard]
         @minutes_hash[sleep_min][@current_guard] += 1
        else
          @minutes_hash[sleep_min][@current_guard] = 1
        end

        if @guards_hash[@current_guard]
          @guards_hash[@current_guard] += 1
        else
          @guards_hash[@current_guard] = 1
        end

        if @current_guard == 3457
          if @guard_mins_hash[sleep_min]
            @guard_mins_hash[sleep_min] += 1
          else
            @guard_mins_hash[sleep_min] = 1
          end
        end
      end
    when 'Guard'
      date = event['date']
      if date.hour == 0
        @current_time = date
      else
        @current_time = (date + 1.day).midnight
      end

      guard_id = event['mod'][1..-1].to_i
      @current_guard = guard_id
    end
  end
end

@maximums = []

def find_max
  @minutes_hash.each do |min|
    # require 'pry';binding.pry
    @maximums << [min[0], min[1].max_by {|k,v| v}]
  end
end

def run
  read_file
  build_minutes_hash
  parse_input
  find_max
  puts "Guard with most sleep mins total"
  puts @guards_hash.max_by {|k,v| v}
  puts "Mins slept by above guard"
  puts @guard_mins_hash.max_by {|k,v| v}
  # 3457 * 40
end

run
