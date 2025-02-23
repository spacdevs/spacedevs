# frozen_string_literal: true

class Team < ApplicationRecord
  has_many   :team_users, dependent: :destroy
  has_many   :users, through: :team_users

  validates :name, presence: true
end
