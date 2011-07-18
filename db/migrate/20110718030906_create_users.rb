class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :username
      t.string :password_hash
      t.string :password_salt
      t.string :name
      t.boolean :is_admin, :default => false

      t.timestamps
    end
    
    add_index :users, :username
  end

  def self.down
    drop_table :users
  end
end
