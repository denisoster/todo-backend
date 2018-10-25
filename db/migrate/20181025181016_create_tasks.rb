class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :title, null: false
      t.boolean :status, default: true
      t.datetime :deadline
      t.integer :position
      t.references :project, index: true, foreign_key: true

      t.timestamps
    end
  end
end
