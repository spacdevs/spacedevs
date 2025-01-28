# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  has_many   :sessions, dependent: :destroy
  has_one    :profile, dependent: :destroy
  belongs_to :school

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  validates :email_address, :registration_code, presence: true

  enum :role, manager: 0, student: 1
end
