class CommitteesConferences < ActiveRecord::Base
  belongs_to :committee
  belongs_to :conference
  # attr_accessible :title, :body
end
