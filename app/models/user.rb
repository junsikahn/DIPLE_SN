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
            uniqueness: true,
            format: { with: /\A(010|011|016|018|019)[0-9]{7,8}\z/ },
            numericality: { only_integer: true },
            length: { in: 10..11 }
  validates :name,
            presence: true

  def email_required?
    false
  end

  def email_changed?
    false
  end
end
