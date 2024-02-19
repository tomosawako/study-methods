class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!

  def top
    #全ての投稿をカウントする用
    @post_all = Post.all
    @posts = Post.page(params[:page]).order(created_at: :desc)
  end
end
