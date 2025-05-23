# frozen_string_literal: true

class DisciplineSubscriber < ApplicationRecord
  belongs_to :user
  belongs_to :discipline
end
