class Discipline < ApplicationRecord
  validates :title, :abstract, :position,  presence: true
  validates :title, uniqueness: true
end
