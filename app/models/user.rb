class User < ActiveRecord::Base
  has_secure_password

  before_validation { |user| user.email = email.downcase }
  before_save :create_remember_token

  validates_uniqueness_of :email

  has_many :inward_follows, :class_name => 'Follow', :foreign_key => 'followed_id'
  has_many :outward_follows, :class_name => 'Follow', :foreign_key => 'follower_id'

  has_many :followers, :through => :inward_follows, :source => :follower
  has_many :followeds, :through => :outward_follows, :source => :followed

  has_many :attendances
  has_many :shows, :through => :attendances
  has_many :venues, :through => :shows

  def avatar
    a = read_attribute(:avatar)
    unless a
      a = "http://robohash.org/#{SecureRandom.urlsafe_base64(5)}"
      write_attribute(:avatar, a)
    end
    a
  end

  private

  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end
end
