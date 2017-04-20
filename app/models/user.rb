class User < ApplicationRecord
  has_secure_password
  has_many :items
  mount_uploader :avatar, AvatarUploader


  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  # validates :email, format: { with: /\A[a-zA-Z]+\z/ }
  has_many :authentications, :dependent => :destroy

  def self.create_with_auth_and_hash(authentication,auth_hash)
    create! do |u|
      #u.first_name = auth_hash["info"]["first_name"]
      # u.last_name = auth_hash["info"]["last_name"]
      # u.friendly_name = auth_hash["info"]["name"]
      u.email = auth_hash["extra"]["raw_info"]["email"]
      u.password = SecureRandom.hex(6)
      u.authentications<<(authentication)
    end
  end

  def fb_token
    x = self.authentications.where(:provider => :facebook).first
    return x.token unless x.nil?
  end


end
