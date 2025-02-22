# frozen_string_literal: true

class Discipline < ApplicationRecord
  has_many :contents, dependent: :destroy

  validates :title, :body, :abstract, :position, :slug, :available_on, presence: true

  before_validation :update_slug

  private

  def update_slug
    self.slug = title&.parameterize
  end
end
