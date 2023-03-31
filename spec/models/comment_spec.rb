require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'assocations' do
    author = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.',
                         posts_counter: 5)
    post = Post.create(author_id: author.id, Title: 'Hello', Text: 'This is my first post', likes_counter: 5,
                       comments_counter: 5)
    subject { Comment.new(author_id: author.id, post_id: post.id, Text: 'Hi Tom!') }

    before { subject.save }

    it 'author id should be integer' do
      subject.author_id = 'string'
      expect(subject).to_not be_valid
    end

    it 'post id should be an integer' do
      subject.post_id = 'string'
      expect(subject).to_not be_valid
    end

    it 'increments comments_counter' do
      expect(post.comments_counter).to eq(5)
    end
  end
end
