class CreateJobs < ActiveRecord::Migration[5.0]
  def change
    create_table :jobs do |t|
      t.integer   :task_id
      t.integer   :user_id
      t.datetime  :performed_at
      t.string    :description
      t.decimal   :hours,        default: 0

      t.timestamps
    end

    add_index :jobs, :task_id
    add_index :jobs, :user_id
  end
end