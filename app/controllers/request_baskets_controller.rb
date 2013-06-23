class RequestBasketsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @user = current_user
    @in_progress_requests = @user.in_progress_request_baskets.limit(4).order('created_at DESC')
    @active_requests = @user.active_request_baskets.limit(4).order('created_at DESC')
    @completed_requests = @user.completed_request_baskets.limit(4).order('created_at DESC')
  end

  def edit
    @request = current_user.request_baskets.find(params[:id])
  end

  def new
    @request = current_user.request_baskets.build(:country_id => 1)
    @request.requests.build
  end

  def show
    @request = current_user.request_baskets.find(params[:id])
  end

  def active
    @title = 'Active'
    @requests = current_user.active_request_baskets.order('created_at DESC').page params[:page]
    render 'list'
  end

  def completed
    @title = 'Completed'
    @requests = current_user.completed_request_baskets.order('created_at DESC').page params[:page]
    render 'list'
  end

  def in_progress
    @title = 'In Progress'
    @requests = current_user.in_progress_request_baskets.order('created_at DESC').page params[:page]
    render 'list'
  end

  def create
    @request = current_user.request_baskets.build(params[:request_basket])
    if @request.save
      flash[:notice] = 'Your request has been posted!'
      redirect_to :action => :index
    else
      puts @request.inspect
      render 'new'
    end
  end

end
