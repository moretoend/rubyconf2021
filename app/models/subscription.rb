class Subscription < ApplicationRecord
  belongs_to :user
  belongs_to :streamer

  validates :tier, presence: true
  validates :user_id, uniqueness: { scope: :streamer_id }

  enum tier: { bronze: "bronze", silver: "silver", gold: "gold" }
end
