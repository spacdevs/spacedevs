# frozen_string_literal: true

class Discipline < ApplicationRecord
  has_many   :resources, as: :sourceable, dependent: :destroy
  has_many   :contents, dependent: :destroy
  has_many   :team_disciplines, dependent: :destroy
  has_many   :teams, through: :team_disciplines
  has_many   :users, through: :teams
  has_many   :discipline_subscribers, dependent: :nullify

  validates :title, :body, :abstract, :position, :slug, :available_on, presence: true

  before_validation :update_slug

  has_rich_text :body
  has_rich_text :abstract

  private

  def update_slug
    self.slug = title&.parameterize
  end
end
