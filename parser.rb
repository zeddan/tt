require "time"

class Parser
  def initialize(input)
    @input = input
    @stack = []
  end

  def parse
    @input.group_by(&:first).map do |_, v|
      next unless v.size == 2

      name = v[0][3]

      stop = Time.parse(v[1][2])
      start = Time.parse(v[0][2])
      time = stop - start

      [name, format_seconds(time.to_i)]
    end
  end

  private

  def format_seconds(t)
    mm, ss = t.divmod(60)
    hh, mm = mm.divmod(60)
    _, hh = hh.divmod(24)

    "#{hh}h #{mm}m #{ss}s"
  end
end

