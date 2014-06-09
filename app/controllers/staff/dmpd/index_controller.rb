module Staff
  module Dmpd
    class IndexController < ApplicationController
      before_filter :authenticate_user!

      add_breadcrumb 'dmpd', :dmpd_root_path
      def index
      end

      def contacts
        add_breadcrumb 'contacts', :dmpd_contacts_path
        @contacts = current_user.contacts.order(:created_at).reverse_order
      end
    end
  end
end
