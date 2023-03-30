class Like < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  after_create :likes_counter_update
  after_destroy :likes_counter_update

  def likes_counter_update
    post.update(likes_counter: post.likes.count)
  end
end