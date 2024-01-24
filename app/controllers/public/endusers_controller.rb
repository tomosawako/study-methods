class Public::EndusersController < ApplicationController
  before_action :authenticate_enduser!

  def show
    @enduser = Enduser.find(params[:id])
    @posts = @enduser.posts
  end
end
