class Public::PostsController < ApplicationController
  before_action :authenticate_enduser!

  def index
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.enduser_id = current_enduser.id
    @post.save
    redirect_to post_path(@post.id)
  end

  private

  def post_params
    params.require(:post).permit(:image, :category_id, :field, :references, :study_method, :total_study_time, :achievement)
  end
end
