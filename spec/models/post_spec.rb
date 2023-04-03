require 'rails_helper'

RSpec.describe Post, type: :model do
  subject { Post.new(Title: 'Post 1', Text: 'Text 1', comments_counter: 10, author_id: 1, likes_counter: 10) }
  before { subject.save }

  it 'title should be present' do
    subject.Title = nil
    expect(subject).to_not be_valid
  end

  it 'title should be less than 250 characters' do
    subject.Title = 'a' * 251
    expect(subject).to_not be_valid
  end

  it 'comments_counter should be an integer' do
    subject.comments_counter = 'string'
    expect(subject).to_not be_valid
  end

  it 'comments_counter should be greater than or equal to 0' do
    subject.comments_counter = -1
    expect(subject).to_not be_valid
  end

  it 'likes_counter should be an integer' do
    subject.likes_counter = 'string'
    expect(subject).to_not be_valid
  end

  it 'likes_counter should be greater than or equal to 0' do
    subject.likes_counter = -1
    expect(subject).to_not be_valid
  end

  describe '#recent_comments' do
    before do
      10.times do |c|
        Comment.create(Text: "Comment #{c}", post_id: subject.id, author_id: 1)
      end
    end
  end

  it 'should return the 5 most recent comments' do
    expect(subject.recent_comments).to eq(subject.comments.order(created_at: :desc).limit(5))
  end
end

RSpec.describe Post, type: :model do
  let(:user) { User.create(name: 'Jane', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'teacher', posts_counter: 0) }

  it "updates the author's posts counter after saving a new post" do
    expect do
      Post.create(Title: 'Test Post', Text: 'my post', comments_counter: 0, likes_counter: 0, author_id: user.id)
    end.to(change { user.reload.posts_counter }.from(0).to(1))
  end

  it "updates the author's posts counter after updating an existing post" do
    post = Post.create(Title: 'Test Post', Text: 'Lorem ipsum', comments_counter: 0, likes_counter: 0,
                       author_id: user.id)
    expect do
      post.update(Title: 'Updated Post')
    end.to_not(change { user.reload.posts_counter })
  end
end
