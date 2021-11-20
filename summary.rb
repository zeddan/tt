require_relative "parser"

class Summary
  def initialize
    @db = DB.new
  end

  def active
    active = @db.active
    table = TTY::Table.new(["Name", "Started"], active)
    puts table.render(:unicode)
  end

  def tracked
    all = Parser.new(@db.all).parse
    table = TTY::Table.new(["Name", "Started"], all)
    puts table.render(:unicode)
  end
end
