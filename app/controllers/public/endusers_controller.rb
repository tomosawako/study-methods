class Public::EndusersController < ApplicationController
  before_action :authenticate_enduser!
  before_action :ensure_normal_enduser, only: :update
  before_action :is_matching_login_user, only: [:edit, :update]

  def ensure_normal_enduser
    enduser = Enduser.find(params[:id])
    if enduser.email == 'guest@example.com'
      redirect_to enduser_path(enduser.id), alert: 'ゲストユーザーの更新はできません。'
    end
  end

  def show
    @enduser = Enduser.find(params[:id])
    @posts = @enduser.posts.page(params[:page]).order(created_at: :desc)
  end

  def edit
    @enduser = Enduser.find(params[:id])
  end

  def update
    @enduser = Enduser.find(params[:id])
    if @enduser.update(enduser_params)
      redirect_to enduser_path(@enduser)
    else
      render :edit
    end
  end

  private

  def enduser_params
    params.require(:enduser).permit(:name, :email, :profile_image)
  end

  def is_matching_login_user
    enduser = Enduser.find(params[:id])
    unless enduser.id == current_enduser.id
      redirect_to posts_path
    end
  end
end
