class CreateOpinions < ActiveRecord::Migration
  def change
    create_table :opinions do |t|
      t.references :user, index: true, foreign_key: true
      t.references :opinionable, polymorphic: true, index: true
      t.boolean :value

      t.timestamps null: false
    end
  end
end
