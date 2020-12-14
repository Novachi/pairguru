class MovieDecorator < Draper::Decorator
  delegate_all

  def cover
    "http://pairguru-api.herokuapp.com#{movie_full_data['data']['attributes']['poster']}"
  end

  def description
    movie_full_data['data']['attributes']['plot']
  end

  def rating
    movie_full_data['data']['attributes']['rating']
  end

  private

  def movie_full_data
    @movie_full_data ||= MoviesDataRetriever.new(title: title).call
  end
end
