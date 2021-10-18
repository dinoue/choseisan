class Event < ApplicationRecord
  validates :title, length: { maximum: 50 }, presence: true
  validates :memo,  length: { maximum: 200 }
  validates :options_text,  length: { maximum: 2000 }

  before_create :validates_create, :generate_hash_id

  belongs_to :owner, class_name: 'User', foreign_key: :user_id
  has_many :options, foreign_key: :event_id, dependent: :destroy
  has_many :event_entries, foreign_key: :event_id, dependent: :destroy
  has_many :entry_users, through: :event_entries, source: :user

  attr_accessor :options_text
  attr_accessor :options_deletes

  scope :filter_events, ->(user) {
      # 自分が作成したイベントと自分が回答したイベント
    condition = Event.arel_table[:user_id].eq(user.id).or(EventEntry.arel_table[:user_id].eq(user.id))
    where(condition)
  }

  private
    def validates_create
      if self.options_text.blank?
        self.errors.add(:options_text, "を入力してください。")
        return false
      end
      return true
    end

    def generate_hash_id
      self.hash_id = SecureRandom.hex
    end
end
