level = Rails.env == "production" ? "info" : "debug"

if Rails.env == 'staging' ||  Rails.env == 'production'
  Tire.configure { logger $stdout, :level => level }
  ENV['ELASTICSEARCH_URL'] = ENV['BONSAI_URL']
else
  Tire.configure { logger "log/elasticsearch_#{Rails.env}.log", :level => level }
end

Tire::Model::Search.index_prefix "#{Rails.application.class.parent_name.downcase}_#{Rails.env.to_s.downcase}"
