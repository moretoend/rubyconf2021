class Streamer < ApplicationRecord
  has_many :lives, class_name: "Live"
  has_many :subscriptions
  has_many :subscribers, through: :subscriptions, class_name: "User"

  validates :name, presence: true, uniqueness: true
end
