class Admin::EndusersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @endusers = Enduser.all
  end

  def show
    @enduser = Enduser.find(params[:id])
    @posts = @enduser.posts.page(params[:page])
  end

  def edit
    @enduser = Enduser.find(params[:id])
  end

  def update
    enduser = Enduser.find(params[:id])
    enduser.update(enduser_params)
    redirect_to admin_enduser_path(enduser)
  end

  private

  def enduser_params
    params.require(:enduser).permit(:name, :email, :profile_image, :is_active)
  end

end
