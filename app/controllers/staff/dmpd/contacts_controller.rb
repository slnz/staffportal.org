module Staff
  module Dmpd
    class ContactsController < ApplicationController
      before_filter :authenticate_user!
      add_breadcrumb 'dmpd', :dmpd_root_path
      add_breadcrumb 'contacts', :dmpd_contacts_path

      def index
        load_contacts
      end

      def show
        load_contact
      end

      def new
        build_contact
      end

      def create
        build_contact
        save_contact || render('new')
      end

      def edit
        load_contact
        build_contact
      end

      def update
        load_contact
        build_contact
        save_contact || render('edit')
      end

      def destroy
        load_contact
        @contact.destroy
        redirect_to dmpd_contacts_path
      end

      protected

      def load_contacts
        @q ||= contact_scope.search(params[:q])
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
        return unless @contact.save
        redirect_to [:dmpd, @contact]
      end

      def contact_scope
        current_user.contacts
      end

      def contact_params
        contact_params = params[:contact]
        return {} unless contact_params
        contact_params.permit(
            :first_name,
            :last_name,
            :priority_code,
            :new_church,
            :church,
            :email,
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
