class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content
      t.integer :original_comment_id
      t.references :user, index: true
      t.references :commentable, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end
