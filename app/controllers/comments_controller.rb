# frozen_string_literal: true

class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      flash[:notice] = 'Comment posted'
      redirect_back(fallback_location: root_path)
    else
      flash[:danger] = "Already commented #{@comment.movie.title} movie, please delete existing comment first."
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    return handle_not_owned_comment if @comment.user != current_user

    if @comment.destroy
      flash[:notice] = 'Comment destroyed'
      redirect_back(fallback_location: root_path)
    else
      flash[:danger] = "Couldn't destroy the comment"
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def handle_not_owned_comment
    flash[:danger] = "Couldn't destroy another's user comment"
    redirect_back(fallback_location: root_path)
  end

  def comment_params
    params.require(:comment).permit(:movie_id, :user_id, :text)
  end
end
