class User < ActiveRecord::Base
  attr_accessor :password
  before_save :prepare_password

  def self.authenticate(login,pass)
    user = find_by_username(login) || find_by_email(login)
    return user if user && user.password_hash == user.encrypt_password(pass)
  end

  def encrypt_password(pass); BCrypt::Engine.hash_secret(pass,password_salt) end

  private
    def prepare_password
      unless password.blank?
        self.password_salt = BCrypt::Engine.generate_salt
        self.password_hash = encrypt_password(password)
      end
    end
end
