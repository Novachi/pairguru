require "rails_helper"

describe "Comment requests", type: :request do
  let!(:comment) { FactoryBot.create(:comment) }
  let!(:user) { FactoryBot.create(:user) }

  describe "#create" do
    let(:movie) { FactoryBot.create(:movie) }
    context 'with valid params' do
      let(:params) do
        {
          comment: {
            movie_id: movie.id,
            user_id: user.id,
            text: 'comment text'
          }
        }
      end

      it 'creates new comment' do
        expect { post('/comments', params: params) }.to change { Comment.count }.by(1)
      end
    end

    context 'with invalid params' do
      let(:params) do
        {
          comment: {
            movie_id: comment.movie.id,
            user_id: comment.user.id,
            text: 'comment text'
          }
        }
      end

      it 'does not create new comment' do
        expect { post('/comments', params: params) }.not_to change { Comment.count }
      end
    end
  end

  describe '#destroy' do
    context 'when logged in as a comment owner' do
      before do
        sign_in comment.user
      end

      it 'deletes the comment' do
        expect { delete("/comments/#{comment.id}") }.to change { Comment.count }.by(-1)
      end
    end

    context 'when logged in not as comment owner' do
      before do
        sign_in user
      end

      it 'does not delete the comment' do
        expect { delete("/comments/#{comment.id}") }.not_to change { Comment.count }
      end
    end
  end
end
