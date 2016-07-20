class Task < ApplicationRecord
  include Filterable
  
  enum task_type: [:task, :bug]
  enum status: [:fresh, :todo, :plan, :develop, :testing, :deploy, :done, :rejected]

  validates_presence_of :subject

  belongs_to :project
  belongs_to :author, foreign_key: 'author_id', class_name: 'User'

  scope :search, -> (term) { where("subject LIKE '%#{term}%' OR description LIKE '%#{term}%'") }
  scope :project, -> (project) { where(project: project) }
  scope :status, -> (status) { where status: status }

  def self.statuses_i18n
    Task.statuses.keys.map{|s| [I18n.t("task_status.#{s}"), s]}
  end

  def self.task_types_i18n
    Task.task_types.keys.map{|s| [I18n.t("task_type.#{s}"), s]}
  end

  def self.next(tasks, task)
    tasks.where("id > ?", task.id).first
  end

  def self.prev(tasks, task)
    tasks.where("id < ?", task.id).last
  end
end