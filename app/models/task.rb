class Task < ApplicationRecord
  VALID_TYPES = %w( task bug feature )

  validates_presence_of :subject
  validates_inclusion_of :task_type, in: VALID_TYPES

  belongs_to :project
  belongs_to :author, foreign_key: 'author_id', class_name: 'User'

  scope :search_by, -> (term) { where("subject LIKE '%#{term}%' OR description LIKE '%#{term}%'") }
  scope :by_project, -> (project) { where(project: project) }
end