class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.string :title
      t.text :description
      t.text :body
      t.references :user, index: true, foreign_key: true
      t.boolean :anonymous

      t.timestamps null: false
    end
  end
end
