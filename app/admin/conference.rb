ActiveAdmin.register Conference do

  scope_to :current_admin_user, :if => proc{ current_admin_user.role == 'Conference Manager' }

  index do
    column :id
    column :title
    column "Conference Manager" do |conference|
      conference.admin_user.full_name
    end
    column "School" do |conference|
      conference.admin_user.school
    end
    column "Committees" do |conference|
    	conference.committees.map{ |p| p.name }.join('<br />').html_safe
    end
    column :start_date
    column :end_date
    default_actions
  end

  filter :title
  filter :start_date
  filter :end_date


 form do |f|
    f.inputs "Conference Details" do
      f.input :title
      f.input :admin_user_id, :as => :select, :collection => AdminUser.where(:role => "Conference Manager").map{ |admin_user| [admin_user.full_name, admin_user.id] }, :label => "Conference Manager", :required => true
      f.input :start_date, :order => [:day, :month, :year], :start_year => Date.today.year, :end_year => 8.years.from_now.year
      f.input :end_date, :order => [:day, :month, :year], :start_year => Date.today.year, :end_year => 8.years.from_now.year
    end
    f.inputs "Committees" do
      f.input :committees, :as => :check_boxes
    end
    f.inputs "Description (optional)" do
      f.input :description
    end
    f.actions
  end


  show do |ad|
    attributes_table do
      row :title
      row "Conference Manager" do |conference|
        conference.admin_user.full_name
      end
      row "School" do |conference|
        conference.admin_user.school
      end
      row "Committees" do |conference|
        conference.committees.map{ |p| p.name }.join('<br />').html_safe
      end
      row :start_date
      row :end_date
      row :description
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end
end