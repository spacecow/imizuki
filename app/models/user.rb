class User < ActiveRecord::Base
  attr_accessor :password
  before_save :encrypt_password

  validates_presence_of :password, :on=>:create
  validates_confirmation_of :password
  validates :email, presence:true, uniqueness:true
  validates :username, presence:true, uniqueness:true

  ADMIN     = 'admin'
  GOD       = 'god'
  MEMBER    = 'member'
  MINIADMIN = 'miniadmin'
  VIP       = 'vip'
  ROLES     = [GOD,ADMIN,MINIADMIN,VIP,MEMBER]

  def encrypt_password(pass); BCrypt::Engine.hash_secret(pass,password_salt) end

  class << self
    def authenticate(login,password)
      user = find_by_email(login) || find_by_username(login)
      return user if user && user.password_hash == BCrypt::Engine.hash_secret(password,user.password_salt)
    end

    def role(s) 2**ROLES.index(s.to_s) end
  end

  private

    def encrypt_password
      if password.present?
        self.password_salt = BCrypt::Engine.generate_salt
        self.password_hash = BCrypt::Engine.hash_secret(password,password_salt)
      end
    end
end

# == Schema Information
#
# Table name: users
#
#  id            :integer(4)      not null, primary key
#  username      :string(255)
#  email         :string(255)
#  roles_mask    :integer(4)
#  password_hash :string(255)
#  password_salt :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#

