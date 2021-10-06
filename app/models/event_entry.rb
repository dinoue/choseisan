class EventEntry < ApplicationRecord
  validates :comment, length: { maximum: 50 }

  belongs_to :event
  belongs_to :user
end
