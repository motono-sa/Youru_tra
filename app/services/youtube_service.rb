class YoutubeService
  include HTTParty
  base_uri 'https://www.googleapis.com/youtube/v3'

  def initialize
    @api_key = ENV['YOUTUBE_API_KEY']
  end

  def search_videos(query)
    options = {
      query: {
        part: 'snippet',
        q: query,
        type: 'video',
        maxResults: 1,
        key: @api_key
      }
    }
    self.class.get('/search', options)
  end
end