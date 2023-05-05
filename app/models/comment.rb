class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  after_save :post_comment_counter

  private

  def post_comment_counter
    post.update(comments_counter: post.comments.count)
  end
end
