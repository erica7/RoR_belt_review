class User < ActiveRecord::Base
  belongs_to :state
  has_secure_password
  has_many :events  # hosting
  has_many :guests  # many entries on the Guest join table
  has_many :events_attending, through: :guests, source: :event # double check this
  has_many :comments

  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :first_name, :last_name, :email, :city, presence: true
  validates :email, format: { with: EMAIL_REGEX }, uniqueness: { case_sensitive: false }

  before_save :email_downcase

  def email_downcase
    email.downcase!
  end
end
