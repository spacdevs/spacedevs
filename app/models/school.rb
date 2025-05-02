# frozen_string_literal: true

class School < ApplicationRecord
  has_one :user_school_enrollments, dependent: :destroy

  validates :name, presence: true
end
