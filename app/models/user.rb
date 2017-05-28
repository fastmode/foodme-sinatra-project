class User < ActiveRecord::Base
  has_many :reviews
  has_many :dishes, through: :reviews
  has_secure_password

  validates :username, presence: true
  validates :email, presence: true
  validates :password, presence: true

  def slug
    username.downcase.gsub(" ","-")
  end

  def self.find_by_slug(slug)
    User.all.find{|user| user.slug == slug}
  end
end