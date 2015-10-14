class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :city
      t.string :state
      t.text :bio
      t.text :team_contribution
      t.string :facebook_url
      t.string :twitter_name
      t.string :linkedin_url
      t.string :email
      t.string :password_digest
      t.string :user_type
      t.attachment :image

      t.timestamps null: false
    end
  end
end
