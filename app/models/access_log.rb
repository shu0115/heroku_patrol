class AccessLog < ActiveRecord::Base
  attr_accessible :response, :target_id, :user_id
end
