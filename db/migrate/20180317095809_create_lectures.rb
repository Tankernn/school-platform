class CreateLectures < ActiveRecord::Migration[5.1]
  def change
    create_table :lectures do |t|
      t.belongs_to :course, foreign_key: true
      t.datetime :starts_at
      t.datetime :ends_at
      t.text :description
      t.string :location

      t.timestamps
    end
  end
end
