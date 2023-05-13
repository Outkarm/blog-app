class CommentsController < ApplicationController
  before_action :set_post, only: [:create]

  def create
    @comments = Comment.new(comment_params)
    @comments.post = @posts
    @comments.author = current_user
    if @comments.save
      flash[:notice] = 'Comment created successfully'
      redirect_to user_post_path(@posts.author, @posts)
    else
      flash[:alert] = 'Something went wrong Comment was not created.'
      render :new, status: :unprocessable_entity
    end
  end

  def new
    @comments = Comment.new
    @current_user = current_user
  end

  private

  def set_post
    @posts = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end
