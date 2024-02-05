class Public::EndusersController < ApplicationController
  before_action :authenticate_enduser!

  def show
    @enduser = Enduser.find(params[:id])
    @posts = @enduser.posts.page(params[:page]).order(created_at: :desc)
  end

  def edit
    @enduser = Enduser.find(params[:id])
  end

  def update
    @enduser = Enduser.find(params[:id])
    @enduser.update(enduser_params)
    redirect_to enduser_path(@enduser.id)
  end

  private

  def enduser_params
    params.require(:enduser).permit(:name, :email, :profile_image)
  end
end
