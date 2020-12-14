require "rails_helper"

describe "Movies api requests", type: :request do
  let(:movie) { FactoryBot.create(:movie) }
  let(:parsed_response) { JSON.parse(response.body) }

  describe "#show" do
    it "returns correctly serialized movie" do
      get("/api/movies/#{movie.id}")
      expect(parsed_response).to(
        match(
          a_hash_including(
            'id' => movie.id,
            'title' => movie.title,
            'genre' => {
              'id' => movie.genre.id,
              'name' => movie.genre.name,
              'movie_count' => movie.genre.movie_count
            }
          )
        )
      )
    end
  end
end