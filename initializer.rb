class Initializer
  def self.init
    system("mkdir", "-p", DIR_PATH) unless Dir.exist?(DIR_PATH)

    header = %w(id type reference timestamp name)

    CSV.open("#{DIR_PATH}/active.csv", "wb") do |csv|
      csv << header
    end

    CSV.open("#{DIR_PATH}/db.csv", "wb") do |csv|
      csv << header
    end
  end
end
