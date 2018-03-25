class CreateAssignments < ActiveRecord::Migration[5.1]
  def change
    create_table :assignments do |t|
      t.belongs_to :course, foreign_key: true
      t.datetime :due_at
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
