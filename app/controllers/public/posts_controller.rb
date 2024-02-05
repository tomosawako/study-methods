class Public::PostsController < ApplicationController
  before_action :authenticate_enduser!

  def index
    @categories = Category.all
    if params[:keyword].present?
      @posts = Post.where("field LIKE?", "%#{params[:keyword]}%").
        or(Post.where("reference_book LIKE?", "%#{params[:keyword]}%")).
          or(Post.where("study_method LIKE?", "%#{params[:keyword]}%")).
            or(Post.where("achievement LIKE?", "%#{params[:keyword]}%")).page(params[:page]).order(created_at: :desc)
      @keyword = params[:keyword]
    elsif params[:category_id].present?
      @category_id = params[:category_id]
      @posts = Post.where(category_id: @category_id).page(params[:page]).order(created_at: :desc)
      @category = Category.find(params[:category_id])
    else
      @posts = Post.page(params[:page]).order(created_at: :desc)
    end
  end

  def new
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(post_params)
    @post.enduser_id = current_enduser.id
    if @post.save
      redirect_to post_path(@post.id)
    else
      render :new
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post.id)
    else
      render :edit
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path
  end

  def favorites
    @categories = Category.all
    @enduser = Enduser.find(params[:enduser_id])
    @favorites_posts = current_enduser.favorite_posts.includes(:enduser).page(params[:page])
  end

  private

  def post_params
    params.require(:post).permit(:image, :category_id, :field, :reference_book, :study_method, :total_study_time, :achievement)
  end
end
