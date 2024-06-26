class VideoStruct
  attr_accessor :url, :title, :id

  def initialize(url:, title:, id:)
    @url = url
    @title = title
    @id = id
  end
end