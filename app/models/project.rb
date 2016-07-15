class Project < ApplicationRecord
  validates_presence_of :name

  has_many :tasks, dependent: :destroy
  has_many :users, dependent: :nullify
  belongs_to :author, foreign_key: 'author_id', class_name: 'User', optional: true

  scope :search_by, -> (term) { where("name LIKE '%#{term}%' OR web LIKE '%#{term}%' OR description LIKE '%#{term}%'") }
end
