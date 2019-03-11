# frozen_string_literal: true

# active admin.
class AdminUser < ApplicationRecord
  # # has_many :notes, dependent: :destroy
  # # has_many :comments, dependent: :destroy
  # # has_many :sharenotes, dependent: :destroy
  # # has_many :users
  # has_one_attached :image
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :validatable
end
