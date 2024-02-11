# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  before_action :enduser_state, only: [:create]
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  def after_sign_in_path_for(resource)
    posts_path
  end

  def guest_sign_in
    enduser = Enduser.guest
    sign_in enduser
    redirect_to posts_path, notice: 'ゲストユーザーとしてログインしました。'
  end

  private

  # エンドユーザーがアクティブであるかを判断するメソッド
  def enduser_state
    enduser = Enduser.find_by(email: params[:enduser][:email])
    return if enduser.nil?
    return unless enduser.valid_password?(params[:enduser][:password])
    return if enduser.is_active == true
    if enduser.is_active == false
      redirect_to new_enduser_registration_path
    end
  end
end
