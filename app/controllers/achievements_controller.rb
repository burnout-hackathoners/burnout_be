class AchievementsController < ApplicationController
  def index
    render json: { data: AchievementsPresenter.new(params).generate_presentation }
  end
end
