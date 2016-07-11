class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :email
	
	scope :search_by, -> (term) { where("name LIKE '%#{term}%' OR email LIKE '%#{term}%'")}
end
