class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|
      t.string :name
      t.decimal :rating
      t.string :link
      t.integer :students
      t.integer :undocumented_students
      t.string :street
      t.string :city
      t.string :state
      t.string :zip
      t.boolean :public

      t.timestamps null: false
    end
  end
end
