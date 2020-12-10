class MoviesController < ApplicationController
  before_action :authenticate_user!, only: [:send_info]

  def index
    @movies = Movie.all.decorate
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def send_info
    MovieInfoSenderWorker.perform_async(params[:id], current_user.id)
    redirect_back(fallback_location: root_path, notice: "Email sent with movie info")
  end

  def export
    MoviesCsvExportWorker.perform_async(current_user.id)
    redirect_to root_path, notice: "Movies exported"
  end
end
