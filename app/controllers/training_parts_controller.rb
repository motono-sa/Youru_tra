class TrainingPartsController < ApplicationController
  skip_before_action :require_login, only: %i[index]

  def index
    @training_parts = TrainingPart.all
  end
end
