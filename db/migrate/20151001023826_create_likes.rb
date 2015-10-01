class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.references :user, index: true, foreign_key: true
      t.references :likable, polymorphic: true, index: true
      t.boolean :value

      t.timestamps null: false
    end
  end
end
