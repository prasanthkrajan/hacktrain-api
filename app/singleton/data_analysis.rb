require 'singleton'

class DataAnalysis
  include Singleton

  def initialize
    @caller = DecisionTree::ID3Tree.new(labels, training_data, "Train",  :continuous)
  end

  def train
    @caller.train
  end

  def predict(test_data)
    @caller.predict(test_data)
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