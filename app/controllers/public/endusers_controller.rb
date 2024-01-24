class Public::EndusersController < ApplicationController
  before_action :authenticate_enduser!

  def show
    @enduser = Enduser.find(params[:id])
    @posts = @enduser.posts
  end

  def edit
    @enduser = Enduser.find(params[:id])
  end
end
