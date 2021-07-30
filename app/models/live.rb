class Live < ApplicationRecord
  belongs_to :streamer
  has_many :messages
  has_many :watchings
end
