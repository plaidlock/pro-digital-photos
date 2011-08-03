class Product < ActiveRecord::Base
  # associations
  has_many :pages
  has_many :photos

  accepts_nested_attributes_for :photos, :allow_destroy => true, :reject_if => proc{|a| a['image'].blank? && a['alt'].blank?}

  # class methods
  class << self
    def active
      self.where(['is_active = ?', true])
    end

    def inactive
      self.where(['is_active = ?', false])
    end
  end

  # instance methods
end