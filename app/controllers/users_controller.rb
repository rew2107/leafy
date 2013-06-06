class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
    @user = current_user
    gon.user_rating = @user.rating || 0
  end

  def show
    @user = User.find(params[:id])
  end
end
