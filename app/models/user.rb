class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, 
         :registerable,
         :recoverable,
         :rememberable,
         :validatable

  validates :login_id, length: { maximum: 10 }, presence: true, uniqueness: true
  validates :password, length: { maximum: 10 }, presence: true
  validates :name,     length: { maximum: 10 }, presence: true

  has_many :created_events, class_name: 'Event', foreign_key: :user_id
  has_many :event_entries, dependent: :destroy

  def related_events
    Event.where(Event.arel_table[:user_id].eq(self.id).or(EventEntry.arel_table[:user_id].eq(self.id)))
  end

  def max_events_created?
    created_events.count >= Settings.max_count.events
  end
end
