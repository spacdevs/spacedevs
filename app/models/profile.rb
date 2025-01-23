# frozen_string_literal: true

class Profile < ApplicationRecord
  belongs_to :user

  validates :first_name, :last_name, :birthday, :degree, presence: true

  enum :degree, first_year: 1, second_year: 2, third_year: 3

  before_create :generate_avatar

  def fullname
    "#{first_name} #{last_name}"
  end

  private

  def generate_avatar
    hash = Digest::MD5.hexdigest(user.email_address.downcase)
    self.avatar = "https://www.gravatar.com/avatar/#{hash}"
  end
end
