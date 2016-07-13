class Project < ApplicationRecord
	validates :name, presence: true

	scope :search_by, -> (term) { where("name LIKE '%#{term}%' OR web LIKE '%#{term}%' OR description LIKE '%#{term}%'")}
end
