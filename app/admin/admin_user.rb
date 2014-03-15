ActiveAdmin.register AdminUser do
  index do
    column :full_name
    column :school
    column :email
    column :role
    # column :current_sign_in_at
    # column :last_sign_in_at
    # column :sign_in_count
    default_actions
  end

  filter :email

  form do |f|
    f.inputs "Admin Details" do
      f.input :full_name
      f.input :school
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :role, :as => :radio, :collection => AdminUser::ROLES
    end
    f.actions
  end

end
