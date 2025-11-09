class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :spots
  has_many :hosted_groups, class_name: 'Group', foreign_key: 'host_id'
  has_many :group_members
  has_many :groups, through: :group_members
  has_many :added_candidate_spots, class_name: 'CandidateSpot', foreign_key: 'added_by_user_id', dependent: :destroy

  has_many :sent_invitations, class_name: 'Invitation', foreign_key: 'sender_id'
  has_many :received_invitations, class_name: 'Invitation', foreign_key: 'recipient_id'

  has_many :votes, dependent: :destroy
end
