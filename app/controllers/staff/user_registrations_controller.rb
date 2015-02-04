module Staff
  class UserRegistrationsController < StaffController
    before_action :load_event
    before_action :load_user

    def show
      return redirect_to action: :new unless load_registration
      add_breadcrumb 'register', :event_user_registrations_path
    end

    def new
      return redirect_to action: :show if registration_scope.first
      build_registration
      add_breadcrumb 'register', :new_event_user_registrations_path
    end

    def edit
      load_registration
      build_registration
      add_breadcrumb 'register', :event_user_registrations_path
      add_breadcrumb 'edit', :edit_event_user_registrations_path
    end

    def create
      build_registration
      save_registration
      flash[:success] = "Successfully registered for #{@event.name}"
    end

    def update
      load_event
      load_registration
      build_registration
      save_registration
      flash[:success] = 'Successfully updated your registration'
    end

    def destroy
      load_registration
      @registration.destroy
      flash[:info] = 'Successfully removed your registration'
      redirect_to event_path(@event)
    end

    protected

    def load_event
      @event ||= event_scope.find(params[:event_id])
      add_breadcrumb 'events', :events_path
      add_breadcrumb @event.name, event_path(@event)
    end

    def load_user
      return unless current_user.has_role? :contact
      @user ||= current_user.as(:contact).decorate
    end

    def event_scope
      Event
    end

    def load_registration
      @registration ||= registration_scope.first
    end

    def build_registration
      @registration ||= registration_scope.build
      @registration.attributes = registration_params
    end

    def save_registration
      redirect_to action: :show if @registration.save
    end

    def registration_scope
      current_user.registrations.where(event: @event)
    end

    def user_type
      :attendee
    end

    def registration_params
      return {} unless params[:user_registration]
      Params.permit(params)
    end

    class Params
      def self.permit(params)
        params.require(:user_registration)
          .permit(:comments)
      end
    end
  end
end
