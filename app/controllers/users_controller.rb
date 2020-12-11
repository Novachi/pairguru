# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_top_commenting_users, only: :top_commenters

  def top_commenters; end

  private

  def set_top_commenting_users
    @users = TopCommentersQuery.new.call
  end
end
