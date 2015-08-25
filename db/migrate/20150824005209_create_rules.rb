class CreateRules < ActiveRecord::Migration
  def change
    create_table :rules do |t|
      t.references :school, index: true
      t.references :question, index: true
      t.boolean :answer

      t.timestamps null: false
    end
    add_foreign_key :rules, :schools
    add_foreign_key :rules, :questions
  end
end
