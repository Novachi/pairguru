# frozen_string_literal: true

class MoviesCsvExportWorker
  include Sidekiq::Worker

  def perform(user_id)
    file_path = "tmp/movies.csv"
    MovieExporter.new.call(user(user_id), file_path)
  end

  private

  def user(current_user_id)
    User.find(current_user_id)
  end
end
