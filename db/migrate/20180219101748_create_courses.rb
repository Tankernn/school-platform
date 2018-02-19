class CreateCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :courses do |t|
      t.string :name
      t.belongs_to :school, foreign_key: true
      t.date :starts_on
      t.date :ends_on

      t.timestamps
    end
  end
end
