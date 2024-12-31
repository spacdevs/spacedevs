class Content < ApplicationRecord
  belongs_to :discipline

  validates :title, :body, :kind, presence: true

  enum :kind, { text: 0, video: 1 }

  before_save :setting_available_on

  private

  def setting_available_on
    available_on = Time.zone.now
  end
end
