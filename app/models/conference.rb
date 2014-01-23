class Conference < ActiveRecord::Base
  attr_accessible :description, :end_date, :start_date, :title, :admin_user_id, :committee_ids
  
  belongs_to :admin_user
  has_many :users
  has_many :resolutions
  has_and_belongs_to_many :committees, :join_table => :committees_conferences
  
  validates_presence_of :title, :start_date, :end_date, :committees, :admin_user_id
end
