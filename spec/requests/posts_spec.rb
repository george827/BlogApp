require 'rails_helper'

RSpec.describe '/posts', type: :request do
  describe 'Get/index' do
    before(:example) do
      get '/users/1/posts'
    end

    it 'Success response status for index action' do
      expect(response).to be_successful
    end

    it 'render correct template' do
      expect(response).to render_template(:index)
    end

    it 'should render correct body placeholder text' do
      expect(response.body).to include('show user post')
    end
  end

  describe 'Get/show' do
    before(:example) do
      get '/users/1/posts/1'
    end

    it 'Success response status for show action' do
      expect(response).to be_successful
    end

    it 'Render correct templete for show action' do
      expect(response).to render_template(:show)
    end

    it 'Correct body placeholder text for show action' do
      expect(response.body).to include('show all details of post')
    end
  end
end
