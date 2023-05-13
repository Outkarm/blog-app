class LikesController < ApplicationController
  def create
    @likes = Like.new
    @posts = Post.find(params[:post_id])
    @users = User.find(params[:user_id])
    @likes.post = @posts
    @likes.author = current_user
    if @likes.save
      flash[:notice] = 'Like was successfully created.'
      redirect_to user_post_path(@users, @posts)
    else
      flash[:alert] = 'Like was not created.'
      render :new, status: :unprocessable_entity
    end
  end
end
