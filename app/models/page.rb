class Page < ActiveRecord::Base
  # setup ancestry
  has_ancestry
  
  before_validation :generate_slug
  
  validates :slug, :presence => true, :uniqueness => true
  
  class << self
    def right_nav
      where(['pages.right_nav = ?', true])
    end
    
    def left_nav
      where(['pages.right_nav = ?', false])
    end
  end
  
  def to_param
    self.slug
  end
  
  private
  def generate_slug
    p self.ancestors
    self.slug = (self.ancestors << self).collect{|a| a.title.parameterize}.join('/')
  end
end