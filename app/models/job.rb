class Job < ApplicationRecord
  default_scope { order('performed_at') } 

	belongs_to :user
	belongs_to :task
end