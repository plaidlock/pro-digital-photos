class User < ActiveRecord::Base
  attr_accessor :password
  
  before_validation :encrypt_password
  
  validates :username, :name, :password_salt, :password_hash, :presence => true
  
  class << self
    def authenticate(username, password)
      user = User.find_by_username(username)
      return user if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      nil
    end
  end
  
  private
  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end
end