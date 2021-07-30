class Message < ApplicationRecord
  belongs_to :user
  belongs_to :live

  validates :body, presence: true
  validates :send_date, presence: true
end
