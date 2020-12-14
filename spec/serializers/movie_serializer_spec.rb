# frozen_string_literal: true

require 'rails_helper'

describe MovieSerializer do
  let(:movie) { FactoryBot.build(:movie) }
  subject { described_class.new(movie) }

  it 'serializes movie correctly' do
    expect(subject.serializable_hash).to(
      match(
        a_hash_including(
          id: movie.id,
          title: movie.title
        )
      )
    )
  end
end
