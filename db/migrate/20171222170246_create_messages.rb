class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :conversation, foreign_key: true
      t.text :content

      t.timestamps
    end
    add_index :messages, [:conversation_id, :created_at]
  end
end
