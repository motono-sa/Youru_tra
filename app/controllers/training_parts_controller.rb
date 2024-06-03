class TrainingPartsController < ApplicationController
  def index
    @training_parts = TrainingPart.all
  end
end
