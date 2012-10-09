ActiveAdmin.register_page "Dashboard", :namespace => :coach do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  content :title => proc{ I18n.t("active_admin.dashboard") } do
    div :class => "blank_slate_container", :id => "dashboard_default_message" do
      span :class => "blank_slate" do
        span "Welcome To the Coaches Bootcamp Dashboard"
        small "To get started click on the Bootcamp menu above."
      end
    end
  end # content
end
