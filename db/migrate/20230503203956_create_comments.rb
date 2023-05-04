class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.string :author_id
      t.string :post_id
      t.text :text

      t.timestamps
    end
  end
end
