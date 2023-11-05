class AchievementsPresenter
  ICONS_FOR_COUNTED_ACHIEVEMENTS = YAML.load_file('lib/counted_achievements.yml').symbolize_keys
  COUNTED_ACHIEVEMENTS = [5, 10, 25, 50, 100]

  def initialize(params)
    @params = params
  end

  def generate_presentation
    all_achievements = collect_all_achievements
    completed_courses_count = calculate_completed_courses(all_achievements)
    all_achievements + counted_achievements(completed_courses_count)
  end

  private

  def collect_all_achievements
    TrainualAchievements.new(@params).collect + ExternalAchievements.new(@params).collect
  end

  def calculate_completed_courses(all_achievements)
    all_achievements.count { |achievement| achievement[:completion_percentage].to_i >= 100 }
  end

  def counted_achievements(count)
    achievement_counters = prepare_achievement_counters(count)
    uniq_random_ids = RandomIdsGenerator.generate_uniq(1001, 2000, achievement_counters.size)
    prepare_counted_achievements_data(achievement_counters, uniq_random_ids)
  end

  def prepare_achievement_counters(count)
    COUNTED_ACHIEVEMENTS.select { |achievement_count| achievement_count <= count }
  end

  def prepare_counted_achievements_data(achievement_counters, uniq_random_ids)
    achievement_counters.filter_map do |achievement_counter|
      icon = ICONS_FOR_COUNTED_ACHIEVEMENTS["icon_#{achievement_counter}".to_sym]
      next if icon.blank?
      {
        title: "Completed #{achievement_counter} courses",
        icon: icon,
        id: uniq_random_ids.shift,
        completion_percentage: 100
      }
    end
  end
end
