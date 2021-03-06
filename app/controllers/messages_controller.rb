class MessagesController < ApplicationController
  before_filter :authenticate_user!

  def index
    user = current_user
    read = true_false_terms(:c_true,:c_false)
    q = params[:q]

    @search = Message.search :page => (params[:page] || 1) do
      query { string q } if q.present?
      unless read.nil?
        filter(:term, :unread_id => user.id) unless read
        filter(:not, {:term => {:unread_id => user.id}}) if read
      end
      sort { by :created_at, 'desc' }
      filter(:or, [{:term => {:receiver_id => user.id}},{:term => {:sender_id => user.id}}])
    end
  end

  def show
    @message = Message.where("receiver_id = ? or sender_id = ?", current_user.id, current_user.id ).where(:id => params[:id]).includes(:messages).first
    return unless @message.present?

    @message.messages.where(:receiver_id => current_user.id).update_all(:read => true)
    @message.update_attributes(:read => true) if @message.receiver_id == current_user.id
    @all_messages = @message.messages.order('created_at DESC') << @message
    @new_message = @message.messages.build(:request_basket_id => @message.request_basket_id, :receiver_id => other_user(@message).id, :parent_message_id => @message.id)
  end

  def create
    @message = current_user.sent_messages.build(params[:message])
    unless @message.save
      flash[:error] = 'message not sent'
    else
      flash[:success] = 'message sent'
    end
    id = @message.parent_message_id || @message.id
    redirect_to message_path(id)
  end

  def other_user(message)
    @other_user ||= begin
      return message.receiver if message.receiver_id != current_user.id
      message.sender
    end
  end
  helper_method :other_user
end
