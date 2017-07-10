class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :recoverable, :lockable, :timeoutable, :omniauthable
  devise :database_authenticatable,
         :registerable,
         :rememberable,
         :trackable,
         :validatable,
         :lastseenable,
         authentication_keys: [:phone]

  has_many :careers, dependent: :destroy
  has_many :univ_careers, -> { where(category: 'univ') }, class_name: 'Career'
  has_many :high_careers, -> { where(category: 'high') }, class_name: 'Career'
  accepts_nested_attributes_for :univ_careers, allow_destroy: true
  accepts_nested_attributes_for :high_careers, allow_destroy: true
  has_many :favored_subjects, dependent: :destroy
  accepts_nested_attributes_for :favored_subjects, allow_destroy: true
  has_many :locations, dependent: :destroy
  accepts_nested_attributes_for :locations, allow_destroy: true
  has_many :schedules, dependent: :destroy
  accepts_nested_attributes_for :schedules, allow_destroy: true

  has_one :mentor, dependent: :destroy
  has_many :mentor_matches, through: :mentor, source: :matches
  has_many :matched_mentees, -> { distinct }, through: :mentor, source: :mentees
  has_many :mentor_schedules, through: :mentor_matches, source: :schedules

  has_one :mentee, dependent: :destroy
  has_many :mentee_matches, through: :mentee, source: :matches
  has_many :matched_mentors, -> { distinct }, through: :mentee, source: :mentors
  has_many :mentee_schedules, through: :mentee_matches, source: :schedules

  has_attached_file :avatar,
                    styles: { normal: '500x500#', thumbnail: '200x200#' },
                    url: '/assets/users/:id/:style/:basename.:extension',
                    path: ':rails_root/public/assets/users/:id/:style/:basename.:extension',
                    default_url: '/images/image_preview.png'
  validates_attachment :avatar,
                       content_type: { content_type: ['image/jpeg', 'image/pjpeg', 'image/pjpeg', 'image/png', 'image/jpg', 'image/gif', 'application/octet-stream'] },
                       size: { less_than: 20.megabytes }

  validates :name,
            presence: true
  validates :phone,
            presence: true,
            uniqueness: true,
            format: { with: /\A(010|011|016|018|019)[0-9]{7,8}\z/ },
            numericality: { only_integer: true },
            length: { in: 10..11 }
  validates :agreed_at, presence: { on: :create, allow_blank: true }
  # validates :gender, inclusion: { on: :update, in: [true, false] }
  # validates :birthday, presence: { on: :update }
  # validates :email,
  #           format: { with: /\A[0-9a-zA-Z\-_.]+@[a-z0-9]+[.][a-zA-Z]{2,3}[.]?[a-z]{0,2}\z/, allow_blank: true }
  validate :schedule_check

  def agreed_at=(boolean)
    self[:agreed_at] = Time.now if boolean == '1'
  end

  def phone_number
    phone.insert(3, '-').insert(-5, '-')
  end

  def mentor?
    !mentor.blank?
  end

  def mentee?
    !mentee.blank?
  end

  def recognized?
    return false if gender.nil? || birthday.nil?
    true
  end

  def mentor_recognized?
    return false if !recognized? || avatar.blank? || mentor.self_introduction.blank? || careers.blank?
    true
  end

  def email_required?
    false
  end

  def schedule_check
    schedules.each do |this|
      next if this.day_of_week.nil? || this.time_start.nil? || this.time_end.nil?
      schedules.each do |that|
        next if this == that || that.day_of_week.nil? || that.time_start.nil? || that.time_end.nil?
        time_start_check = this.time_start <= that.time_end   && this.time_start >= that.time_start
        time_end_check   = this.time_end   >= that.time_start && this.time_end   <= that.time_end
        errors.add(:name) if time_start_check || time_end_check
        this.errors.add(:time_start, "시간을 조정해주세요") if time_start_check
        this.errors.add(:time_end,   "시간을 조정해주세요") if time_end_check
        this.errors.add(:day_of_week, "#{this.day_name} 시간이 중복됩니다") if time_start_check || time_end_check
        that.errors.add(:day_of_week, "#{that.day_name} 시간이 중복됩니다") if time_start_check || time_end_check
      end
    end
  end
end
