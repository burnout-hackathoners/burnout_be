class TrainualAchievements
  WEB_LINK_GENERATE_URL = 'https://api.trainual-stg.com/backend/v1/web-links/generate'
  DEFAULT_USER_ID = 205964
  TOKEN = "Token token=EKWqV9gbXGfJJTTgs4q0r_YPWI4iJsztcTqgSRM_pGnWC-ybf_LabwIpjRjlAzcpwK33Ma2tnDfhx24pyiukMQ , email=domingodnls@gmail.com"
  HEADERS = { "accept" => "application/json", "authorization" => TOKEN }

  def initialize(params)
    @params = params
  end

  def collect
    response_body = Faraday.get(proxy_url).body
    assigned_curriculums = JSON.parse(response_body).deep_symbolize_keys
    assigned_curriculums = assigned_curriculums[:data].to_a.select { |curriculum| curriculum[:published] }
    assigned_curriculums.map { |curriculum| curriculum.slice(:id, :title, :published, :completion_percentage) }
  end

  private

  def proxy_url
    url = "#{WEB_LINK_GENERATE_URL}?link=#{target_url}"
    connection = Faraday.new(url: url)
    response = connection.get { |req| req.headers = HEADERS }
    JSON.parse(response.body).fetch('web_link', '')
  end

  def target_url
    user_id = @params[:user_id] || DEFAULT_USER_ID
    "https%3A%2F%2Fapp.trainual-stg.com%2F2bf1edeb-fad6-43de-977c-85ac6142eaef%2Fajax%2Fusers%2F#{user_id}%2Ffetch_assigned_curriculums"
  end
end