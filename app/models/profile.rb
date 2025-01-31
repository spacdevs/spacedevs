# frozen_string_literal: true

class Profile < ApplicationRecord
  belongs_to :user

  validates :first_name, :last_name, :birthday, :degree, presence: true

  enum :degree, first_year: 1, second_year: 2, third_year: 3

  before_create :generate_avatar, :generate_slug

  def fullname
    "#{first_name} #{last_name}"
  end

  def age
    years = Date.current.year -  birthday.year

    if Date.current < birthday
      years -= 1
      return years
    end

    years
  end

  private

  def generate_slug
    self.slug = "#{first_name} #{last_name}".parameterize
  end

  def generate_avatar
    hash = Digest::MD5.hexdigest(user.email_address.downcase)
    self.avatar = "https://www.gravatar.com/avatar/#{hash}"
  end
end
