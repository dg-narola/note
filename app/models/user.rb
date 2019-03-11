# frozen_string_literal: true

# User model for writng association and devise.
class User < ApplicationRecord
  has_many :notes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :sharenotes, dependent: :destroy
  has_many :charges
  has_one_attached :image
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise  :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable,
          :confirmable
  after_commit :assign_customer_id, on: :create

  def assign_customer_id
    customer = Stripe::Customer.create(email: email)
    self.customer_id = customer.id
  end
end
