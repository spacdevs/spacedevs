# frozen_string_literal: true

class School < ApplicationRecord
  validates_presence_of :name
end
