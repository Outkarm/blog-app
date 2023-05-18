class PostsController < ApplicationController
  def index
    @users = User.find(params[:user_id])
    @posts = Post.includes(:user, :comments).all
  end

  def show
    @users = User.find(params[:user_id])
    @posts = Post.find(params[:id])
    @comments = Comment.includes(:author).where(post_id: params[:id]).order(created_at: :desc).limit(5)
  end

  def new
    @posts = Post.new
    @current_user = current_user
  end

  def create
    @posts = Post.new(post_params)
    @posts.author = current_user
    @posts.likes_counter = 0
    @posts.comments_counter = 0
    if @posts.save
      flash[:notice] = 'Post created successfully'
      redirect_to user_posts_path(current_user)
    else
      flash[:alert] = 'Post creation failed'
      render :new, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
