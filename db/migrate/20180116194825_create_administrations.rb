class CreateAdministrations < ActiveRecord::Migration[5.1]
  def change
    create_table :administrations do |t|

      t.references :user
      t.references :school

      t.timestamps
    end

    add_index :administrations, [:user_id, :school_id], unique: true
  end
end
