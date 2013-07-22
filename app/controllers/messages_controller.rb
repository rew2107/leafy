class MessagesController < ApplicationController
  before_filter :authenticate_user!

  def create
    @message = current_user.sent_messages.build(params[:message])
    flash[:error] = 'message not sent' unless @message.save
  end
end
