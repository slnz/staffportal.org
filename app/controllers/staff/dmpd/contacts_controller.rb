module Staff
  module Dmpd
    class ContactsController < StaffController
      before_action :authenticate_user!
      add_breadcrumb 'dmpd', :dmpd_path
      add_breadcrumb 'contacts', :dmpd_contacts_path
      ::Dmpd::Contact.categories.keys.each do |category|
        has_scope category.to_sym, type: :boolean
      end
      ::Dmpd::Contact.statuses.keys.each do |category|
        has_scope category.to_sym, type: :boolean
      end

      def index
        load_contacts
      end

      def show
        load_contact
        add_breadcrumb @contact.initials.upcase, dmpd_contact_path(@contact)
      end

      def new
        build_contact
        add_breadcrumb 'new', :new_dmpd_contact_path
      end

      def create
        build_contact
        return flash[:success] = 'Successfully added your contact' if save_contact
        flash.now[:error] = 'There was a problem adding your contact'
        add_breadcrumb 'new', :new_dmpd_contact_path
        render action: :new
      end

      def edit
        load_contact
        build_contact
        add_breadcrumb @contact.initials.upcase, dmpd_contact_path(@contact)
        add_breadcrumb 'edit', edit_dmpd_contact_path(@contact)
      end

      def update
        load_contact
        build_contact
        return flash[:success] = 'Successfully updated your contact' if save_contact
        flash.now[:error] = 'There was a problem updating your contact'
        add_breadcrumb 'edit', edit_dmpd_contact_path(@contact)
        render action: :edit
      end

      def destroy
        load_contact
        @contact.destroy
        flash[:success] = 'Successfully deleted your contact'
        redirect_to dmpd_contacts_path
      end

      protected

      def load_contacts
        @q ||= apply_scopes(contact_scope).search(params[:q])
        @q.sorts = 'first_name asc' if @q.sorts.empty?
        @contacts ||= @q.result(distinct: true).page params[:page]
      end

      def load_contact
        @contact ||= contact_scope.find(params[:id])
      end

      def build_contact
        @contact ||= contact_scope.build
        @contact.attributes = contact_params
      end

      def save_contact
        redirect_to @contact if @contact.save
      end

      def contact_scope
        current_user.contacts
      end

      def current_user
        super.as(:trainee)
      end

      def contact_params
        contact_params = params[:dmpd_contact]
        return {} unless contact_params
        contact_params.permit(
            :first_name,
            :last_name,
            :priority_code,
            :new_church,
            :church,
            :email,
            :status,
            :primary_phone,
            :home_phone,
            :office_phone,
            :referer_id,
            :how_knows,
            :occupation,
            :address,
            :children,
            :anniversary
          )
      end
    end
  end
end
