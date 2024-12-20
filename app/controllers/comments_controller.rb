class CommentsController < ApplicationController
  before_action :require_user_logged_in!

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = Current.user

    if @comment.save
      redirect_to @post, notice: 'Comment was successfully added.'
    else
      redirect_to @post, alert: 'Error adding comment.'
    end
  end

  def destroy
    @comment = Current.user.comments.find(params[:id])
    @comment.destroy
    redirect_to @comment.post, notice: 'Comment was successfully deleted.'
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end