class RandomIdsGenerator
  class << self
    def generate_uniq(first_id, last_id, count)
      unique_random_ids = []
      while unique_random_ids.length < count
        random_id = rand(first_id..last_id)
        unique_random_ids.push(random_id) if unique_random_ids.exclude?(random_id)
      end
      unique_random_ids
    end
  end
end