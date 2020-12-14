# frozen_string_literal: true

require "rails_helper"

describe MoviesDataRetriever do
  let(:movie) { FactoryBot.create(:movie) }
  let(:stubbed_response_body) do
    "
    {
      \"data\": {
        \"id\": \"#{movie.id}\",
        \"type\": \"movie\",
        \"attributes\": {
          \"title\": \"#{movie.title}\",
          \"plot\": \"Veeeery very good plot.\",
          \"rating\": 9.2,
          \"poster\": \"/movie_poster.jpg\"
        }
      }
    }
    "
  end
  subject { described_class.new(title: movie.title) }
  let(:movie_data) { subject.call['data'] }

  describe "call" do
    before do
      stub_request(:get, "http://pairguru-api.herokuapp.com/api/v1/movies/#{URI.encode(movie.title)}").
        to_return(status: 200, body: stubbed_response_body, headers: {})
    end

    it "returns parsed movie data" do
      expect(movie_data).to(
        match(
          a_hash_including(
            'id' => movie.id.to_s,
            'attributes' => {
              'title' => movie.title,
              'plot' => 'Veeeery very good plot.',
              'rating' => 9.2,
              'poster' => '/movie_poster.jpg'
            }
          )
        )
      )
    end
  end
end