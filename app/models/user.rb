class User < ApplicationRecord
	validates :email, presence: true

	scope :search_by, -> (term) { where("name LIKE '%#{term}%' OR email LIKE '%#{term}%'")}
end
