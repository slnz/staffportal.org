 ActiveAdmin.register Week6 do
  controller do
    authorize_resource

    def active_admin_collection
      super.accessible_by current_ability
    end
  end

  actions :index, :show

  batch_action :Toggle_coach_confirm do |selection|
    Week6.find(selection).each do |week6|
      week6.confirmed_coach = !week6.confirmed_coach
      week6.save
    end
    redirect_to collection_path, :notice => "Toggled selected confirmation as Coach!"
  end

  batch_action :Toggle_hr_confirm do |selection|
    Week6.find(selection).each do |week6|
      week6.confirmed_hr = !week6.confirmed_hr
      week6.save
    end
    redirect_to collection_path, :notice => "Toggled selected confirmation as HR!"
  end

  menu :parent => "Bootcamp", :label => "6 Weeks Until Bootcamp"

  index :title => "6 Weeks Until Bootcamp" do |week6|
    selectable_column
    #column("Admin")   {|tasklist| tasklist.user.bootcamp_coach.username if !tasklist.user.bootcamp_coach.nil? }
    column ("Status")   {|tasklist| status_tag(tasklist.completed) }
    column :user
    column ("Assignments") {|tasklist| tasklist.assignments_remaining }
    column ("Tasks") {|tasklist| tasklist.tasks_remaining }
    column ("Coach") { |tasklist|
        if tasklist.confirmed_coach
          status_tag("CONFIRMED", "green")
        else
          status_tag("UNCONFIRMED", "orange")
        end }
    column ("HR") { |tasklist|
        if tasklist.confirmed_hr
          status_tag("CONFIRMED", "green")
        else
          status_tag("UNCONFIRMED", "orange")
        end }
    default_actions
  end

  show :title => :username do |week6|
    attributes_table do
      row ("listen_to_attitude_message") {
        if week6.listen_to_attitude_message
          status_tag("COMPLETED")
        else
          status_tag("IN PROGRESS")
        end }
      row ("memorize_prayer_sheet_passage") {
        if week6.memorize_prayer_sheet_passage
          status_tag("COMPLETED")
        else
          status_tag("IN PROGRESS")
        end }
      row ("prayer_sheet") {
        if week6.prayer_sheet
          status_tag("COMPLETED")
        else
          status_tag("IN PROGRESS")
        end }
      row ("review_how_to_get_contacts_faster_than_you_can_use_them") {
        if week6.review_how_to_get_contacts_faster_than_you_can_use_them
          status_tag("COMPLETED")
        else
          status_tag("IN PROGRESS")
        end }
      row ("review_purpose_of_dmpd_training") {
        if week6.review_purpose_of_dmpd_training
          status_tag("COMPLETED")
        else
          status_tag("IN PROGRESS")
        end }
      row ("share_call_testimony") {
        if week6.share_call_testimony
          status_tag("COMPLETED")
        else
          status_tag("IN PROGRESS")
        end }
      row ("share_salvation_testimony") {
        if week6.share_salvation_testimony
          status_tag("COMPLETED")
        else
          status_tag("IN PROGRESS")
        end }
      row ("call_testimony") {
        if week6.call_testimony
          status_tag("COMPLETED")
        else
          status_tag("IN PROGRESS")
        end }
      row ("salvation_testimony") {
        if week6.salvation_testimony
          status_tag("COMPLETED")
        else
          status_tag("IN PROGRESS")
        end }
      row ("discipleship_story_1") { week6.discipleship_story_1.html_safe }
      row ("discipleship_story_2") { week6.discipleship_story_2.html_safe }
      row ("discipleship_story_3") { week6.discipleship_story_3.html_safe }
      row ("victory_story_1") { week6.victory_story_1.html_safe }
      row ("victory_story_2") { week6.victory_story_2.html_safe }
      row ("confirmed_coach") {
        if week6.confirmed_coach
          status_tag("COMPLETED")
        else
          status_tag("IN PROGRESS")
        end }
    end
    active_admin_comments
  end

  filter :user
  filter :created_at
  filter :updated_at
end
