# frozen_string_literal: true

class MovieSerializer < ActiveModel::Serializer
  attributes :id, :title
  belongs_to :genre, serializer: GenreSerializer
end
