class CandidateSpot < ApplicationRecord
  belongs_to :group
  belongs_to :spot
  belongs_to :added_by, class_name: 'User'

  has_many :votes, dependent: :destroy
  has_many :voted_users, through: :votes, source: :user
end
