class Comment < ApplicationRecord
  belongs_to :note
  belongs_to :user
  validates :comment, presence:{ message: "must be given please" }
end
