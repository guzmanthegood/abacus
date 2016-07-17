class ChangeTaskTypeColumnToInteger < ActiveRecord::Migration[5.0]
  def change
  	change_column :tasks, :task_type, :integer
  end
end
