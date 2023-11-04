class AchievementsController < ApplicationController
  def index
    render json: { data: AchievementsPresenter.collect_all(params) }
  end
end
