class Public::PostCommentsController < ApplicationController
  before_action :authenticate_enduser!

  def create
    post = Post.find(params[:post_id])
    comment = PostComment.new(post_comment_params)
    comment.enduser_id = current_enduser.id
    comment.post_id = post.id
    comment_reply = post.post_comments.new
    if comment.save
      flash[:notice] = "You have created comment successfully."
      redirect_to post_path(post)
    else
      flash[:alert] = "You have failed to create comment."
      redirect_to post_path(post)
    end
  end

  def destroy
    post = Post.find(params[:post_id])
    comment_reply = post.post_comments.new
    comment = PostComment.find(params[:id])
    comment.destroy
    flash[:notice] = "You have deleted comment successfully."
    redirect_to post_path(comment.post_id)
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment, :parent_id)
  end

end