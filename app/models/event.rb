class Event < ActiveRecord::Base
  belongs_to :state
  belongs_to :user  # host
  has_many :guests
  has_many :attendees, through: :guests, source: :user # double check this
  has_many :comments # double check this

  validates :name, :city, :date, presence: true
end
