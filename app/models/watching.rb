class Watching < ApplicationRecord
  belongs_to :user
  belongs_to :live

  validates :duration_in_seconds, presence: true, 
                                  numericality: { only_integer: true }
end
