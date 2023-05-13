class CommentsController < ApplicationController
  def new
    @comments = Comment.new
    @posts = Post.find(params[:post_id])
    @users = @posts.author
  end

  def create
    @comments = current_user.comments.new(comment_params)
    @posts = Post.find(params[:post_id])
    @users = User.find(params[:id])
    @comments.post_id = @posts.id

    if @comments.save
      flash[:success] = 'Comment created successfully.'
    else
      flash[:danger] = 'Comment could not be created.'
    end

    redirect_to user_post_path(@users, @posts)
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
