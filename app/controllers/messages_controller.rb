class MessagesController < ApplicationController
  before_filter :authenticate_user!

  def index
    messages = Message.where("receiver_id = ? or sender_id = ?", current_user.id, current_user.id ).where(:parent_message_id => nil).order(:created_at)
    unread_ids = @inbox_alerts.map(&:parent_message_id).compact + messages.where(:read => false).map(&:id)
    @unread_messages, @read_messages = messages.partition{ |m| unread_ids.include? m.id }
  end

  def show
    @message = Message.where("receiver_id = ? or sender_id = ?", current_user.id, current_user.id ).where(:id => params[:id]).includes(:messages).limit(1).first
    return unless @message.present?

    @message.messages.where(:receiver_id => current_user.id).update_all(:read => true)
    @message.update_attributes(:read => true) if @message.receiver_id == current_user.id
    @all_messages = [@message] + @message.messages.order('created_at ASC')
    @new_message = @message.messages.build(:receiver_id => other_user(@message).id, :parent_message_id => @message.id)
  end

  def create
    @message = current_user.sent_messages.build(params[:message])
    unless @message.save
      flash[:error] = 'message not sent' unless @message.save
    else
      flash[:success] = 'message sent' unless @message.save
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
