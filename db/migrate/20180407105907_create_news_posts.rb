class CreateNewsPosts < ActiveRecord::Migration[5.1]
  def change
    create_table :news_posts do |t|
      t.string :name
      t.text :content
      t.belongs_to :user, foreign_key: true
      t.references :news_feed, index: true, polymorphic: true

      t.timestamps
    end
  end
end
