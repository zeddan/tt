require "time"

class Parser
  def initialize(input)
    @input = input
    @summary = Hash.new { |hash, key| hash[key] = 0 }
    @start_times = {}
  end

  def parse
    @input.each do |row|
      if row[1] == "start"
        @start_times[row[0]] = row
      elsif row[1] == "stop"
        seconds = time_to_seconds(@start_times[row[0]], row)
        @summary[row[-1]] += seconds
      end
    end

    @summary.map { |k,v| [k, format_seconds(v)] }
  end

  def time_to_seconds(start_entry, stop_entry)
    ( Time.parse(stop_entry[2]) - Time.parse(start_entry[2]) ).to_i
  end

  private

  def format_seconds(t)
    mm, ss = t.divmod(60)
    hh, mm = mm.divmod(60)
    _, hh = hh.divmod(24)

    "#{hh}h #{mm}m #{ss}s"
  end
end

