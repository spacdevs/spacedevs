class Content < ApplicationRecord
  belongs_to :discipline

  validates :title, :body, :kind, presence: true

  enum :kind, { text: 0, video: 1 }

  before_save :default_available_value

  private

  def default_available_value
    available = Time.zone.now
  end
end
