class ShoppingsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @user = current_user
    @in_progress_shoppings = @user.in_progress_shopping.limit(4).order('created_at DESC')
    @completed_shoppings = @user.completed_shopping.limit(4).order('created_at DESC')
  end

  def show
    @shopping = Request.find(params[:id])
    if @shopping.shopper_id == current_user.id
      render 'owned_show'
    else
      render 'other_show'
    end
  end

  def search
    search_requests
  end

  def completed
    @title = 'Completed'
    @shoppings = current_user.completed_shopping.order('created_at DESC').page params[:page]
    render 'list'
  end

  def in_progress
    @title = 'In Progress'
    @shoppings = current_user.in_progress_shopping.order('created_at DESC').page params[:page]
    render 'list'
  end


  private

  def search_requests
    country_id = params[:country_id]
    q = params[:q].strip if params[:q]
    per_page = (params[:per_page] || 10).to_i
    page = (params[:page] || 1).to_i

    @search = Request.search do
      query { string q } if q.present?
      from (page - 1) * per_page
      size per_page
      filter(:terms, :country_id => country_id.to_i) if country_id.present?
    end
  end
end