class AddAncestryToPages < ActiveRecord::Migration
  def self.up
    add_column :pages, :ancestry, :string
    add_column :pages, :ancestry_depth, :integer, :default => 0
    
    add_index :pages, :ancestry
    add_index :pages, :ancestry_depth
  end

  def self.down
    remove_column :pages, :ancestry
    remove_column :pages, :ancestry_depth
    
    remove_index :pages, :ancestry
    remove_index :pages, :ancestry_depth
  end
end