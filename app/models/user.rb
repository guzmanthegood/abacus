class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, 
         :rememberable, :trackable, :validatable

	scope :search_by, -> (term) { where("name LIKE '%#{term}%' OR email LIKE '%#{term}%'")}
end