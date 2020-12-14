# frozen_string_literal: true

require 'rails_helper'

describe GenreSerializer do
  let(:genre) { FactoryBot.build(:genre) }
  subject { described_class.new(genre) }

  it 'serializes movie correctly' do
    expect(subject.serializable_hash).to(
      match(
        a_hash_including(
          id: genre.id,
          name: genre.name,
          movie_count: genre.movie_count
        )
      )
    )
  end
end
