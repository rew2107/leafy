class BidsController < ApplicationController
  before_filter :authenticate_user!


  def create
    @bid = current_user.bids.build(params[:bid])
    unless @bid.save
      flash[:error] = 'bid not sent'
    else
      flash[:success] = 'bid sent'
    end
    redirect_to root_path
  end
end
