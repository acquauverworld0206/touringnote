class Invitation < ApplicationRecord
  belongs_to :group
  belongs_to :sender
  belongs_to :recipient
end
