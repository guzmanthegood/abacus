class CreateWorks < ActiveRecord::Migration[5.0]
  def change
    create_table :works do |t|
      t.integer :task_id
      t.integer :user_id
      t.date :worked_at
      t.string :comment
      t.decimal :time

      t.timestamps
    end

    add_index :works, :task_id
    add_index :works, :user_id
  end
end
