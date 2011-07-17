class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.boolean :right_nav, :default => false
      t.string :slug
      t.string :title
      t.string :tooltip
      t.text :description
      t.string :keywords
      t.text :content
      
      t.timestamps
    end
    
    add_index :pages, :slug, :unique => true
  end

  def self.down
    drop_table :pages
  end
end