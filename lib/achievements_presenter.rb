class AchievementsPresenter
  def initialize(params)
    @params = params
  end

  def collect_all
    TrainualAchievements.new(@params).collect + ExternalAchievements.new(@params).collect
  end
end
