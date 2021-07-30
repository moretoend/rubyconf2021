class User < ApplicationRecord
  has_many :messages
  has_many :subscriptions
  has_many :watchings
  has_many :subscribed_streamers, through: :subscriptions, class_name: "Streamer"
  has_many :watched_lives, through: :watchings, class_name: "Live"

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
end
