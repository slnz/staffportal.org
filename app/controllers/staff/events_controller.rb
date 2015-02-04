module Staff
  class EventsController < StaffController
    add_breadcrumb 'events', :events_path

    def index
      load_events
      decorate_events
    end

    def show
      load_event
      decorate_event
      add_breadcrumb @event.name, :event_path
    end

    protected

    def load_events
      @events ||= event_scope
    end

    def load_event
      @event ||= event_scope.find(params[:id])
    end

    def decorate_events
      @events = @events.decorate
    end

    def decorate_event
      @event = @event.decorate
    end

    def event_scope
      current_user
      ::Event.where('finish_date > ?', Date.today).order(:start_date)
    end

    def user_type
      :attendee
    end
  end
end
