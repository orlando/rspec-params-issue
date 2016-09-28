class QuestionsController < ApplicationController
  def create
    p params
    render json: params.to_unsafe_h
  end
end
