class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :city
      t.references :state, index: true, foreign_key: true
      t.string :password_digest

      t.timestamps null: false
    end
  end
end
