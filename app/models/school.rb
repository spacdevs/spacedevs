# frozen_string_literal: true

class School < ApplicationRecord
  validates :name, presence: true
end
