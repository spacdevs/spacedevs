# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  before_create :generate_registration_code, :generate_temp_password
  after_create  :send_welcome_email

  belongs_to :school, optional: true

  has_one    :profile, dependent: :destroy
  has_one    :user_school_enrollments, dependent: :destroy
  has_many   :sessions, dependent: :destroy
  has_many   :team_users, dependent: :destroy
  has_many   :teams, through: :team_users
  has_many   :discipline_subscribers, dependent: :nullify

  alias_attribute :email, :email_address

  normalizes :email_address, with: ->(e) { e.strip.downcase }
  normalizes :registration_code, with: ->(code) { code.strip.upcase }

  enum :role, { admin: 0, student: 1 }, default: :student

  validates :email_address, presence: true, uniqueness: true, format: {
    with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/,
    message: I18n.t('activerecord.errors.invalid_email_address')
  }

  def first_name
    return if profile.blank?

    profile.fullname.split.first
  end

  private

  def generate_registration_code
    self.registration_code = "SD-#{SecureRandom.hex(4)}"
  end

  def generate_temp_password
    self.password = SecureRandom.base64(6).upcase
  end

  def send_welcome_email
    WelcomeMailer.send_email(self, password).deliver_now
  end
end
