class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :find_inbox_items

  def true_false_terms(true_param, false_param)
    params[false_param] = params[true_param] = true if params[false_param].nil? && params[true_param].nil?
    true_term = params[true_param]
    false_term = params[false_param]
    if false_term && !true_term
      false
    elsif !false_term && true_term
      true
    else
      nil
    end
  end

  private

  def find_inbox_items
    return unless user_signed_in?
    @inbox_alerts = current_user.received_messages.where(:read => false)
  end
end
