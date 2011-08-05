class CreatePhotos < ActiveRecord::Migration
  def self.up
    create_table :photos do |t|
      t.references :photoable, :polymorphic => true
      t.string :image
      t.string :alt

      t.timestamps
    end
  end

  def self.down
    drop_table :photos
  end
end
