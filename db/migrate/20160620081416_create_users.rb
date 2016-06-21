class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :address1
      t.string :address2
      t.string :address3
      t.integer :phone_number
      t.integer :map_id


      t.timestamps null: false
    end
  end
end
