class Api::V1::MotionDataController < ApplicationController 
  def retrieve
    decision = DataAnalysis.instance.predict(params[:coordinate])
    render json: {decision: decision}
  end
end