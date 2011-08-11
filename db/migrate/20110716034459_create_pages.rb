class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.boolean :show_in_nav, :default => true
      t.boolean :right_nav, :default => false
      t.boolean :is_active, :default => true
      t.boolean :is_content_on_top, :default => true
      t.integer :product_id
      t.string :slug
      t.string :title
      t.string :display_name
      t.text :description
      t.string :keywords
      t.text :content
      t.string :change_frequency
      t.float :priority
      t.integer :display_order, :default => 0

      t.timestamps
    end

    add_index :pages, :slug, :unique => true
  end

  def self.down
    drop_table :pages
  end
end