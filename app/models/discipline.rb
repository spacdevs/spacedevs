# frozen_string_literal: true

class Discipline < ApplicationRecord
  has_many :contents, dependent: :destroy
  has_many   :team_disciplines, dependent: :destroy
  has_many   :teams, through: :team_disciplines

  validates :title, :body, :abstract, :position, :slug, :available_on, presence: true

  before_validation :update_slug

  private

  def update_slug
    self.slug = title&.parameterize
  end
end
