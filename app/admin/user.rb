ActiveAdmin.register User do
  scope_to :current_admin_user, :if => proc{ current_admin_user.role?('Conference Manager') }

  index do
    column :conference
    column :username
    column :roles do |user|
      user.roles.map{ |p| p }.join('<br />').html_safe
    end
    column :admin_user
    # column :current_sign_in_at
    # column :last_sign_in_at
    # column :sign_in_count
    default_actions
  end

  filter :username
  filter :role

  form do |f|
    f.inputs "User Details" do
      if (current_admin_user.role?('Conference Manager'))
        f.input :conference_id, :as => :radio, :collection => Conference.where(:admin_user_id => current_admin_user.id)
      else
        f.input :conference_id, :as => :radio, :collection => Conference.all
      end
      f.input :roles, :as => :check_boxes, :collection => User::ROLES
      f.input :username
      f.input :password
      f.input :password_confirmation
      f.input :admin_user_id, :as => :hidden, :value => current_admin_user.id
    end
    f.actions
  end

end