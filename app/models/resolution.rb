class Resolution < ActiveRecord::Base

  Paperclip.interpolates :conference_title do |attachment, style|
    attachment.instance.conference.title
  end

  Paperclip.interpolates :status_name do |attachment, style|
    attachment.instance.status.name
  end
  belongs_to :conference
  belongs_to :committee
  belongs_to :user
  belongs_to :status
  belongs_to :country
  attr_accessible :committee_id, :status_id, :user_id, :votes_against, :votes_for, :document, :title, :country_id, :num_votes_for, :num_votes_against, :num_abstentions
  has_attached_file :document, PAPERCLIP_STORAGE_OPTS
  validates_attachment_content_type :document, :content_type => ["application/pdf",
  	"application/msword",
  	"application/vnd.openxmlformats-officedocument.wordprocessingml.document", 
  	"text/plain"]
  validates_presence_of :title, :committee_id, :country_id, :document
end
