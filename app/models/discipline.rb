class Discipline < ApplicationRecord
  has_many :contents, dependent: :destroy

  validates :title, :abstract, :position, :slug, presence: true

  before_validation :update_slug

  private

  def update_slug
    self.slug = title&.parameterize
  end
end
