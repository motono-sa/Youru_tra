class YoutubeService
  include HTTParty
  base_uri 'https://www.googleapis.com/youtube/v3'

  def initialize
    @api_key = ENV['YOUTUBE_API_KEY']
    @keywords = ["exercise", "fitness", "training", "bodybuilding"]
    @ng_keywords = ["バストアップ", "女性"]
  end

  def search_random_video(training_part_name)
    query = generate_random_query(training_part_name)
    options = {
      query: {
        part: 'snippet',
        q: query,
        type: 'video',
        maxResults: 1,
        regionCode: 'JP',
        relevanceLanguage: 'ja',
        videoDuration: 'medium', 
        key: @api_key
      }
    }
    response = self.class.get('/search', options)
    response['items'].first 
  end

  private

  def generate_random_query(training_part_name)
    "#{training_part_name} #{keywords.sample} workout 自重 -#{ng_keywords.join(" -")}"
  end

  attr_reader :keywords, :ng_keywords
end