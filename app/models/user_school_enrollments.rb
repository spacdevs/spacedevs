# frozen_string_literal: true

class UserSchoolEnrollments < ApplicationRecord
  belongs_to :school
  belongs_to :user

  enum :degree, first_year: 1, second_year: 2, third_year: 3

  validates :degree, presence: true
end
