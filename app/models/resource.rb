class Resource < ActiveRecord::Base
  attr_accessible :api_key, :password, :response, :target_id, :target_kind, :target_type, :url, :user, :body
end
