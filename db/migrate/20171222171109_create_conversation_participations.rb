class CreateConversationParticipations < ActiveRecord::Migration[5.1]
  def change
    create_table :conversation_participations do |t|
      t.integer :user_id
      t.integer :conversation_id
      t.datetime :viewed_at, null: false

      t.timestamps
    end
    add_index :conversation_participations,
              [:user_id, :conversation_id], unique: true,
              name: :index_participation_user_conversation
  end
end
