class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, 
         :rememberable, :trackable, :validatable

  belongs_to :current_project, foreign_key: :project_id, class_name: 'Project', optional: true
  has_many :jobs
  has_many :tasks, foreign_key: :author_id
  has_many :projects, foreign_key: :author_id

  scope :search, -> (term) { where("name LIKE '%#{term}%' OR email LIKE '%#{term}%'") }
end