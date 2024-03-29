class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!

  def show
    @post = Post.find(params[:id])
  end

  def update
    post = Post.find(params[:id])
    post.update(post_params)
    redirect_to admin_post_path(post)
  end

  private

  def post_params
    params.require(:post).permit(:is_active)
  end

end
