class AdminUser < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :role, :school, :full_name
  # attr_accessible :title, :body

  validates_presence_of :email, :password, :password_confirmation, :school, :role, :full_name

  has_many :conferences
  has_many :users

  ROLES = %w(Conference\ Manager Super\ Admin)

  def role?(base_role)
    return false unless role # A user have a role attribute. If not set, the user does not have any roles.
    ROLES.index(base_role.to_s) <= ROLES.index(role)
  end

end
