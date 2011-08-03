class Photo < ActiveRecord::Base
  # mount our uploader
  mount_uploader :image, ImageUploader

  belongs_to :product

  # instance methods
  def alt
    temp = read_attribute(:alt)
    return temp unless temp.blank?
    return self.product.name
  end
end