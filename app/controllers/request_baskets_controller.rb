class RequestBasketsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @user = current_user
    params[:c_false] = params[:c_true] = true if params[:c_false].nil? && params[:c_true].nil?
    completed = params[:c_true]
    active = params[:c_false]


    country_id = params[:country_id]
    user = current_user

    completed = if active && !completed
      false
    elsif !active && completed
      true
    else
      nil
    end
    @search = RequestBasket.search :page => (params[:page] || 1) do
      filter(:term, :country_id => country_id) if country_id.present?
      filter(:term, :completed => completed) unless completed.nil?
      filter(:term, :requester_id => user.id)
      sort { by :created_at, 'desc' }
    end
  end

  def edit
    @request = current_user.request_baskets.find(params[:id])
  end

  def new
    @request = current_user.request_baskets.build(:country_id => 1)
    @request.requests.build
  end

  def show
    @request = RequestBasket.find(params[:id])
    if @request.requester_id == current_user.id
      render 'owned_show'
    else
      @message = current_user.sent_messages.build(
        :receiver_id => @request.requester_id,
        :title => "Message about request: #{request_basket_url(@request)}",
        :text => "I am interested in fulfilling request #{request_basket_url(@request)}"
      )
      @bid = current_user.bids.build(:request_basket_id => @request.id, :amount => @request.price)
    end
  end

  def search
    search_requests
    @shoppings = @search.results
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

  private

  def search_requests
    params[:price_range] = '0,1000' unless params[:price_range].present?
    price_from, price_to = params[:price_range].split(",")
    country_id = params[:country_id]
    q = params[:q].strip if params[:q]

    @search = RequestBasket.search :page => (params[:page] || 1) do
      query { string q } if q.present?
      filter(:term, :country_id => country_id) if country_id.present?
      filter(:term, :completed => false)
      filter(:range, :price => { from: price_from, to: price_to } ) if price_from.present? && price_to.present?
      sort { by :created_at, 'desc' }
    end
  end
end
