class CreateCourseParticipations < ActiveRecord::Migration[5.1]
  def change
    create_table :course_participations do |t|
      t.belongs_to :course, foreign_key: true
      t.belongs_to :user, foreign_key: true
      t.integer :role

      t.timestamps
    end

    add_index :course_participations, [:user_id, :course_id], unique: true
  end
end
