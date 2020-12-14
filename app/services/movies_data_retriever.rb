# frozen_string_literal: true

require 'net/http'
require 'dry-initializer'

class MoviesDataRetriever
  extend Dry::Initializer

  option :title

  def call
    movie_data
  end

  private

  def movie_data
    url = URI.parse("http://pairguru-api.herokuapp.com/api/v1/movies/#{URI.encode(title)}")
    request = Net::HTTP::Get.new(url.to_s)
    response = Net::HTTP.start(url.host, url.port) { |http| http.request(request) }
    JSON.parse(response.body)
  end
end
