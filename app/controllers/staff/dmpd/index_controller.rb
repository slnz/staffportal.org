module Staff
  module Dmpd
    class IndexController < ApplicationController
      before_filter :authenticate_user!
      def index
        @week6 = Week6.where(user_id: current_user.id).first_or_create
        @week5 = Week5.where(user_id: current_user.id).first_or_create
        @week4 = Week4.where(user_id: current_user.id).first_or_create
        @week3 = Week3.where(user_id: current_user.id).first_or_create
        @week2 = Week2.where(user_id: current_user.id).first_or_create
        @week1 = Week1.where(user_id: current_user.id).first_or_create
      end

      def contacts
        @contacts = current_user.contacts.order(:created_at).reverse_order
      end
    end
  end
end
