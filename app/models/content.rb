# frozen_string_literal: true

class Content < ApplicationRecord
  belongs_to :discipline

  before_validation :update_slug

  enum :kind, { text: 0, video: 1 }

  validates :title, :body, :kind, :position, presence: true

  has_rich_text :body

  def self.kinds_translated
    Content.kinds.keys.collect { |k| [Content.human_enum_name(:kind, k), k] }
  end

  private

  def update_slug
    self.slug = title&.parameterize
  end
end
