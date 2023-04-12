require 'rails_helper'

RSpec.describe 'Users', type: :system do
  describe 'User show page' do
    before(:each) do
      @user = User.create(name: 'John Doe',
                          photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                          bio: 'I am a Full Stack Developer',
                          posts_counter: 0)

      Post.create(author: @user, Title: 'My first post', Text: 'This is my first post')
      Post.create(author: @user, Title: 'My second post', Text: 'This is my second post')
      Post.create(author: @user, Title: 'My third post', Text: 'This is my third post')
      @last_post = Post.create(author: @user, Title: 'My fourth post', Text: 'This is my fourth post')

      visit user_path(@user.id)
    end

    it "can display the user's profile picture" do
      expect(page.body).to include(@user.photo)
    end

    it 'can display the user name' do
      expect(page).to have_content(@user.name)
    end

    it 'can display the user bio' do
      expect(page).to have_content(@user.bio)
    end

    it 'can display the number of posts the user has written' do
      expect(page).to have_content(@user.posts_counter)
    end

    it "should show the user's first 3 posts" do
      expect(page.body).to have_content('My fourth post')
      expect(page.body).to have_content('My third post')
      expect(page.body).to have_content('My second post')
    end

    it "I can see a button that lets me view all of a user's posts" do
      expect(page).to have_link('See all posts')
    end

    it "When I click a user's post, it redirects me to that post's show page" do
      visit user_posts_path(@user)
      click_link(@last_post.Title)
      expect(current_path).to match user_posts_path(@user)
    end

    it "When I click to see all posts, it redirects me to the user's post's index page" do
      click_link('See all posts')
      expect(page).to have_current_path(user_posts_path(@user))
    end
  end
end
