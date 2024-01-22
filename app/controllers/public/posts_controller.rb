class Public::PostsController < ApplicationController
  def index
  end

  def show
  end

  def edit
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.end_user_id = current_enduser.id
    @post.save
    redirect_to post_path(@post.id)
  end

  private

  def post_params
    params.require(:post).permit(:category, :field, :references, :study_method, :total_study_time, :achienvement)
  end
end
