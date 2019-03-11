# frozen_string_literal: true

# Note model for writng association.
class Comment < ApplicationRecord
  belongs_to :note
  belongs_to :user
  # belongs_to :admin_user

  validates(:comment,
            presence:
            {
              message: 'must be given please'
            })
end
