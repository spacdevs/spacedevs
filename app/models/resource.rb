# frozen_string_literal: true

class Resource < ApplicationRecord
  belongs_to :sourceable, polymorphic: true

  validates :name, presence: true

  has_one_attached :file
end
