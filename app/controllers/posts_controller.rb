class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = Post.where(author_id: @user.id).order(created_at: :desc)
  end

  def show
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
    @comments = @post.comments.order(created_at: :desc)
    @like = Like.new
  end

  def new
    @user = current_user(params[:user_id])
    @post = Post.new
  end

  def create
    @user = current_user(params[:user_id])
    @post = @user.posts.new(author: @user, Title: params[:post][:Title], Text: params[:post][:Text])
    if @post.save
      redirect_to user_post_path(@user, @post), notice: 'Post created!'
    else
      render :new
      flash.alert = 'sorry, something went wrong!'
    end
  end

  private

  def post_params
    params.require(:post).permit(:Title, :Text)
  end
end
