require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'validations' do
    let!(:comment) { FactoryBot.create(:comment) }

    it 'has a valid factory' do
      expect(comment).to be_valid
    end

    context 'when user already has one comment associated with a movie' do
      let(:comment2) do
        FactoryBot.build(:comment, text: 'some other comment', movie: comment.movie, user: comment.user)
      end

      it 'is not valid' do
        expect(comment2).not_to be_valid
      end
    end
  end
end
