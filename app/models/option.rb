class Option < ApplicationRecord
  validates :text, length: { maximum: 2000 }, presence: true

  belongs_to :event
end
