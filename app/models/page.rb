class Page < ActiveRecord::Base
  # violate some MVC stuff... no big deal
  include ActionView::Helpers::TextHelper

  # setup ancestry
  has_ancestry :cache_depth => true

  # associations
  belongs_to :product

  accepts_nested_attributes_for :product, :reject_if => proc{|attributes| attributes['name'].blank? || attributes['dakis_url'].blank?}

  # we can act like wordpress and do some cool stuff too!
  before_validation :generate_description, :generate_display_name, :generate_slug, :generate_keywords, :generate_change_frequency, :generate_priority

  # validations
  validates :slug, :title, :display_name, :content, :description, :keywords, :presence => true
  validates :slug, :uniqueness => true

  class << self
    def active
      self.where(['pages.is_active = ?', true])
    end

    def inactive
      self.where(['pages.is_active = ?', false])
    end

    def right_nav
      self.where(['pages.right_nav = ?', true])
    end

    def left_nav
      self.where(['pages.right_nav = ?', false])
    end
  end

  def primary_photo
    self.photos.first || self.photos.new
  end

  def has_product?
    !self.product.nil?
  end

  def to_param
    self.slug
  end

  private
  def generate_slug
    self.slug = (self.ancestors << self).collect{|a| a.display_name.parameterize}.join('/')
    return true
  end

  def generate_description
    self.description = truncate(Sanitize.clean(self.content).strip.squeeze(" "), :length => 200) if self.description.blank?
  end

  def generate_display_name
    self.display_name = self.title if self.display_name.blank?
    return true
  end

  def generate_keywords
    text = [self.title, self.display_name, self.description, self.content].join(' ')
    self.keywords = Keywords.generate(text)
    return true
  end

  def generate_change_frequency
    self.change_frequency = 'monthly' if self.change_frequency.blank?
    return true
  end

  def generate_priority
    self.priority ||= '0.1' if self.priority.blank?
    return true
  end
end