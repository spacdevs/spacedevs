# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  belongs_to :school
  has_one    :profile, dependent: :destroy
  has_many   :sessions, dependent: :destroy
  has_many   :team_users, dependent: :destroy
  has_many   :teams, through: :team_users

  alias_attribute :email, :email_address

  normalizes :email_address, with: ->(e) { e.strip.downcase }
  normalizes :registration_code, with: ->(code) { code.strip.upcase }

  enum :role, admin: 0, student: 1

  validates :registration_code, presence: true
  validates :email_address, presence: true, uniqueness: true, format: {
    with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/,
    message: I18n.t('activerecord.errors.invalid_email_address')
  }
end
