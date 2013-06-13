class RequestsController < ApplicationController

  def index
    @user = current_user
    @in_progress_requests = @user.in_progress_requests.limit(4).order('created_at DESC')
    @active_requests = @user.active_requests.limit(4).order('created_at DESC')
    @completed_requests = @user.completed_requests.limit(4).order('created_at DESC')
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

  def active
    @user.active_requests.order('created_at DESC').page params[:page]
  end

  def completed
    @user.completed_requests.order('created_at DESC').page params[:page]
  end

  def in_progress
    @user.in_progress_requests.order('created_at DESC').page params[:page]
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
