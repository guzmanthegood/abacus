class Job < ApplicationRecord
  default_scope { order('performed_at') }

  validates_presence_of :performed_at, :hours

	belongs_to :user
	belongs_to :task
end