class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, 
         :rememberable, :trackable, :validatable

	scope :search_by, -> (term) { where("name LIKE '%#{term}%' OR email LIKE '%#{term}%'")}

	belongs_to :current_project, foreign_key: "project_id", class_name: "Project", optional: true
end