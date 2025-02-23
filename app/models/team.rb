# frozen_string_literal: true

class Team < ApplicationRecord
  has_many :team_users_discipline
  has_many :users, through: :team_users_discipline
  has_many :disciplines, through: :team_users_discipline

  validates :name, presence: true
end
