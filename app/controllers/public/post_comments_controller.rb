class Public::PostCommentsController < ApplicationController
  before_action :authenticate_enduser!

  def create
    post = Post.find(params[:post_id])
    comment = current_enduser.post_comments.new(post_comments_params)
    comment.post_id = post.id
    comment.save
    redirect_to post_path(post)
  end

  private

  def post_comments_params
    params.require(:post).permit(:comment)
  end

end
