class ShopperApplicationsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @shopper_application = current_user.build_shopper_application
  end

  def create
    @shopper_application = current_user.build_shopper_application(params[:shopper_application])
    unless @shopper_application.save
      flash[:error] = 'Application not sent'
    else
      flash[:success] = 'Application sent'
    end
    render :index
  end
end
