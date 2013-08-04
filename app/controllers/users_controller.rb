class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
    @user = current_user
    gon.user_rating = @user.rating || 0
  end

  def show
    @user = User.find(params[:id])
    gon.user_rating = @user.rating || 0
    render :index if @user.id == current_user.id
  end
end
