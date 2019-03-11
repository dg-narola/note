# frozen_string_literal: true

# Sharenote model for writng association.
class Sharenote < ApplicationRecord
  belongs_to :user
  belongs_to :note
  # belongs_to :admin_user
end
