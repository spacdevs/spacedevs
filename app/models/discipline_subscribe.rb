# frozen_string_literal: true

class DisciplineSubscribe < ApplicationRecord
  belongs_to :user
  belongs_to :discipline
end
