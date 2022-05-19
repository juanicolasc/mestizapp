class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :pasword_hash
      t.string :password_salt
      t.integer :profile

      t.timestamps
    end
  end
end
