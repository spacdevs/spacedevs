class Discipline < ApplicationRecord
  validates :title, :abstract,  presence: true
  validates :title,             uniqueness: true
end
