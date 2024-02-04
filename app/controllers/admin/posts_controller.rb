class Admin::PostsController < ApplicationController
  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    post = Post.find(params[:id])
    psot.update(post_params)
    redirect_to admin_post_path(post)
  end

end
