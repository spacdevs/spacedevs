# frozen_string_literal: true

class Content < ApplicationRecord
  belongs_to :discipline

  before_validation :update_slug

  enum :kind, { text: 0, video: 1 }

  validates :title, :body, :kind, presence: true

  def self.kinds_translated
    Content.kinds.keys.map { Content.human_enum_name(:kind, it) }
  end

  private

  def update_slug
    self.slug = title&.parameterize
  end
end
