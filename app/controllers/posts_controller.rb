class PostsController < ApplicationController
  def index
    @users = User.find(params[:user_id])
    @posts = Post.all
  end

  def show
    @users = User.find(params[:user_id])
    @posts = Post.find(params[:id])
  end
end
