class AddCreatedByToProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :author_id, :integer
    add_index :projects, :author_id
  end
end
