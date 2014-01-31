class Resolution < ActiveRecord::Base
  belongs_to :conference
  belongs_to :committee
  belongs_to :user
  belongs_to :status
  belongs_to :country
  attr_accessible :committee_id, :status_id, :user_id, :votes_against, :votes_for, :document, :title, :country_id, :num_votes_for, :num_votes_against, :num_abstentions
  has_attached_file :document
  validates_presence_of :title, :committee_id, :country_id, :document
end
