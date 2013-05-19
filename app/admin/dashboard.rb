ActiveAdmin.register_page "Dashboard", :namespace => :admin do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }
end
