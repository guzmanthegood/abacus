class Job < ApplicationRecord
  default_scope { order('performed_at') }

  validates_numericality_of :hours, greater_than: 0
  validates_presence_of :performed_at

	belongs_to :user
	belongs_to :task
end