class Initializer
  def self.init
    system("mkdir", "-p", DB::DIR_PATH) unless Dir.exist?(DB::DIR_PATH)
    DB.new.reset
  end
end
