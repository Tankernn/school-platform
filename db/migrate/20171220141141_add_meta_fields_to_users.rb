class AddMetaFieldsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :gender, :integer, default: 0
    add_column :users, :phone, :string
    add_column :users, :birth_date, :date
  end
end
