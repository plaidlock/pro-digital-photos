class CreatePhotos < ActiveRecord::Migration
  def self.up
    create_table :photos do |t|
      t.string :alt
      t.string :image

      t.timestamps
    end
  end

  def self.down
    drop_table :photos
  end
end
