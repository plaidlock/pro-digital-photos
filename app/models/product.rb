class Product < ActiveRecord::Base
  # associations
  has_many :pages
  has_many :photos

  accepts_nested_attributes_for :photos, :allow_destroy => true, :reject_if => proc{|a| a['image'].blank? && a['alt'].blank?}

  before_validation :generate_keywords

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

  # private methods
  def generate_keywords
    text = [self.name, self.content].join(' ')
    self.keywords = Keywords.generate(text)
    return true
  end
end