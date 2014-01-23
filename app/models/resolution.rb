class Resolution < ActiveRecord::Base
  belongs_to :conference
  belongs_to :committee
  belongs_to :user
  belongs_to :status
  attr_accessible :committee_id, :status_id, :user_id, :votes_against, :votes_for, :document, :title
  has_attached_file :document
  validates_presence_of :title, :committee_id, :document
end
