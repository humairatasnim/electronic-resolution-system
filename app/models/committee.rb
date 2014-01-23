class Committee < ActiveRecord::Base
  attr_accessible :name
  has_and_belongs_to_many :conferences, :join_table => :committees_conferences
  has_many :resolutions
end
