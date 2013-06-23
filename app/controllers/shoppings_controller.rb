class ShoppingsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @user = current_user
    @in_progress_shoppings = @user.in_progress_shopping_baskets.limit(4).order('created_at DESC')
    @completed_shoppings = @user.completed_shopping_baskets.limit(4).order('created_at DESC')
  end

  def show
    @shopping = RequestBasket.find(params[:id])
    if @shopping.shopper_id == current_user.id
      render 'owned_show'
    else
      render 'other_show'
    end
  end

  def search
    search_requests
    @shoppings = @search.results
  end

  def completed
    @title = 'Completed'
    @shoppings = current_user.completed_shopping_baskets.order('created_at DESC').page params[:page]
    render 'list'
  end

  def in_progress
    @title = 'In Progress'
    @shoppings = current_user.in_progress_shopping_baskets.order('created_at DESC').page params[:page]
    render 'list'
  end


  private

  def search_requests
    country_id = params[:country_id]
    q = params[:q].strip if params[:q]

    @search = RequestBasket.search :page => (params[:page] || 1) do
      query { string q } if q.present?
      filter(:terms, :country_id => [country_id]) if country_id.present?
      filter(:terms, :status => [RequestBasket::ACTIVE])
    end
  end
end
