class CreateScholarships < ActiveRecord::Migration
  def change
    create_table :scholarships do |t|
      t.string :name
      t.string :link
      t.text :description
      t.datetime :deadline
      t.integer :amount
      t.text :requirements
      t.boolean :full_ride

      t.timestamps null: false
    end
  end
end
