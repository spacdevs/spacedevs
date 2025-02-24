# frozen_string_literal: true

class Profile < ApplicationRecord
  belongs_to :user

  before_create :generate_avatar, :generate_slug

  enum :degree, first_year: 1, second_year: 2, third_year: 3
  accepts_nested_attributes_for :user, update_only: true

  validates :first_name, :last_name, :birthday, :degree, presence: true

  def fullname
    "#{first_name} #{last_name}"
  end

  def age
    current_year = Date.current.year
    years = current_year - birthday.year
    years - 1 if Date.current < birthday.change(year: current_year)
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
