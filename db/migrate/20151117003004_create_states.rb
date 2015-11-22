class CreateStates < ActiveRecord::Migration
  def change
    create_table :states do |t|
      t.string :name
      t.string :abbreviation
      t.integer :in_state
      t.text :description

      t.timestamps null: false
    end
  end
end
