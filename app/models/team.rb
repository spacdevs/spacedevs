# frozen_string_literal: true

class Team < ApplicationRecord
  has_many   :team_users, dependent: :destroy
  has_many   :users, through: :team_users
  has_many   :team_disciplines, dependent: :destroy
  has_many   :disciplines, through: :team_disciplines

  validates :name, presence: true
end
