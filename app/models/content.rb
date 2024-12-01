class Content < ApplicationRecord
  validates :title,  presence: true
  validates :resume, presence: true
end
