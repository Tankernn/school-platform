class CreateGroupParticipations < ActiveRecord::Migration[5.1]
  def change
    create_table :group_participations do |t|
      t.references :user, foreign_key: true, index: true
      t.references :group, polymorphic: true, index: true

      t.timestamps
    end
  end
end
