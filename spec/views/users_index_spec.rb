require 'rails_helper'

RSpec.describe 'Users', type: :system do
  describe 'User index page' do
    before(:each) do
      @user = User.create(name: 'John Doe',
                          photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                          bio: 'I am a Full Stack Developer',
                          posts_counter: 0)

      visit users_path
    end

    it 'displays the user name of all other users' do
      expect(page).to have_content(@user.name)
    end

    it 'displays the user photo of all other users' do
      expect(page.body).to include(@user.photo)
    end

    it 'displays the number of posts each user has written' do
      expect(page).to have_content(@user.posts_counter)
    end

    it "When I click on a user, I am redirected to that user's show page" do
      click_link(@user.name)
      expect(page).to have_current_path(user_path(@user))
    end
  end
end
