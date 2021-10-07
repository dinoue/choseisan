class Option < ApplicationRecord
  validates :text, length: { maximum: 2000 }, presence: true

  belongs_to :event
  has_many :option_entries, foreign_key: :option_id, dependent: :destroy
end
