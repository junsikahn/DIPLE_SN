class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :recoverable, :lockable, :timeoutable, :omniauthable, :trackable
  devise :database_authenticatable,
         :registerable,
         :rememberable,
         :validatable,
         :lastseenable,
         authentication_keys: [:uid]

  validates :uid,
            presence: true,
            uniqueness: true
            # numericality: { only_integer: true }
            # format: { with: /\A(010|011|016|018|019)[0-9]{7,8}\z/ },
            # length: { in: 10..11 },
  validates :name,
            presence: true

  has_many :problem_collection_histories
  has_many :problem_histories

  def tmp_password
    birthday.year.to_s.slice(2..3) + (birthday.month > 9 ? birthday.month.to_s : '0' + birthday.month.to_s) + (birthday.day > 9 ? birthday.day.to_s : '0' + birthday.day.to_s)
  end

  def email_required?
    false
  end

  def email_changed?
    false
  end
end
