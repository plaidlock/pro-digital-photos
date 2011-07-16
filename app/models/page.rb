class Page < ActiveRecord::Base
  # setup ancestry
  has_ancestry
  
  before_validation :generate_slug
  
  def to_param
    slug
  end
  
  private
  def generate_slug
    self.slug = (self.ancestors << self).collect{|a| a.title.parameterize}.join('/')
  end
end