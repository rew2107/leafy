class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :find_inbox_items

  private

  def find_inbox_items
    return unless user_signed_in?
    puts "!@#!@"
    @inbox_alerts = current_user.received_messages.where(:read => false).count
  end
end
