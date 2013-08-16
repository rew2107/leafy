ActionMailer::Base.add_delivery_method :ses, AWS::SES::Base,
  :access_key_id     => AWS.config.access_key_id,
  :secret_access_key => AWS.config.secret_access_key

ActionMailer::Base.default :from => 'info@acquirey.com'
ActionMailer::Base.layout "email"

