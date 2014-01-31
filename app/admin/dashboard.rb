ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  content :title => proc{ I18n.t("active_admin.dashboard") } do
    # div :class => "blank_slate_container", :id => "dashboard_default_message" do
    #   span :class => "blank_slate" do
    #     span I18n.t("active_admin.dashboard_welcome.welcome")
    #     small I18n.t("active_admin.dashboard_welcome.call_to_action")
    #   end
    # end

  if (current_admin_user.role != 'Conference Manager')

    columns do
      column do
          panel "Instructions" do
            para ""
            para "1. Create an account for the Conference Manager who will be managing the conference:"
            para "Go to \"Admin Users\" from the menu. Click on \"New Admin User\". Enter the email address, create a password, enter the name of the host school, and select Conference Manager as the role. Click on \"Create Admin user\"."
            para "2. Create a Conference:"
            para "Go to \"Conferences\" from the menu. Click on \"New Conference\". Enter the conference title, select the host school, enter the start date and end date of the conference, and select the committees that will be present in the conference. Click on \"Create Conference\"."
            para "3. Inform the Conference Manager:"
            para "Notify the Conference Manager that their account and conference has been created, and also send them their account details."
          end
      end

      column do
        panel "Recent Conferences" do
          ul do
            Conference.last(5).reverse.map do |conference|
              li link_to(conference.title, admin_conference_path(conference))
            end
          end
        end
      end

      column do
        panel "Recently Created Users" do
          ul do
            User.last(5).reverse.map do |user|
              li link_to(user.username, admin_user_path(user))
            end
          end
        end
      end
    end
  else
    columns do
      column do
          panel "Instructions" do
            para ""
            para "1. Verify Conference Details:"
            para "Go to \"Conferences\" from the menu. Verify that the conference details provided are all correct. If there is something you want to change, please contact the Admin who gave you your account details."
            para "2. Create user accounts for the users you want to grant access to this system:"
            para "Go to \"Users\" from the menu. Click on \"New User\". Select your conference, select the roles/abilities of the user, create a username and password. Click on \"Create User\"."
            para "3. Inform the users:"
            para "Notify the users that their accounts have been created, and also send them their login details."
          end
      end
    end    
  end

  end # content
end
