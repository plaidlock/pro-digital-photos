class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.string :name
      t.string :dakis_url
      t.text :content
      t.string :keywords
      t.boolean :is_active, :default => true
    end
  end

  def self.down
    drop_table :products
  end
end
