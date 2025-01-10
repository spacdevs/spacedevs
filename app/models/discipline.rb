class Discipline < ApplicationRecord
  has_many :contents, dependent: :destroy

  validates :title, :abstract, :position,  presence: true
  validates :title, uniqueness: true
end
