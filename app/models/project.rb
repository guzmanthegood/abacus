class Project < ApplicationRecord
  validates :name, presence: true

  scope :search_by, -> (term) { where("name LIKE '%#{term}%' OR web LIKE '%#{term}%' OR description LIKE '%#{term}%'")}

  has_many :users, dependent: :nullify
  belongs_to :author, foreign_key: 'author_id', class_name: 'User', optional: true
end
