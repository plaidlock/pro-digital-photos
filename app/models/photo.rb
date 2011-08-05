class Photo < ActiveRecord::Base
  # mount our uploader
  mount_uploader :image, ImageUploader

  belongs_to :photoable, :polymorphic => true

  # instance methods
  def alt
    temp = read_attribute(:alt)
    return nil if self.new_record?
    return temp unless temp.blank?
    return self.photoable.name if self.photoable.respond_to?(:name)
    return self.photoable.title if self.photoable.respond_to?(:title)
  end
end