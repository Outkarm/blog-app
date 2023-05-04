class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :author_id
      t.text :title
      t.text :text
      t.string :comments_count
      t.string :likes_count

      t.timestamps
    end
  end
end
