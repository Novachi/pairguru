# frozen_string_literal: true

class TopCommentersQuery
  def call
    User.left_joins(:comments).where('comments.created_at >= :time', time: Time.current - 7.days)
      .select('users.id, email,COUNT(comments.id) as comment_count')
      .order('comment_count DESC')
      .first(10)
  end
end
