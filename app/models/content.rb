class Content < ApplicationRecord
  validates :title, :resume,  presence: true
  validates :title,           uniqueness: true
end
