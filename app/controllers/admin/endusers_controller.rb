class Admin::EndusersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @endusers = Enduser.all
  end

  def show
  end

  def edit
  end
end
