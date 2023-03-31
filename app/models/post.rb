class Post < ApplicationRecord
  has_many :comments, foreign_key: 'post_id'
  has_many :likes, foreign_key: 'post_id'
  belongs_to :author, class_name: 'User'

  after_save :posts_counter_update

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end

  private

  def posts_counter_update
    author.update(posts_counter: author.posts.count)
  end
end
