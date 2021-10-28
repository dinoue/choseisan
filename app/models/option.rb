class Option < ApplicationRecord
  enum feeling: {NG: 0, Neither: 1, OK: 2 }
  validates :text, length: { maximum: 2000 }, presence: true

  belongs_to :event
  has_many :option_entries, foreign_key: :option_id, dependent: :destroy

  attr_accessor :answer_counts

  def calc_option_entry
    self.answer_counts = {}
    feeling_counts = option_entries.group(:feeling).count
    self.answer_counts[:NG] = feeling_counts['NG'] || 0
    self.answer_counts[:Neither] = feeling_counts['Neither'] || 0
    self.answer_counts[:OK] = feeling_counts['OK'] || 0
  end
end
