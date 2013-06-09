class RequestsController < ApplicationController

  def index
    @user = current_user
    @requests = @user.requests.limit(6)
    @new_request = @user.requests.build
  end

  def edit
    @request = current_user.requests.find(params[:id])
  end

  def new
    @request = current_user.requests.build(:country_id => 1)
  end

  def show
    @request = Request.find(params[:id])
    if @request.requester_id == current_user.id
      render 'owned_show'
    else
      render 'other_show'
    end
  end

end
