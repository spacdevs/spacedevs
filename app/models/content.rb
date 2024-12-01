class Content < ApplicationRecord
  belongs_to :discipline

  validates :title, :body, :kind, presence: true

  enum :kind, { text: 0, video: 1 }
end
