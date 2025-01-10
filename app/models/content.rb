class Content < ApplicationRecord
  belongs_to :discipline

  before_validation :update_slug

  enum :kind, { text: 0, video: 1 }

  validates :title, :body, :kind, presence: true

  private

  def setting_available_on
  def update_slug
    self.slug = title&.parameterize
  end
end
