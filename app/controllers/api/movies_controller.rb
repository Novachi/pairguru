# frozen_string_literal: true

module Api
  class MoviesController < ApplicationController
    def index
      @movies = Movie.includes(:genre).all
      render json: @movies, each_serializer: MovieSerializer
    end

    def show
      @movie = Movie.find(params[:id])
      render json: @movie, serializer: MovieSerializer
    end
  end
end
