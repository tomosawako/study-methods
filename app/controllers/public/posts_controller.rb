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
end
