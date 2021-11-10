require "csv"

class DB
  DIR_PATH = File.expand_path("~/.tt")
  ACTIVE_PATH = "#{DIR_PATH}/active.csv"
  DB_PATH = "#{DIR_PATH}/db.csv"

  COLUMNS = %w(id type timestamp name)

  def reset
    CSV.open(ACTIVE_PATH, "wb") do |csv|
      csv << COLUMNS
    end

    CSV.open(DB_PATH, "wb") do |csv|
      csv << COLUMNS
    end
  end

  def start(args)
    append_active(args)
  end

  def stop(name)
    save_activity(name)
    remove_from_active(name)
  end

  # returns an array of arrays containing name and timestamp
  # e.g [["a", "2020-10-10 at 15:50"], [...]]
  def active
    csv = CSV.read(ACTIVE_PATH)
    # [1..-1] = remove the columns header
    csv[1..-1].map do |row|
      # row[3] = name
      # row[2] = timestamp
      [row[3], parse_timestamp(row[2])]
    end
  end

  # returns an array of strings
  # e.g ["task1", "task2"]
  def names_active
    csv = CSV.read(ACTIVE_PATH)
    csv.select { |row| row[1] == "start" }.map { |row| row[3] }
  end

  def already_active?(name)
    names_active.include?(name)
  end

  private

  def remove_from_active(name)
    table = CSV.parse(csv_as_string, headers: true)
    table.delete_if { |row| row["name"] == name }
    CSV.open(ACTIVE_PATH, "wb") do |csv|
      csv << COLUMNS
      table.each do |row|
        csv << row
      end
    end
  end

  def save_activity(name)
    activity = CSV.read(ACTIVE_PATH).detect { |row| row[3] == name }

    # save starting time
    CSV.open(DB_PATH, "a") do |csv|
      csv << activity
    end

    # save ending time
    append_db(
      id: activity[0],
      type: "stop",
      timestamp: Time.now,
      name: activity[3]
    )
  end

  def append_active(args)
    CSV.open(ACTIVE_PATH, "a") do |csv|
      csv << [
        args[:id],
        args[:type],
        args[:timestamp],
        args[:name]
      ]
    end
  end

  def append_db(args)
    CSV.open(DB_PATH, "a") do |csv|
      csv << [
        args[:id],
        args[:type],
        args[:timestamp],
        args[:name]
      ]
    end
  end

  def parse_timestamp(timestamp)
    DateTime.parse(timestamp).strftime("%Y-%m-%d at %H:%M:%S")
  end

  def csv_as_string
    CSV.read(ACTIVE_PATH).map(&:to_csv).join
  end
end
