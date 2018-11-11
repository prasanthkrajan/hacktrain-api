require 'singleton'

class DataAnalysis
  include Singleton

  def initialize
    @caller = DecisionTree::ID3Tree.new(labels, training_data, "Bus",  :continuous)
    @test_array = []
  end

  def train
    @caller.train
  end

  def predict(test_data)
    test_data_in_arr = [test_data]
    @caller.predict(test_data_in_arr)
  end

  def log(time = Time.now)
    @test_array << time
    puts @test_array
  end

  def display_log
    @test_array
  end

  private

  def training_data
    arr = []
    arr << CsvReaderService.call!("./data/#{list_of_files[0]}")
    arr.flatten(1)
  end

  def list_of_files
    Dir.entries("./data").select {|f| !File.directory? f}
  end

  def labels
    ['coordinates']
  end
end