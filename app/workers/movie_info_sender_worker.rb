# frozen_string_literal: true

class MovieInfoSenderWorker
  include Sidekiq::Worker

  def perform(movie_id, user_id)
    MovieInfoMailer.send_info(user(user_id), movie(movie_id)).deliver_now
  end

  private

  def user(user_id)
    User.find(user_id)
  end

  def movie(movie_id)
    Movie.find(movie_id)
  end
end
