ActiveAdmin.register Resolution do

 form do |f|
    f.inputs "Resolution Details" do
      f.input :title
      f.input :conference_id, :as => :select, :collection => Conference.all, :required => true
      f.input :committee_id, :as => :select, :collection => Committee.all, :required => true
      f.input :country_id, :as => :select, :collection => Country.all, :required => true
      f.input :document
    end

    # f.inputs "Conference Status" do
    #   f.input :is_active, :label => "Active?"
    # end
    f.actions
  end

end
