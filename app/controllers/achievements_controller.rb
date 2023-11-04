class AchievementsController < ApplicationController
  def index
    render json: { data: AchievementsPresenter.new(params).collect_all }
  end
end
