class Photo < ActiveRecord::Base
  # Mount the uploader
  mount_uploader :image, ImageUploader
  
  belongs_to :attachable, :polymorphic => true
end