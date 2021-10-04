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

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["login_id = :value", { :value => login }]).first
    else
      where(conditions).first
    end
  end

end
