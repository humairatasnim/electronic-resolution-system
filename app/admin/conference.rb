ActiveAdmin.register Conference do

  scope_to :current_admin_user, :if => proc{ current_admin_user.role == 'Conference Manager' }

  index do
    column :id
    column :title
    column "School" do |conference|
      conference.admin_user.school
    end
    column :admin_user
    column :start_date
    column :end_date
    column "Committees" do |conference|
    	conference.committees.map{ |p| p.name }.join('<br />').html_safe
    end
    column :description
    # column :is_active do |object|
    #   object.is_active? ? 'Yes' : 'No'
    # end
    default_actions
  end

  filter :title
  filter :start_date
  filter :end_date


 form do |f|
    f.inputs "Conference Details" do
      f.input :title
      f.input :admin_user_id, :as => :select, :collection => AdminUser.where(:role => "Conference Manager").map{ |admin_user| [admin_user.school, admin_user.id] }, :label => "School", :required => true
      f.input :start_date, :order => [:day, :month, :year]
      f.input :end_date, :order => [:day, :month, :year]
    end
    f.inputs "Committees" do
      f.input :committees, :as => :check_boxes
    end
    f.inputs "Description (optional)" do
      f.input :description
    end
    # f.inputs "Conference Status" do
    #   f.input :is_active, :label => "Active?"
    # end
    f.actions
  end
end