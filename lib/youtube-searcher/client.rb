require "singleton"
require "google/api_client"

module YoutubeSearcher
  class Client
    include Singleton

    APPLICATION_NAME = "Youtube Searcher"
    YOUTUBE_API_SERVICE_NAME = "youtube"
    YOUTUBE_API_VERSION = "v3"

    def search(query, max_results: 20)
      parameters = Hash.new
      parameters[:part] = "id,snippet"
      parameters[:type] = "video"
      parameters[:maxResults] = max_results
      parameters[:q] = query

      response = client.execute!(
        api_method: youtube.search.list,
        parameters: parameters
      )

      videos = Array.new

      response.data.items.each do |result|
        video = Hash.new
        video[:title] = result.snippet.title
        video[:url]   = "http://www.youtube.com/watch?v=#{result.id.videoId}"

        videos << video
      end

      videos
    end

    def client
      @client ||= Google::APIClient.new(key: api_key, authorization: nil, application_name: APPLICATION_NAME, application_version: YoutubeSearcher::VERSION)
    end

    def youtube
      @youtube ||= @client.discovered_api(YOUTUBE_API_SERVICE_NAME, YOUTUBE_API_VERSION)
    end

    private

    def api_key
      @api_key ||= File.read(File.join(File.expand_path(__dir__), "..", "..", "api_key"))
    end
  end
end
