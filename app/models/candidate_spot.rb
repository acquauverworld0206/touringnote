class CandidateSpot < ApplicationRecord
  belongs_to :group
  belongs_to :spot
  belongs_to :added_by, class_name: 'User', foreign_key: 'added_by_user_id'

  has_many :votes, dependent: :destroy
  has_many :voted_users, through: :votes, source: :user
end
