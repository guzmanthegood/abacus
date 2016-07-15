class AddCurrentProjectToUser < ActiveRecord::Migration[5.0]
  def change
  	add_reference :users, :project, index: true, foreign_key: true
  end
end
