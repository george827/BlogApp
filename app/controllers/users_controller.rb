class UsersController < ApplicationController
  def index
    # @users = User.all
    @users = User.all.order(created_at: :asc).includes(:posts)
  end

  def show
    # @user = User.find(params[:id])
    @user = User.includes(posts: %i[likes comments]).find(params[:id])
    @posts = @user.recent_posts
  end
end
