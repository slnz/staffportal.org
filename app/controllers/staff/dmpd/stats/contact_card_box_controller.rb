module Staff
  module Dmpd
    module Stats
      class ContactCardBoxController < InheritedResources::Base
        before_filter :authenticate_user!

        add_breadcrumb 'dmpd', :staff_dmpd_root_path
        add_breadcrumb 'wcs', :staff_dmpd_stats_root_path
        add_breadcrumb 'contact card box',
                       :staff_dmpd_stats_contact_card_box_index_path
        def index
          @late = current_user.late_contact_card_box
          @contact_card_box = current_user.contact_card_box
        end

        def new
          add_breadcrumb 'add',
                         :new_staff_dmpd_stats_contact_card_box_path
          @contact_card_box = ContactCardBox.new
          hide_weeks = [-1]
          current_user.contact_card_box.each do |ccb|
            hide_weeks << ccb.week_id
          end
          @available_weeks =
            Week.where('id not in (?) and date_finished < ?',
                       hide_weeks,
                       Time.now.to_date + 1.week)
          @contact_card_box.week = @available_weeks.first
        end

        def edit
          add_breadcrumb 'edit',
                         :edit_staff_dmpd_stats_contact_card_box_path
          super
        end

        def create
          create!(notice:
                  'Nice job creating your weekly contact card statistics.') do
            staff_dmpd_stats_contact_card_box_index_path
          end
        end

        def update
          update!(notice:
                  'Nice job updating your weekly contact card statistics.') do
            staff_dmpd_stats_contact_card_box_index_path
          end
        end

        protected

        def begin_of_association_chain
          current_user
        end
      end
    end
  end
end
