class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :candidate_spot

  validates :user_id, uniqueness: { scope: :candidate_spot_id }
end
