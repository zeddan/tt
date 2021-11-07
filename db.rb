require "csv"

class DB
  def initialize; end

  def start(args)
    CSV.open("#{DIR_PATH}/active.csv", "a") do |csv|
      csv << [
        args[:id],
        args[:type],
        args[:reference],
        args[:timestamp],
        args[:name]
      ]
    end
  end
end
