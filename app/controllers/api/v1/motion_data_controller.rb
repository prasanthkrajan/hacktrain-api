class Api::V1::MotionDataController < ApplicationController 
  require 'knn'

  def retrieve
    result = classifier.classify(new_datapoint)
    render json: {result: result}
  end

  private

  def vectors
    arr = []
    list_of_files.each do |file|
      arr << CsvReaderService.call!("./data/#{file}")
    end
    arr.flatten(1)
  end

  def list_of_files
    Dir.entries("./data").select {|f| !File.directory? f}
  end

  def classifier
    Knn::Classifier.new(vectors, 3)
  end

  def sanitized_params
    [params[:x].to_f,params[:y].to_f,params[:z].to_f]
  end

  def new_datapoint
    Knn::Vector.new(sanitized_params, nil)
  end
end