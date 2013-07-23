module MessagesHelper
  def other_user(message)
    message.receiver if message.receiver_id != current_user.id
    message.sender
  end
end
