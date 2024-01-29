class Admin::EndusersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @endusers = Enduser.all
  end

  def show
    @enduser = Enduser.find(params[:id])
    #@posts = @enduser.posts.page(params[:page])
  end

  def edit
    @enduser = Enduser.find(params[:id])
  end
end
