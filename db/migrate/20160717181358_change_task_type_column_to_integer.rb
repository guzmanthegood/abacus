class ChangeTaskTypeColumnToInteger < ActiveRecord::Migration[5.0]
  def change
  	change_column :tasks, :task_type, :integer, default: 0, null: false
  end
end
