class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    # @user = User.find(params[:id])
    # @posts = Post.where(author_id: @user.id)
    @posts = Post.where(author_id: @user.id).order(created_at: :desc)
  end

  def show
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
    @comments = @post.comments.order(created_at: :desc)
  end
end
