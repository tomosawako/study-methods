class Public::PostCommentsController < ApplicationController
  before_action :authenticate_enduser!

  def create
    post = Post.find(params[:post_id])
    comment = PostComment.new(post_comment_params)
    comment.enduser_id = current_enduser.id
    comment.post_id = post.id
    comment.save
    redirect_to post_path(post)
  end

  def destroy
    comment = PostComment.find(params[:id])
    comment.destroy
    redirect_to post_path(comment.post_id)
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

end
