class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.boolean :show_in_nav, :default => true
      t.boolean :right_nav, :default => false
      t.string :slug
      t.string :title
      t.string :display_name
      t.text :description
      t.string :keywords
      t.text :content
      t.string :change_frequency
      t.float :priority
      t.integer :display_order, :default => 0
      t.text :dakis_url

      t.timestamps
    end

    add_index :pages, :slug, :unique => true
  end

  def self.down
    drop_table :pages
  end
end