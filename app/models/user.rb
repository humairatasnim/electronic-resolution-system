class User < ActiveRecord::Base
  devise :database_authenticatable, :rememberable, :trackable, :validatable, :authentication_keys => [:username]
  attr_accessible :username, :password, :password_confirmation, :roles, :conference_id, :admin_user_id

  belongs_to :admin_user
  belongs_to :conference
  has_many :resolutions, :dependent => :delete_all
  
  validates_uniqueness_of :username
  
  ROLES = %w[can\ register\ resolutions can\ approve\ resolutions can\ pass/fail\ resolutions can\ print\ resolutions full\ access\ rights]

  def email_required?
    false
  end

  def email_changed?
    false
  end

  def roles=(roles)
    self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.inject(0, :+)
  end

  def roles
    ROLES.reject do |r|
      ((roles_mask.to_i || 0) & 2**ROLES.index(r)).zero?
    end
  end

  def is?(role)
    roles.include?(role.to_s)
  end
end
