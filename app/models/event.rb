class Event < ApplicationRecord
  validates :title, length: { maximum: 50 }, presence: true
  validates :memo,  length: { maximum: 200 }
  validates :options_text, length: { maximum: 2000 }
  validate :validate_options_text

  before_create :generate_hash_id
  before_save :destroy_options, :build_options_from_options_text

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

  def option_entries_selection(event_entry)
    selection = []
    options.each.with_index(0 - options.length) do |option, index|
      selection << option.option_entries.find_or_initialize_by(event_entry: event_entry) do |option_entry|
        option_entry.attributes = { id: index, option: option, event_entry: event_entry }
      end
    end
    selection
  end

  private

  def validate_options_text
    if options_text.split(/\n/).select(&:blank?).present?
      errors.add(:options_text, "の各行を入力してください。")
      return false
    end
  end

  def generate_hash_id
    self.hash_id = SecureRandom.hex
  end

  def destroy_options
    if persisted?
      if !options_deletes.nil?
        unless Option.destroy(options_deletes.reject(&:blank?))
          errors[:base] << "候補日程の削除に失敗しました"
          return false
        end
      end
    end
  end

  def build_options_from_options_text
    if !options.exists?
      options.build(text: "出欠")
    end

    options_text.each_line do |line|
      options.build(text: line.strip)
    end
end
