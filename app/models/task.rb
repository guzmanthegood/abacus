class Task < ApplicationRecord
  VALID_TYPES = %w( task bug feature )
  enum status: [:fresh, :todo, :plan, :develop, :testing, :deploy, :done, :rejected]

  validates_presence_of :subject
  validates_inclusion_of :task_type, in: VALID_TYPES

  belongs_to :project
  belongs_to :author, foreign_key: 'author_id', class_name: 'User'

  scope :search_by, -> (term) { where("subject LIKE '%#{term}%' OR description LIKE '%#{term}%'") }
  scope :by_project, -> (project) { where(project: project) }
  scope :closed,  -> { where.not(closed_at: nil) }
  scope :not_closed, -> { where(closed_at: nil) }


  def self.statuses_i18n
    Task.statuses.keys.map{|s| [I18n.t("task_status.#{s}"), s]}
  end
end