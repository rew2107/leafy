class RequestsController < ApplicationController

  def index
    @user = current_user
    @requests = @user.requests.limit(6).order('created_at DESC')
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

  def create
    @request = current_user.requests.build(params[:request])
    if @request.save
      flash[:notice] = 'Your request has been posted!'
      redirect_to :action => :index
    else
      render 'new'
    end
  end

end
