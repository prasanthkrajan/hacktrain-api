require 'csv'
class CsvReaderService

  attr_accessor :file_path

  class << self
    def call!(file_path)
      new(file_path).call!
    end
  end

  def initialize(file_path)
    @file_path = file_path
  end

  def call!
    arr = []
    csv_text = File.read(file_path).scrub
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      arr << sanitize_data(row.to_hash.values)
    end
    arr
  end

  private

  def sanitize_data(array)
    [array[2..4],array.last]
  end
end