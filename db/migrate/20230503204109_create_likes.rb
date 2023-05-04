class CreateLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :likes do |t|
      t.string :author_id
      t.string :post_id

      t.timestamps
    end
  end
end
