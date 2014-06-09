module Staff
  module Dmpd
    module Stats
      class SupportRaisingDevelopmentController < InheritedResources::Base
        before_filter :authenticate_user!

        add_breadcrumb 'dmpd', :dmpd_root_path
        add_breadcrumb 'wcs', :dmpd_stats_root_path
        add_breadcrumb 'weekly calling chart',
                       :dmpd_stats_support_raising_development_index_path
        def index
          @late = current_user.late_support_raising_developments
          @support_raising_development =
            current_user.support_raising_developments
        end

        def new
          add_breadcrumb 'add',
                         :new_dmpd_stats_support_raising_development_path
          @support_raising_development = SupportRaisingDevelopment.new
          hide_weeks = [-1]
          current_user.support_raising_developments.each do |srd|
            hide_weeks << srd.week_id
          end
          @available_weeks =
            Week.where('id not in (?) and date_finished < ?',
                       hide_weeks,
                       Time.now.to_date + 1.week)
          @support_raising_development.week = @available_weeks.first
        end

        def edit
          add_breadcrumb 'edit',
                         :edit_dmpd_stats_support_raising_development_path
          super
        end

        def create
          create!(notice: 'Nice job creating your weekly calling chart.') do
            dmpd_stats_support_raising_development_index_path
          end
        end

        def update
          update!(notice: 'Nice job updating your weekly calling chart.') do
            dmpd_stats_support_raising_development_index_path
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
