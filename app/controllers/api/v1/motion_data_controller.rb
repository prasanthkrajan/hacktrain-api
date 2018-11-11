class Api::V1::MotionDataController < ApplicationController 
  require "json"

  before_action :retrieve_analysis_object

  def retrieve
    puts @analysis
    decision = @analysis.predict(params[:coordinate].to_f)
    render json: {decision: decision}
  end

  private

  def retrieve_analysis_object
    @analysis = Rails.cache.read 'analysis_object'
    if @analysis.nil?
      @analysis = DataAnalysis.instance
      @analysis.train
      puts "Training Data"
      Rails.cache.write 'analysis_object', @analysis
    end
  end
end