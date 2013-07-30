module MessagesHelper
  def other_user(message)
    return message.receiver if message.receiver_id != current_user.id
    message.sender
  end

  def other_search_user(message)
    @other ||= begin
      return User.find(message.receiver_id) if message.receiver_id != current_user.id
      User.find(message.sender_id)
    end
  end
end
