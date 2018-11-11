class Api::V1::MotionDataController < ApplicationController 
  require 'knn'

  def retrieve
    result = classifier.classify(new_datapoint)
    render json: {result: result}
  end

  private

  def vectors
    vectors = Rails.cache.read 'knn_vectors'
    if vectors.nil?
      arr = []
      list_of_files.each do |file|
        file_data = Rails.cache.read "#{file}_data"
        if file_data.present?
          arr << file_data
        else
          data = CsvReaderService.call!("./data/#{file}")
          Rails.cache.write "#{file}_data", data
          arr << data
        end
      end
      Rails.cache.write 'knn_vectors', arr.flatten(1)
      arr.flatten(1)
    else 
      vectors
    end
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