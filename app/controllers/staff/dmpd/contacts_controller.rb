module Staff
  module Dmpd
    class ContactsController < InheritedResources::Base
      before_filter :authenticate_user!
      respond_to :html, only: [:index, :show, :update, :create, :delete]

      def create
        if params[:contact][:first_name].empty? ||
           params[:contact][:last_name].empty? ||
           params[:contact][:phone].empty?
          flash[:notice] = 'Missing Contact Field Data'.html_safe
          redirect_to dmpd_contacts_path
        else
          params[:contact][:first_name] =
            params[:contact][:first_name].capitalize
          params[:contact][:last_name] =
            params[:contact][:last_name].capitalize
          params[:contact][:phone] =
            params[:contact][:phone].gsub(/[^0-9]/, '')
          @exists =
            Contact.where(first_name: params[:contact][:first_name],
                          last_name: params[:contact][:last_name],
                          phone: params[:contact][:phone]).first
          if @exists.nil?
            @exists = Contact.where(phone: params[:contact][:phone]).first
          end
          if @exists.nil?
            super
          else
            flash[:notice] =
              'Contact already claimed by ' +
              "<a href=\"mailto:#{@exists.user.username}\">" +
              "#{@exists.user.username}</a>".html_safe
            redirect_to dmpd_contacts_path
          end
        end
      end

      def show
        flash[:notice] = 'Contact Created'
        redirect_to dmpd_contacts_path
      end

      def destroy
        Contact.find(params[:id]).destroy
        flash[:notice] = 'Contact Removed'
        redirect_to dmpd_contacts_path
      end
    end
  end
end
