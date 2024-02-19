class Admin::PostCommentsController < ApplicationController
  before_action :authenticate_admin!

  def destroy
    comment = PostComment.find(params[:id])
    comment.destroy
    redirect_to admin_post_path(comment.post_id)
  end
end
